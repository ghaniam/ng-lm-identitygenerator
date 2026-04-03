# Security scan script using Trivy
# Usage: .\scan-security.ps1 [-FailOnVulnerabilities]
#
# Parameters:
#   -FailOnVulnerabilities: Exit with error code if vulnerabilities found (default: false)

param(
    [switch]$FailOnVulnerabilities = $false
)

Write-Host "🔍 Running Trivy security scan..." -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

# Check if Trivy is installed
$trivyInstalled = Get-Command trivy -ErrorAction SilentlyContinue

if (-not $trivyInstalled) {
    Write-Host "❌ Trivy is not installed." -ForegroundColor Red
    Write-Host ""
    Write-Host "Install Trivy:" -ForegroundColor Yellow
    Write-Host "  Windows (Chocolatey): choco install trivy" -ForegroundColor Yellow
    Write-Host "  Windows (Scoop):      scoop install trivy" -ForegroundColor Yellow
    Write-Host "  Windows (Manual):     https://github.com/aquasecurity/trivy/releases" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Or use Docker:" -ForegroundColor Yellow
    Write-Host "  docker run --rm -v `${PWD}:/workspace aquasec/trivy fs /workspace --severity HIGH,CRITICAL" -ForegroundColor Yellow
    exit 1
}

# Run Trivy scan
Write-Host "Scanning project directory for vulnerabilities..." -ForegroundColor Green
if ($FailOnVulnerabilities) {
    Write-Host "⚠️  Fail-on-vulnerabilities mode: ENABLED" -ForegroundColor Yellow
}
Write-Host ""

$exitCode = if ($FailOnVulnerabilities) { "1" } else { "0" }

trivy fs . `
  --severity CRITICAL,HIGH,MEDIUM `
  --format table `
  --scanners vuln `
  --exit-code $exitCode

$scanExitCode = $LASTEXITCODE

Write-Host ""
if ($scanExitCode -eq 0) {
    Write-Host "✅ Scan complete! No vulnerabilities found." -ForegroundColor Green
} elseif ($FailOnVulnerabilities) {
    Write-Host "❌ Scan complete! Vulnerabilities detected - build failed." -ForegroundColor Red
    exit $scanExitCode
} else {
    Write-Host "⚠️  Scan complete! Vulnerabilities detected (not failing)." -ForegroundColor Yellow
}
Write-Host ""
Write-Host "Additional commands:" -ForegroundColor Cyan
Write-Host "  Fail on vulnerabilities:  .\scan-security.ps1 -FailOnVulnerabilities" -ForegroundColor Yellow
Write-Host "  View only CRITICAL/HIGH:  trivy fs . --severity CRITICAL,HIGH" -ForegroundColor Yellow
Write-Host "  Export to JSON:           trivy fs . --severity CRITICAL,HIGH,MEDIUM --format json --output trivy-results.json" -ForegroundColor Yellow
Write-Host "  Check .NET packages only: dotnet list package --vulnerable --include-transitive" -ForegroundColor Yellow
