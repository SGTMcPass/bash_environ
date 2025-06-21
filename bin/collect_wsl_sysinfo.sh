#!/bin/bash

# Output location
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTFILE="/mnt/c/DiagReport/wsl_sysinfo_report_$TIMESTAMP.txt"

mkdir -p "$(dirname "$OUTFILE")"

echo "Collecting WSL system information..." | tee "$OUTFILE"

# OS and Kernel Info
{
  echo -e "\n# OS and Kernel Info"
  uname -a
  cat /etc/os-release

  echo -e "\n# CPU Info"
  lscpu

  echo -e "\n# Memory Info"
  free -h
  vmstat -s

  echo -e "\n# Disk Info"
  lsblk -f
  df -h
  mount

  echo -e "\n# Swap Info"
  swapon --show
  cat /proc/swaps

  echo -e "\n# Network Interfaces"
  ip addr show
  ip route show

  echo -e "\n# GPU Info"
  nvidia-smi 2>/dev/null || echo "nvidia-smi not available or GPU not visible in WSL2"

  echo -e "\n# Running Services"
  ps -e -o pid,ppid,cmd --sort=ppid

  echo -e "\n# Installed Software"
  rpm -qa | sort

  echo -e "\n# Firewall / SELinux"
  systemctl status firewalld 2>/dev/null || echo "firewalld not running"
  getenforce 2>/dev/null || echo "SELinux not configured"

  echo -e "\n# WSL Configuration"
  cat /etc/wsl.conf 2>/dev/null || echo "/etc/wsl.conf not found"
} >> "$OUTFILE"

