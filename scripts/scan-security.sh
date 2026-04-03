#!/bin/bash
# Security scan script using Trivy

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
  --scanners vuln

echo ""
echo "✅ Scan complete!"
echo ""
echo "To view only CRITICAL/HIGH issues:"
echo "  trivy fs . --severity CRITICAL,HIGH"
echo ""
echo "To export results:"
echo "  trivy fs . --severity CRITICAL,HIGH,MEDIUM --format json --output trivy-results.json"
