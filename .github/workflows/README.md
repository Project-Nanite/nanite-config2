# GitHub Actions Workflows

This directory contains CI/CD pipelines for the Nanite Debian project.

## 🔒 Trivy Security Scan (`trivy-security-scan.yml`)

Automated security vulnerability scanning using Trivy.

### Features
- **Comprehensive Scanning**: Scans the entire codebase for vulnerabilities
- **Multiple Output Formats**: JSON, Table, SARIF, HTML, and PDF
- **PDF Reports**: Generated reports stored in `trivy-outputs/` folder
- **GitHub Security Integration**: Results uploaded to GitHub Security tab
- **Scheduled Scans**: Runs daily at 2 AM UTC
- **Severity Levels**: Detects CRITICAL, HIGH, MEDIUM, and LOW vulnerabilities

### Triggers
- Push to `main`, `master`, or `develop` branches
- Pull requests to `main`, `master`, or `develop` branches
- Daily schedule (2 AM UTC)
- Manual workflow dispatch

### Output Files
All scan results are saved in the `trivy-outputs/` directory:
- `trivy-report.pdf` - Main PDF report with formatted vulnerabilities
- `trivy-results.json` - JSON format for programmatic access
- `trivy-results.txt` - Human-readable table format
- `trivy-results.sarif` - SARIF format for GitHub Security
- `trivy-report.html` - HTML version of the report

### Artifacts
- **Name**: `trivy-scan-results`
- **Retention**: 30 days
- **Contents**: All scan results in multiple formats

### How to Use
1. **Automatic**: The workflow runs automatically on push/PR
2. **Manual**: Go to Actions → Trivy Security Scan → Run workflow
3. **View Results**: 
   - Check the `trivy-outputs/` folder in the repository
   - Download artifacts from the workflow run
   - View in GitHub Security tab (Code → Security → Code scanning)

---

## 🚀 Build Debian ISO (`build-iso.yml`)

Builds a custom Debian ISO using live-build on a Debian container.

### Features
- **Native Debian Build**: Runs on Debian bookworm container (not Ubuntu)
- **Privileged Container**: Full access for ISO building operations
- **Live-build Integration**: Uses `lb config` and `lb build` commands
- **Automated Naming**: ISOs named with timestamp (e.g., `nanite-debian-20250115-143022.iso`)
- **Checksum Generation**: Automatic SHA256 and MD5 checksums
- **Downloadable Artifacts**: ISO files available for download
- **Release Creation**: Automatic GitHub releases on tag push
- **Build Logs**: Complete build logs included in artifacts

### Triggers
- Push to `main` or `master` branches
- Pull requests to `main` or `master` branches
- Manual workflow dispatch (with Debian version selection)
- Tag pushes (creates GitHub release)

### Workflow Steps
1. **Setup**: Install git and dependencies on Debian container
2. **Install live-build**: Install all required packages for ISO building
3. **Clean**: Remove previous build artifacts
4. **Configure**: Run `lb config` to configure the build
5. **Build**: Run `lb build` to create the ISO
6. **Package**: Rename, generate checksums, create release info
7. **Upload**: Upload ISO as artifact and optionally create release

### Build Configuration
- **Base OS**: Debian bookworm (configurable)
- **Architecture**: amd64
- **Container**: Debian official image with privileged mode
- **Dependencies**: live-build, debootstrap, xorriso, squashfs-tools, etc.

### Output Files
- `nanite-debian-YYYYMMDD-HHMMSS.iso` - The bootable ISO file
- `nanite-debian-YYYYMMDD-HHMMSS.iso.sha256` - SHA256 checksum
- `nanite-debian-YYYYMMDD-HHMMSS.iso.md5` - MD5 checksum
- `RELEASE_INFO.md` - Build information and instructions
- `build.log` - Complete build log

### Artifacts
- **Name**: `debian-iso-build`
- **Retention**: 7 days
- **Contents**: ISO file, checksums, and build log
- **Compression**: None (level 0) for faster downloads

### How to Download ISO
1. Go to **Actions** tab in GitHub
2. Click on the **Build Debian ISO** workflow
3. Select the workflow run you want
4. Scroll down to **Artifacts** section
5. Download **debian-iso-build** (contains the ISO)
6. Extract the ZIP file to get the ISO

### Manual Build Options
When triggering manually, you can select:
- `bookworm` (default, Debian 12)
- `bullseye` (Debian 11)
- `trixie` (Debian 13, testing)
- `sid` (unstable)

### Creating a Release
To create a GitHub release with the ISO:
1. Create and push a tag:
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
2. The workflow will automatically create a release with the ISO attached

### Verifying the ISO
After downloading, verify the checksum:

```bash
# SHA256
sha256sum -c nanite-debian-*.iso.sha256

# MD5
md5sum -c nanite-debian-*.iso.md5
```

### Writing ISO to USB
```bash
# Linux
sudo dd if=nanite-debian-*.iso of=/dev/sdX bs=4M status=progress && sync

# macOS
sudo dd if=nanite-debian-*.iso of=/dev/diskX bs=4m && sync

# Windows
# Use Rufus, Etcher, or similar tool
```

---

## 📋 Workflow Status

Check the status of workflows:
- Go to the **Actions** tab in the repository
- View recent runs and their status
- Download artifacts from completed runs
- View logs for debugging

## 🛠️ Maintenance

### Updating Workflows
1. Edit the YAML files in `.github/workflows/`
2. Test changes on a feature branch
3. Merge to main after verification

### Troubleshooting
- **Build Failures**: Check the workflow logs in Actions tab
- **Permission Issues**: Ensure repository has proper permissions set
- **Artifact Issues**: Check retention days and storage limits
- **ISO Build Issues**: Review `build.log` in the artifacts

## 📚 Additional Resources
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Trivy Documentation](https://aquasecurity.github.io/trivy/)
- [Debian Live Build Manual](https://live-team.pages.debian.net/live-manual/)
- [live-build Documentation](https://manpages.debian.org/testing/live-build/)

---

**Note**: Both workflows require appropriate GitHub Actions permissions. Ensure the repository settings allow workflow runs and artifact uploads.

