# 🚀 Deployment Checklist

Use this checklist to ensure your CI/CD pipelines are properly configured and working.

## ✅ Pre-Deployment Checklist

### 1. Repository Settings

- [ ] **Enable GitHub Actions**
  - Go to: `Settings` → `Actions` → `General`
  - Select: "Allow all actions and reusable workflows"

- [ ] **Set Workflow Permissions**
  - Go to: `Settings` → `Actions` → `General` → `Workflow permissions`
  - Select: "Read and write permissions"
  - Check: "Allow GitHub Actions to create and approve pull requests"

- [ ] **Enable Security Features** (Optional but recommended)
  - Go to: `Settings` → `Security` → `Code security and analysis`
  - Enable: "Dependency graph"
  - Enable: "Dependabot alerts"
  - Enable: "Code scanning" (Trivy will populate this)

### 2. Branch Protection (Optional)

- [ ] **Protect Main Branch**
  - Go to: `Settings` → `Branches` → `Add branch protection rule`
  - Branch name pattern: `main` (or `master`)
  - Check: "Require status checks to pass before merging"
  - Select: "Trivy Security Scan" (after first run)

### 3. Secrets Configuration (If needed)

- [ ] **Add Secrets** (if you need custom tokens)
  - Go to: `Settings` → `Secrets and variables` → `Actions`
  - Add any required secrets (GITHUB_TOKEN is automatic)

## 📋 Post-Deployment Verification

### 1. Commit and Push

```bash
# Add all new files
git add .github/ trivy-outputs/ CI-CD-GUIDE.md .gitignore

# Commit
git commit -m "feat: Add CI/CD pipelines with Trivy scanning and ISO building"

# Push to trigger workflows
git push origin main
```

### 2. Verify Trivy Security Scan

- [ ] Go to `Actions` tab
- [ ] Click on "Trivy Security Scan" workflow
- [ ] Verify it's running or completed
- [ ] Check the workflow logs for any errors
- [ ] Verify artifacts are uploaded
- [ ] Check `trivy-outputs/` folder for PDF report
- [ ] Go to `Security` → `Code scanning` to see alerts

### 3. Verify ISO Build

- [ ] Go to `Actions` tab
- [ ] Click on "Build Debian ISO" workflow
- [ ] Verify it's running or completed
- [ ] Check the workflow logs for build progress
- [ ] Verify artifacts are uploaded
- [ ] Download the `debian-iso-build` artifact
- [ ] Extract and verify the ISO file exists
- [ ] Verify checksums are generated

### 4. Test Manual Triggers

**Trivy Scan:**
- [ ] Go to `Actions` → "Trivy Security Scan"
- [ ] Click "Run workflow"
- [ ] Select branch and run
- [ ] Verify it completes successfully

**ISO Build:**
- [ ] Go to `Actions` → "Build Debian ISO"
- [ ] Click "Run workflow"
- [ ] Select Debian version (try different versions)
- [ ] Verify it completes successfully

### 5. Test Release Creation

```bash
# Create a test tag
git tag v0.1.0-test
git push origin v0.1.0-test

# Verify:
# - ISO build workflow runs
# - GitHub release is created
# - ISO is attached to release
```

- [ ] Go to `Releases` section
- [ ] Verify release was created
- [ ] Verify ISO and checksums are attached
- [ ] Verify RELEASE_INFO.md is included

## 🔍 Troubleshooting

### Trivy Scan Issues

**Problem:** Workflow fails with permission error
- **Solution:** Check workflow permissions in Settings → Actions → General

**Problem:** PDF not generated
- **Solution:** Check workflow logs for wkhtmltopdf errors

**Problem:** No vulnerabilities shown but expected some
- **Solution:** Trivy might not find issues, or check the severity filters

### ISO Build Issues

**Problem:** Build fails with "lb: command not found"
- **Solution:** Verify the Debian container is being used (not Ubuntu)

**Problem:** Build takes too long and times out
- **Solution:** GitHub Actions has 6-hour limit. Optimize your config or use self-hosted runner

**Problem:** ISO not found after build
- **Solution:** Check build.log in artifacts for errors during lb build

**Problem:** Insufficient disk space
- **Solution:** Clean up cache or reduce ISO size in configuration

## 📊 Monitoring

### Daily Checks

- [ ] Check Trivy scan results (runs daily at 2 AM UTC)
- [ ] Review Security tab for new vulnerabilities
- [ ] Check Actions tab for failed workflows

### Weekly Checks

- [ ] Review artifact storage usage
- [ ] Clean up old artifacts if needed
- [ ] Update dependencies if vulnerabilities found

### Monthly Checks

- [ ] Test ISO build manually
- [ ] Verify ISO boots correctly
- [ ] Update workflow versions if needed
- [ ] Review and update documentation

## 🎯 Success Criteria

Your CI/CD pipelines are successfully deployed when:

- [x] Both workflow files are created and valid
- [ ] Workflows run automatically on push
- [ ] Trivy generates PDF reports in `trivy-outputs/`
- [ ] ISO builds successfully on Debian container
- [ ] Artifacts are downloadable
- [ ] No errors in workflow logs
- [ ] Security tab shows Trivy results
- [ ] ISO can be downloaded and boots correctly

## 📞 Getting Help

If you encounter issues:

1. **Check Workflow Logs**
   - Go to Actions → Select workflow run → View logs

2. **Review Documentation**
   - `CI-CD-GUIDE.md` - Quick reference
   - `.github/workflows/README.md` - Detailed docs

3. **Common Issues**
   - Permissions: Check Settings → Actions → General
   - Secrets: Verify in Settings → Secrets and variables
   - Disk space: Check workflow logs for space issues
   - Timeout: Consider using self-hosted runners for long builds

4. **GitHub Actions Documentation**
   - [Actions Docs](https://docs.github.com/en/actions)
   - [Troubleshooting](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows)

## 🎉 Next Steps

After successful deployment:

1. **Customize Workflows**
   - Adjust Trivy scan schedule
   - Modify ISO build triggers
   - Add custom build steps

2. **Set Up Notifications**
   - Configure email notifications for failures
   - Set up Slack/Discord webhooks
   - Use GitHub mobile app for alerts

3. **Optimize Builds**
   - Cache dependencies
   - Parallelize steps where possible
   - Use matrix builds for multiple versions

4. **Document Custom Changes**
   - Update CI-CD-GUIDE.md
   - Add comments in workflow files
   - Keep CHANGELOG.md updated

---

**Last Updated:** November 15, 2025

✅ **Status:** Ready for deployment

