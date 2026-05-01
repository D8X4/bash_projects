#!/bin/bash
# audit.sh - system security audit script

# colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # no color

flag() { echo -e "${RED}[!] $1${NC}"; }
warn() { echo -e "${YELLOW}[?] $1${NC}"; }
ok()   { echo -e "${GREEN}[+] $1${NC}"; }

echo "================================"
echo "   SYSTEM AUDIT - $(date)"
echo "================================"

echo ""
echo "=== SUID BINARIES ==="
results=$(find / -type f -perm -4000 2>/dev/null | grep -ivE 'snap|/usr/bin|/usr/sbin|/usr/lib|/bin|/sbin')
if [ -z "$results" ]; then
    ok "No suspicious SUID binaries found"
else
    flag "Suspicious SUID binaries detected:"
    echo "$results"
fi

echo ""
echo "=== SUSPICIOUS CRON JOBS ==="
results=$(grep -rE "curl|wget|bash|nc|/tmp|/dev/shm" /etc/cron.d/ /etc/crontab /etc/cron.daily/ /etc/cron.hourly/ 2>/dev/null | grep -v "^#" | grep -ivE "zorinos|census|apt-compat|sysstat|logrotate|man-db|anacron|dpkg|plocate")
if [ -z "$results" ]; then
    ok "No suspicious cron entries found"
else
    flag "Suspicious cron entries detected:"
    echo "$results"
fi

echo ""
echo "=== HIDDEN FILES IN VOLATILE DIRS ==="
results=$(find /tmp /var/tmp /dev/shm -name ".*" 2>/dev/null | grep -ivE "\.X[0-9]|\.font-unix|\.ICE-unix|\.XIM-unix|\.X11-unix|\.yazi")
if [ -z "$results" ]; then
    ok "No hidden files found in volatile directories"
else
    flag "Hidden files detected:"
    echo "$results"
fi

echo ""
echo "=== EXPOSED LISTENING PORTS ==="
results=$(ss -tlnp | grep -v "127\." | grep -v "::1" | grep "LISTEN")
if [ -z "$results" ]; then
    ok "No ports exposed to network"
else
    warn "Ports listening on network interfaces:"
    echo "$results"
fi

echo ""
echo "=== SUSPICIOUS USERS ==="
results=$(awk -F: '($3 >= 1000 && $3 != 65534) && $7 !~ /nologin|false/ {print $1, "uid="$3, "shell="$7}' /etc/passwd | grep -v "^d8x4")
if [ -z "$results" ]; then
    ok "No suspicious user accounts found"
else
    flag "Unexpected user accounts with login shells:"
    echo "$results"
fi

echo ""
echo "=== OUTBOUND C2 CONNECTIONS ==="
results=$(ss -tnp | grep -i "SYN-SENT\|ESTAB" | grep -v "127\.\|::1" | grep -ivE "firefox|chrome|snap|gnome")
if [ -z "$results" ]; then
    ok "No suspicious outbound connections"
else
    flag "Suspicious outbound connections detected:"
    echo "$results"
fi

echo ""
echo "================================"
echo "   AUDIT COMPLETE"
echo "================================"
