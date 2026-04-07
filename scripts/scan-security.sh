#!/bin/bash
# Security scan script using Trivy
# Usage: ./scan-security.sh [--fail-on-vulnerabilities]

FAIL_ON_VULN=0

if [[ "$1" == "--fail-on-vulnerabilities" ]]; then
    FAIL_ON_VULN=1
    echo "⚠️  Fail-on-vulnerabilities mode: ENABLED"
fi

echo "🔍 Running Trivy security scan..."
echo "=================================="

# Check if Trivy is installed
if ! command -v trivy &> /dev/null
then
    echo "❌ Trivy is not installed."
    echo ""
    echo "Install Trivy:"
    echo "  macOS:   brew install trivy"
    echo "  Windows: choco install trivy"
    echo "  Linux:   https://aquasecurity.github.io/trivy/latest/getting-started/installation/"
    echo ""
    echo "Or use Docker:"
    echo "  docker run --rm -v \$(pwd):/workspace aquasec/trivy fs /workspace --severity HIGH,CRITICAL"
    exit 1
fi

# Run Trivy scan
echo ""
echo "Scanning project directory for vulnerabilities..."
trivy fs . \
  --severity CRITICAL,HIGH,MEDIUM \
  --format table \
  --scanners vuln \
  --exit-code $FAIL_ON_VULN

EXIT_CODE=$?

echo ""
if [ $EXIT_CODE -eq 0 ]; then
    echo "✅ Scan complete! No vulnerabilities found."
elif [ $FAIL_ON_VULN -eq 1 ]; then
    echo "❌ Scan complete! Vulnerabilities detected - build failed."
    exit $EXIT_CODE
else
    echo "⚠️  Scan complete! Vulnerabilities detected (not failing)."
fi
echo ""
echo "Additional commands:"
echo "  Fail on vulnerabilities: ./scan-security.sh --fail-on-vulnerabilities"
echo "  View CRITICAL/HIGH only: trivy fs . --severity CRITICAL,HIGH"
echo "  Export to JSON:          trivy fs . --severity CRITICAL,HIGH,MEDIUM --format json --output trivy-results.json"
echo "  Check .NET packages:     dotnet list package --vulnerable --include-transitive"
