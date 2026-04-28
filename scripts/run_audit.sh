#!/bin/bash
set -e

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M')
REPORT_DIR="docs/audit_reports"
mkdir -p "$REPORT_DIR"

echo "[*] Installing Lynis..."
if ! command -v lynis &>/dev/null; then
  sudo apt update
  sudo apt install -y lynis
fi

echo "[*] Lynis Audit will be launched..."
echo "    Takes ca. 2-3 Minutes."

sudo lynis audit system \
  --quiet \
  --no-colors \
  2>/dev/null | tee "$REPORT_DIR/lynis_$TIMESTAMP.txt"

SCORE=$(grep "Hardening index" "$REPORT_DIR/lynis_$TIMESTAMP.txt" | grep -o '[0-9]*' | head -1)

echo ""
echo "════════════════════════════════════"
echo "  Lynis Hardening Score: $SCORE / 100"
echo "  Report: $REPORT_DIR/lynis_$TIMESTAMP.txt"
echo "════════════════════════════════════"

echo ""
echo "[+] Important Warnings:"
sudo grep "^warning\[\]=" /var/log/lynis-report.dat |
  cut -d'|' -f2 |
  sed 's/^/  - /' ||
  echo "  No warnings"

echo ""
echo "[+] Suggestions:"
sudo grep "^suggestion\[\]=" /var/log/lynis-report.dat |
  cut -d'|' -f2 |
  sed 's/^/  - /' ||
  echo "  No suggestions"
