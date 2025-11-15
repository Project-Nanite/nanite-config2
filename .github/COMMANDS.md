# 🚀 Quick Command Reference

Useful commands for working with the CI/CD pipelines.

## 📦 Git Commands

### Initial Deployment
```bash
# Add all CI/CD files
git add .github/ trivy-outputs/ CI-CD-GUIDE.md DEPLOYMENT-CHECKLIST.md .gitignore

# Commit
git commit -m "feat: Add CI/CD pipelines with Trivy scanning and ISO building"

# Push to trigger workflows
git push origin main
```

### Create Release with ISO
```bash
# Create and push a tag (triggers ISO build + release)
git tag v1.0.0
git push origin v1.0.0

# Or with annotation
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

### Update Workflows
```bash
# Edit workflow files
nano .github/workflows/trivy-security-scan.yml
nano .github/workflows/build-iso.yml

# Commit and push
git add .github/workflows/
git commit -m "chore: Update CI/CD workflows"
git push
```

## 🔍 Validation Commands

### Validate YAML Syntax
```bash
# Using Python
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/trivy-security-scan.yml'))"
python3 -c "import yaml; yaml.safe_load(open('.github/workflows/build-iso.yml'))"

# Using yamllint (if installed)
yamllint .github/workflows/*.yml
```

### Check File Structure
```bash
# List all workflow files
find .github -type f

# Show workflow file sizes
ls -lh .github/workflows/

# Display directory tree
tree .github
```

## 🔒 Trivy Commands (Local Testing)

### Install Trivy Locally
```bash
# Debian/Ubuntu
sudo apt-get install wget apt-transport-https gnupg lsb-release
wget -qO - https://aquasecurity.github.io/trivy-repo/deb/public.key | sudo apt-key add -
echo "deb https://aquasecurity.github.io/trivy-repo/deb $(lsb_release -sc) main" | sudo tee -a /etc/apt/sources.list.d/trivy.list
sudo apt-get update
sudo apt-get install trivy
```

### Run Trivy Scan Locally
```bash
# Scan filesystem
trivy fs .

# Scan with specific severity
trivy fs --severity CRITICAL,HIGH .

# Generate JSON output
trivy fs --format json --output trivy-results.json .

# Generate table output
trivy fs --format table --output trivy-results.txt .
```

## 🚀 ISO Building Commands (Local Testing)

### Install live-build
```bash
# On Debian/Ubuntu
sudo apt-get update
sudo apt-get install -y live-build debootstrap curl wget xorriso \
  syslinux squashfs-tools genisoimage
```

### Build ISO Locally
```bash
# Clean previous builds
sudo lb clean --purge

# Configure
sudo lb config

# Build
sudo lb build

# Check generated files
ls -lh *.iso
```

### Verify ISO
```bash
# Check ISO integrity
file nanite-debian-*.iso

# Mount ISO (read-only)
sudo mkdir -p /mnt/iso
sudo mount -o loop nanite-debian-*.iso /mnt/iso
ls -la /mnt/iso
sudo umount /mnt/iso

# Test ISO with QEMU (if installed)
qemu-system-x86_64 -cdrom nanite-debian-*.iso -boot d -m 2048
```

## 📊 GitHub CLI Commands

### Install GitHub CLI
```bash
# Debian/Ubuntu
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Authenticate
gh auth login
```

### Workflow Commands
```bash
# List workflows
gh workflow list

# View workflow runs
gh run list

# View specific workflow runs
gh run list --workflow=trivy-security-scan.yml
gh run list --workflow=build-iso.yml

# Watch a workflow run
gh run watch

# View workflow run details
gh run view <run-id>

# Download artifacts
gh run download <run-id>

# Trigger workflow manually
gh workflow run trivy-security-scan.yml
gh workflow run build-iso.yml
```

### Release Commands
```bash
# List releases
gh release list

# Create release
gh release create v1.0.0 nanite-debian-*.iso --title "Release v1.0.0" --notes "Release notes"

# Download release assets
gh release download v1.0.0

# View release
gh release view v1.0.0
```

## 🔐 Checksum Commands

### Generate Checksums
```bash
# SHA256
sha256sum nanite-debian-*.iso > nanite-debian.iso.sha256

# MD5
md5sum nanite-debian-*.iso > nanite-debian.iso.md5

# Both at once
sha256sum nanite-debian-*.iso | tee nanite-debian.iso.sha256
md5sum nanite-debian-*.iso | tee nanite-debian.iso.md5
```

### Verify Checksums
```bash
# Verify SHA256
sha256sum -c nanite-debian.iso.sha256

# Verify MD5
md5sum -c nanite-debian.iso.md5
```

## 💿 ISO Writing Commands

### Write to USB (Linux)
```bash
# Find USB device
lsblk

# Write ISO (replace /dev/sdX with your USB device)
sudo dd if=nanite-debian-*.iso of=/dev/sdX bs=4M status=progress && sync

# Verify write
sudo dd if=/dev/sdX bs=4M count=1000 | md5sum
```

### Write to USB (macOS)
```bash
# Find USB device
diskutil list

# Unmount USB
diskutil unmountDisk /dev/diskX

# Write ISO
sudo dd if=nanite-debian-*.iso of=/dev/rdiskX bs=4m && sync

# Eject
diskutil eject /dev/diskX
```

### Write to USB (Windows)
```powershell
# Use Rufus, Etcher, or similar tool
# Or use PowerShell with USB Image Tool
```

## 📝 Log Commands

### View Workflow Logs
```bash
# Using gh CLI
gh run view <run-id> --log

# Download logs
gh run view <run-id> --log > workflow.log

# View failed runs
gh run list --status failure
```

### View Local Build Logs
```bash
# View live-build log
tail -f build.log

# Search for errors
grep -i error build.log
grep -i fail build.log

# View Trivy results
cat trivy-outputs/trivy-results.txt
```

## 🧹 Cleanup Commands

### Clean Build Artifacts
```bash
# Remove ISO files
rm -f *.iso *.img *.zsync

# Clean live-build
sudo lb clean --purge

# Remove Trivy outputs (keep .gitkeep)
rm -f trivy-outputs/*.pdf trivy-outputs/*.json trivy-outputs/*.txt trivy-outputs/*.html trivy-outputs/*.sarif
```

### Clean Git
```bash
# Remove untracked files
git clean -fd

# Reset to last commit
git reset --hard HEAD

# Prune old branches
git fetch --prune
git branch -vv | grep ': gone]' | awk '{print $1}' | xargs git branch -D
```

## 🔄 Update Commands

### Update Dependencies
```bash
# Update apt packages
sudo apt-get update
sudo apt-get upgrade

# Update live-build
sudo apt-get install --only-upgrade live-build

# Update Trivy
sudo apt-get install --only-upgrade trivy
```

### Update Workflow Actions
```bash
# Check for action updates
# Edit .github/workflows/*.yml and update version tags
# Example: actions/checkout@v3 -> actions/checkout@v4

# Commit updates
git add .github/workflows/
git commit -m "chore: Update GitHub Actions versions"
git push
```

## 📊 Monitoring Commands

### Check Disk Space
```bash
# Overall disk usage
df -h

# Directory sizes
du -sh .github/ trivy-outputs/ config/

# Find large files
find . -type f -size +100M -exec ls -lh {} \;
```

### Check Workflow Status
```bash
# Using gh CLI
gh run list --limit 10

# Check specific workflow
gh run list --workflow=build-iso.yml --limit 5

# View latest run
gh run view $(gh run list --limit 1 --json databaseId --jq '.[0].databaseId')
```

## 🎯 Quick Aliases (Optional)

Add these to your `~/.bashrc` or `~/.zshrc`:

```bash
# Workflow aliases
alias ghw='gh workflow list'
alias ghr='gh run list'
alias ghv='gh run view'
alias ghd='gh run download'

# ISO build aliases
alias iso-clean='sudo lb clean --purge && rm -f *.iso *.img *.zsync'
alias iso-config='sudo lb config'
alias iso-build='sudo lb build'
alias iso-full='iso-clean && iso-config && iso-build'

# Trivy aliases
alias trivy-scan='trivy fs --severity CRITICAL,HIGH .'
alias trivy-report='trivy fs --format json --output trivy-outputs/trivy-results.json .'

# Git aliases
alias gac='git add . && git commit -m'
alias gp='git push'
alias gs='git status'
alias gl='git log --oneline -10'
```

## 🔗 Useful URLs

Replace `USERNAME` and `REPO` with your values:

```
# Repository
https://github.com/USERNAME/REPO

# Actions
https://github.com/USERNAME/REPO/actions

# Workflows
https://github.com/USERNAME/REPO/actions/workflows/trivy-security-scan.yml
https://github.com/USERNAME/REPO/actions/workflows/build-iso.yml

# Security
https://github.com/USERNAME/REPO/security

# Releases
https://github.com/USERNAME/REPO/releases

# Settings
https://github.com/USERNAME/REPO/settings
```

---

**Tip:** Bookmark this file for quick reference!

