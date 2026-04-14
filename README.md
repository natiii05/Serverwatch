# ServerWatch v1.0

Automated Linux server health monitoring tool with three-level alerting.
Built as part of a systems engineering learning journey — Stage 1 of 4.

## What It Does

- Checks memory, disk, and CPU load on any Linux system
- Classifies each metric as OK, NOTICE, or CRITICAL
- Saves a dated log file automatically on every run
- Rotates logs — retains last 30 days, deletes older files
- Can be scheduled via cron to run automatically every hour

## Alert Thresholds

| Metric | OK    | NOTICE | CRITICAL |
|--------|-------|--------|----------|
| Memory | < 70% | 70–85% |  > 85%   |
| Disk   | < 70% | 70–80% |  > 80%   |

## How to Use

Clone the repository:
git clone https://github.com/natiii05/serverwatch.git
cd serverwatch
chmod +x serverwatch.sh

Run manually:
./serverwatch.sh

Schedule to run every hour:
crontab -e
Add: 0 * * * * /path/to/serverwatch/serverwatch.sh

## Sample Output

=========================================
   ServerWatch v1.0 — Health Monitor
=========================================
Run Time: Mon Apr 13 10:14:17 EAT 2026
Host:     Natis-PC
User:     natnael
=========================================

Memory Usage: 6%
Memory OK - 6% used

Disk Usage: 1%
Disk OK - 1% used

CPU Load (15min avg): 0.00

=========================================
  OVERALL STATUS: OK — All systems healthy
=========================================

## Author

Natnael Assefa
Systems Engineer in Training — Stage 1: Linux Foundations
