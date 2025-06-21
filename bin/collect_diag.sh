#!/bin/bash

OUTDIR="/mnt/c/DiagReport"
mkdir -p "$OUTDIR"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

SYSINFO="$OUTDIR/wsl_sysinfo_report_$TIMESTAMP.txt"
DIAGINFO="$OUTDIR/wsl_diagnostics_$TIMESTAMP.txt"

# Run system info script
bash ./collect_wsl_sysinfo.sh

# Extended Diagnostics
{
  echo "# Crontab Entries"
  crontab -l 2>/dev/null || echo "No crontab entries"

  echo -e "\n# Top Processes"
  ps aux --sort=-%mem | head -n 25

  echo -e "\n# Environment Variables"
  printenv

  echo -e "\n# Kernel Modules"
  lsmod || echo "lsmod unavailable"
} > "$DIAGINFO"

echo "WSL diagnostics complete: $SYSINFO, $DIAGINFO"

