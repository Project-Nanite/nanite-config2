# 🚀 CI/CD Pipelines Guide

This document provides a quick reference for the GitHub Actions CI/CD pipelines in this repository.

## 📋 Table of Contents
- [Overview](#overview)
- [Trivy Security Scanning](#trivy-security-scanning)
- [ISO Building Pipeline](#iso-building-pipeline)
- [Quick Start](#quick-start)
- [FAQ](#faq)

---

## Overview

This repository includes two main CI/CD pipelines:

1. **Trivy Security Scan** - Automated vulnerability scanning with PDF reports
2. **Build Debian ISO** - Automated ISO building on Debian with download capability

Both pipelines are located in `.github/workflows/` and run automatically on code changes.

---

## 🔒 Trivy Security Scanning

### What it does
- Scans the codebase for security vulnerabilities
- Generates reports in multiple formats (PDF, JSON, HTML, SARIF)
- Uploads results to GitHub Security tab
- Stores PDF reports in `trivy-outputs/` folder

### When it runs
- ✅ On push to `main`, `master`, or `develop` branches
- ✅ On pull requests
- ✅ Daily at 2 AM UTC (scheduled)
- ✅ Manual trigger (workflow_dispatch)

### Output Location
```
trivy-outputs/
├── trivy-report.pdf          # 📄 Main PDF report
├── trivy-results.json        # 📊 JSON format
├── trivy-results.txt         # 📝 Table format
├── trivy-results.sarif       # 🔐 GitHub Security format
└── trivy-report.html         # 🌐 HTML format
```

### How to run manually
```bash
# Via GitHub UI:
# 1. Go to Actions tab
# 2. Select "Trivy Security Scan"
# 3. Click "Run workflow"
# 4. Select branch and click "Run workflow"
```

### Viewing Results
1. **In Repository**: Check `trivy-outputs/trivy-report.pdf`
2. **In Artifacts**: Download from Actions → Workflow run → Artifacts
3. **In Security Tab**: Code → Security → Code scanning alerts

---

## 🚀 ISO Building Pipeline

### What it does
- Builds a custom Debian ISO using live-build
- Runs on a **Debian container** (not Ubuntu)
- Executes `lb config` and `lb build` commands
- Generates checksums (SHA256 and MD5)
- Creates downloadable artifacts
- Automatically creates GitHub releases on tag push

### When it runs
- ✅ On push to `main` or `master` branches
- ✅ On pull requests
- ✅ Manual trigger with Debian version selection
- ✅ On tag push (creates release)

### Build Process
```
1. Setup Debian container (bookworm)
2. Install live-build and dependencies
3. Clean previous builds
4. Run lb config
5. Run lb build
6. Generate checksums
7. Create artifacts
8. Upload ISO for download
```

### Output Files
```
nanite-debian-YYYYMMDD-HHMMSS.iso         # 💿 Bootable ISO
nanite-debian-YYYYMMDD-HHMMSS.iso.sha256  # 🔐 SHA256 checksum
nanite-debian-YYYYMMDD-HHMMSS.iso.md5     # 🔐 MD5 checksum
RELEASE_INFO.md                           # 📋 Build information
build.log                                 # 📝 Complete build log
```

### How to download the ISO

#### Method 1: From Artifacts (Recommended)
1. Go to **Actions** tab
2. Click on **Build Debian ISO** workflow
3. Select the latest successful run
4. Scroll to **Artifacts** section
5. Download **debian-iso-build**
6. Extract the ZIP file

#### Method 2: From Releases (Tag builds only)
1. Go to **Releases** section
2. Download the ISO from the latest release
3. Verify checksums

### Manual Build with Custom Debian Version
```bash
# Via GitHub UI:
# 1. Go to Actions tab
# 2. Select "Build Debian ISO"
# 3. Click "Run workflow"
# 4. Select Debian version:
#    - bookworm (Debian 12, default)
#    - bullseye (Debian 11)
#    - trixie (Debian 13, testing)
#    - sid (unstable)
# 5. Click "Run workflow"
```

### Creating a Release
To automatically create a GitHub release with the ISO:

```bash
# Create and push a tag
git tag v1.0.0
git push origin v1.0.0

# The workflow will automatically:
# 1. Build the ISO
# 2. Create a GitHub release
# 3. Attach the ISO and checksums
```

---

## 🚀 Quick Start

### First Time Setup

1. **Enable GitHub Actions**
   - Go to repository Settings → Actions → General
   - Enable "Allow all actions and reusable workflows"

2. **Set Permissions**
   - Settings → Actions → General → Workflow permissions
   - Select "Read and write permissions"
   - Check "Allow GitHub Actions to create and approve pull requests"

3. **Trigger First Run**
   ```bash
   # Push a commit to trigger both workflows
   git add .
   git commit -m "feat: Add CI/CD pipelines"
   git push origin main
   ```

### Monitoring Workflows

```bash
# Check workflow status
# Go to: https://github.com/YOUR_USERNAME/YOUR_REPO/actions

# View logs
# Click on any workflow run → Click on job → View logs
```

---

## ❓ FAQ

### Q: Where are the Trivy PDF reports stored?
**A:** In the `trivy-outputs/` folder in the repository. They're also available as artifacts in the workflow run.

### Q: How long are artifacts kept?
**A:** 
- Trivy scan results: 30 days
- ISO builds: 7 days

### Q: Can I build ISO on Ubuntu instead of Debian?
**A:** The workflow is specifically configured for Debian. Using Ubuntu may cause compatibility issues with live-build. The workflow uses a Debian container to ensure consistency.

### Q: How do I verify the ISO checksum?
**A:** 
```bash
# SHA256
sha256sum -c nanite-debian-*.iso.sha256

# MD5
md5sum -c nanite-debian-*.iso.md5
```

### Q: How do I write the ISO to a USB drive?
**A:**
```bash
# Linux/macOS
sudo dd if=nanite-debian-*.iso of=/dev/sdX bs=4M status=progress && sync

# Windows: Use Rufus or Etcher
```

### Q: Can I disable the daily Trivy scan?
**A:** Yes, edit `.github/workflows/trivy-security-scan.yml` and remove or comment out the `schedule` section.

### Q: What if the ISO build fails?
**A:** 
1. Check the workflow logs in Actions tab
2. Look for errors in the `build.log` artifact
3. Verify the `auto/config` file is correct
4. Ensure all dependencies are installed

### Q: How do I customize the ISO build?
**A:** Modify the configuration files in:
- `auto/config` - Main configuration
- `config/` directory - Packages, hooks, includes
- `build.sh` - Build script

### Q: Can I run these workflows on a fork?
**A:** Yes, but you need to:
1. Enable Actions in your fork's settings
2. Set proper permissions
3. The workflows will run automatically

### Q: How much storage do artifacts use?
**A:** 
- Trivy scans: ~1-5 MB per run
- ISO builds: ~2-4 GB per build

### Q: Can I download the ISO without GitHub account?
**A:** No for artifacts, but yes for releases. Create a release by pushing a tag, and the ISO will be publicly downloadable.

---

## 📞 Support

For issues or questions:
1. Check the workflow logs in Actions tab
2. Review the detailed README in `.github/workflows/README.md`
3. Open an issue in the repository

---

## 🔗 Useful Links

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [Debian Live Manual](https://live-team.pages.debian.net/live-manual/)
- [live-build Documentation](https://manpages.debian.org/testing/live-build/)

---

**Last Updated:** November 15, 2025

