#!/bin/bash
# ─────────────────────────────────────────
# ServerWatch v1.0
# Author: Natnael Assefa
# Description: Automated server health monitor
#              with three-level alerting
# ─────────────────────────────────────────

LOG_DIR="$(dirname "$0")/logs"
LOG_FILE="$LOG_DIR/serverwatch-$(date +%F).log"
exec > >(tee "$LOG_FILE")

echo "======================"
echo ""
echo " ServerWatch v1.0 - Health Monitor"
echo ""
echo "======================"
echo ""
echo " Run Time: $(date)"
echo "Host:      $(hostname)"
echo "User:      $(whoami)"
echo "Location   $(pwd)"
echo ""
echo "======================="
echo ""


echo "---System---"
echo ""
cat /etc/os-relase | grep PRETTY_NAME
echo "Kernel: $(uname -r)"
echo ""


echo "---Health---"

#---Memory Check---"
Mem_Used=$(free | grep Mem | awk '{print int ($3/$2 * 100)}')
echo "Memory Usage: $Mem_Used%"
if [ $Mem_Used -gt 85 ]; then
    echo "*** CRITICAL: Memory at $Mem_Used% ***"
    free -h
elif [ $Mem_Used -gt 70 ]; then
    echo "*** NOTICE: Memory elevated at $Mem_Used% **"
else
    echo "Memory OK - $Mem_Used% used"
fi
echo ""

#--- Disk Check ---
Disk_Used=$(df / | grep / | awk '{print int($5)}')
echo "Disk Usage: $Disk_Used%"
if [ $Disk_Used -gt 80 ]; then
    echo "*** CRITICAL: Disk at $Disk_Used% ***"
    df -h /
elif [ $Disk_Used -gt 70 ]; then
    echo "** NOTICE: Disk elevated at $Disk_Used% **"
else
    echo "Disk OK - $Disk_Used% used"
fi
echo ""

#--- CPU Load Check ---
CPU_LOAD=$(uptime | awk '{print $NF}')
echo "CPU Load (15min avg): $CPU_LOAD"
echo ""

#--- Overall Status ---
echo "========================================="
if [ $Mem_Used -gt 85 ] || [ $Disk_Used -gt 80 ]; then
    echo "  OVERALL STATUS: *** CRITICAL ***"
elif [ $Mem_Used -gt 70 ] || [ $Disk_Used -gt 70 ]; then
    echo "  OVERALL STATUS: ** NOTICE **"
else
    echo "  OVERALL STATUS: OK — All systems healthy"
fi
echo "========================================="
echo ""

echo "--- Active Users ---"
who
echo ""

echo "--- Open Ports ---"
ss -tuln
echo ""

#--- Log Rotation ---
find "$LOG_DIR" -name "serverwatch-*.log" -mtime +30 -delete
KEPT=$(ls "$LOG_DIR" | wc -l)
echo "Log files retained: $KEPT"
echo ""

echo "========================================"
echo "       End of serverwatch report"
echo "========================================"
