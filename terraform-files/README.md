first command : terraform init 
then install azure cli in wsl / ubuntu / windows
then login to az login (cli login)
then terraform plan 



i have used these terraform commands

# Initialize with the new provider
terraform init

# Plan the deployment
terraform plan

# Apply the changes
terraform apply



i got my ssh key by this command

terraform output -raw ssh_private_key > nanite-key.pem

then i connected to vm 


later i have distroyed infro with command terraform destroy and then used terraform apply 


after using terraform apply i got new vm ip address then i need new ssh key  

to get new ssh key i get 

terraform output -raw ssh_private_key > nanite-key.pem
