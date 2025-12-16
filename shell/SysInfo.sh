#!/bin/bash

# System Information Display Script (macOS)

echo "======================================"
echo "     SYSTEM INFORMATION REPORT"
echo "======================================"
echo ""

# Hostname
echo "Hostname:"
hostname
echo ""

# Current logged-in user
echo "Current User:"
whoami
echo ""

# Operating System Version
echo "Operating System:"
sw_vers
echo ""

# Kernel Information
echo "Kernel Information:"
uname -a
echo ""

# Memory Usage
echo "Memory Usage:"
vm_stat | awk '
/Pages free/ {free=$3}
/Pages active/ {active=$3}
/Pages inactive/ {inactive=$3}
/Pages wired down/ {wired=$4}
END {
  page_size=4096
  printf "Free: %.2f GB\n", free*page_size/1024/1024/1024
  printf "Active: %.2f GB\n", active*page_size/1024/1024/1024
  printf "Inactive: %.2f GB\n", inactive*page_size/1024/1024/1024
  printf "Wired: %.2f GB\n", wired*page_size/1024/1024/1024
}'
echo ""

# Disk Usage
echo "Disk Usage:"
df -h
echo ""

# System Uptime
echo "System Uptime:"
uptime
echo ""

# CPU Information
echo "CPU Information:"
sysctl -n machdep.cpu.brand_string
echo "CPU Cores:"
sysctl -n hw.ncpu
echo ""

# Current Date and Time
echo "Current Date and Time:"
date
echo ""

echo "======================================"
echo "     END OF REPORT"
echo "======================================"