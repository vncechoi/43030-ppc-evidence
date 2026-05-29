#!/usr/bin/env bash
# tool.sh — basic evidence capture helper (Goal 3)

echo "=== DATE ==="
date
echo

echo "=== SYSTEM INFO ==="
uname -a
echo

echo "=== IP INFO ==="
ip a 2>/dev/null || ifconfig 2>/dev/null
echo

echo "=== LISTENING PORTS ==="
ss -tulpen 2>/dev/null || netstat -tulpen 2>/dev/null
echo
