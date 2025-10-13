variable "resource_group_name" {
  default = "nanite"
}

variable "location" {
  default = "Central India"
}

# 🔹 Create a new Resource Group for this deployment
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# 🔹 Create a new SSH key for this deployment
resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 🔹 Store the SSH key in Azure
resource "azurerm_ssh_public_key" "nanite_key" {
  name                = "nanite-key"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  public_key          = tls_private_key.ssh_key.public_key_openssh
}

# 🔹 Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
}

# 🔹 Subnet
resource "azurerm_subnet" "subnet" {
  name                 = "subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

# 🔹 Network Security Group for SSH access
resource "azurerm_network_security_group" "nsg" {
  name                = "nanite-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllPorts"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "0-65535"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# 🔹 Public IP
resource "azurerm_public_ip" "publicip" {
  name                = "public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static" # Changed to Static for consistent IP
  sku                 = "Standard"
}

# 🔹 Associate Network Security Group to Subnet
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# 🔹 Network Interface
resource "azurerm_network_interface" "nic" {
  name                = "nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.publicip.id
  }

  depends_on = [azurerm_subnet_network_security_group_association.nsg_association]
}

# 🔹 Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "nanite-vm"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  size                = "Standard_D4as_v5"
  admin_username      = "yash"

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  # 👇 Use the newly created SSH key
  admin_ssh_key {
    username   = "yash"
    public_key = azurerm_ssh_public_key.nanite_key.public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 30
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-12"
    sku       = "12"
    version   = "latest"
  }

  disable_password_authentication = true

  # Custom data script to run after VM initialization
  custom_data = base64encode(<<-EOF
#!/bin/bash
# Log all output to a file for debugging
exec > >(tee /var/log/vm-setup.log) 2>&1

echo "Starting VM setup at $(date)"

# Update system and install live-build dependencies
echo "Updating system and installing live-build tools..."
apt-get update -y
DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  live-build \
  debootstrap \
  syslinux \
  squashfs-tools \
  xorriso \
  isolinux \
  grub-pc-bin \
  grub-efi-amd64-bin \
  mtools

echo "Pre-configuring apt-cacher-ng to avoid interactive prompts..."
echo 'apt-cacher-ng apt-cacher-ng/tunnelenable boolean false' | debconf-set-selections

echo "Installing additional build tools..."
DEBIAN_FRONTEND=noninteractive apt-get install -y \
  apt-cacher-ng \
  wget \
  curl \
  git \
  rsync \
  genisoimage \
  dosfstools \
  qemu-utils \
  qemu-system-x86

# Clone the Nanite configs repository
echo "Cloning Nanite-configs repository..."
cd /home/yash
git clone https://github.com/Project-Nanite/Nanite-configs.git
chown -R yash:yash /home/yash/Nanite-configs

# Install and configure Samba
echo "Installing and configuring Samba..."
DEBIAN_FRONTEND=noninteractive apt-get install -y samba
systemctl start smbd
systemctl enable smbd

# Set permissions for Nanite-configs directory
echo "Setting permissions for Nanite-configs directory..."
chmod 777 /home/yash/Nanite-configs/

# Configure Samba share
echo "Configuring Samba share..."
cat >> /etc/samba/smb.conf << 'SAMBA_EOF'

[Sambashare]
    path = /home/yash/Nanite-configs/
    browseable = yes
    read only = no
    guest ok = yes
SAMBA_EOF

# Add Samba user with password
echo "Adding Samba user 'yash' with password..."
echo -e "y\ny" | smbpasswd -a yash

# Restart Samba service to apply configuration
echo "Restarting Samba service..."
systemctl restart smbd

echo "VM setup completed at $(date)"
echo "Setup log available at /var/log/vm-setup.log"
EOF
  )
}


