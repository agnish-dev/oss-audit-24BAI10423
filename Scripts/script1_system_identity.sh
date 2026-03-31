#!/bin/bash
# ============================================================
# Script 1: System Identity Report
# Author: Agnish Mondal | Roll: 24BAI10423
# Course: Open Source Software
# Description: Displays a welcome screen with system details
#              and open-source license information.
# ============================================================

# --- Student Info ---
STUDENT_NAME="Agnish Mondal"
ROLL_NUMBER="24BAI10423"
SOFTWARE_CHOICE="Git"

# --- Gather system information using command substitution ---
KERNEL=$(uname -r)                         # Get Linux kernel version
DISTRO=$(lsb_release -d 2>/dev/null | cut -f2 || cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"')  # Get distro name
USER_NAME=$(whoami)                        # Get current logged-in user
HOME_DIR=$HOME                             # Get home directory of current user
UPTIME=$(uptime -p)                        # Get human-readable uptime
CURRENT_DATE=$(date '+%A, %d %B %Y %H:%M:%S')  # Get current date and time

# --- License information for common Linux distros ---
# Most Linux distributions use GPL v2 or GPL v3 for the OS kernel
OS_LICENSE="GPL v2 (GNU General Public License, version 2)"

# --- Display formatted welcome screen ---
echo "========================================================"
echo "         OPEN SOURCE AUDIT — SYSTEM IDENTITY           "
echo "========================================================"
echo ""
echo "  Student   : $STUDENT_NAME"
echo "  Roll No   : $ROLL_NUMBER"
echo "  Software  : $SOFTWARE_CHOICE"
echo ""
echo "--------------------------------------------------------"
echo "  SYSTEM INFORMATION"
echo "--------------------------------------------------------"
echo "  Distribution : $DISTRO"
echo "  Kernel       : $KERNEL"
echo "  Logged User  : $USER_NAME"
echo "  Home Dir     : $HOME_DIR"
echo "  Uptime       : $UPTIME"
echo "  Date & Time  : $CURRENT_DATE"
echo ""
echo "--------------------------------------------------------"
echo "  LICENSE INFORMATION"
echo "--------------------------------------------------------"
echo "  OS License   : $OS_LICENSE"
echo "  This means   : You are free to run, study, share,"
echo "                 and modify the operating system."
echo "========================================================"
echo ""
