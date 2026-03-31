#!/bin/bash
# ============================================================
# Script 2: FOSS Package Inspector
# Author: Agnish Mondal | Roll: 24BAI10423
# Course: Open Source Software
# Description: Checks if a FOSS package is installed, shows
#              version/license info, and prints a philosophy
#              note using a case statement.
# ============================================================

# --- Set the target package name ---
PACKAGE="git"   # Our chosen open-source software

echo "========================================================"
echo "           FOSS PACKAGE INSPECTOR                      "
echo "========================================================"
echo ""
echo "  Checking package: $PACKAGE"
echo ""

# --- Check if package is installed using if-then-else ---
# Try dpkg (Debian/Ubuntu) first, then rpm (RHEL/Fedora)
if dpkg -l "$PACKAGE" &>/dev/null 2>&1; then
    # Package found via dpkg (apt-based systems)
    echo "  [✓] $PACKAGE is INSTALLED (dpkg)"
    echo ""
    echo "  --- Package Details ---"
    # Extract Version, License/Architecture, and Description using grep
    dpkg -l "$PACKAGE" | grep "^ii" | awk '{print "  Version      : "$3"\n  Architecture : "$4"\n  Description  : "$5" "$6" "$7" "$8}'

elif rpm -q "$PACKAGE" &>/dev/null 2>&1; then
    # Package found via rpm (RHEL/CentOS/Fedora based systems)
    echo "  [✓] $PACKAGE is INSTALLED (rpm)"
    echo ""
    echo "  --- Package Details ---"
    # Use rpm -qi and grep to filter relevant fields
    rpm -qi "$PACKAGE" | grep -E "^(Version|License|Summary)" | while read -r line; do
        echo "  $line"
    done

else
    # Package not found — try checking via 'which' as a fallback
    if which "$PACKAGE" &>/dev/null 2>&1; then
        echo "  [✓] $PACKAGE binary found at: $(which $PACKAGE)"
        VERSION=$("$PACKAGE" --version 2>/dev/null | head -1)
        echo "  Version      : $VERSION"
    else
        echo "  [✗] $PACKAGE is NOT installed on this system."
        echo "  To install on Debian/Ubuntu : sudo apt install $PACKAGE"
        echo "  To install on RHEL/Fedora   : sudo dnf install $PACKAGE"
    fi
fi

echo ""
echo "--------------------------------------------------------"
echo "  OPEN SOURCE PHILOSOPHY NOTE"
echo "--------------------------------------------------------"
echo ""

# --- Case statement: print philosophy note based on package name ---
case $PACKAGE in
    git)
        echo "  Git: Linus Torvalds built Git in 2005 after BitKeeper"
        echo "  revoked free access to Linux kernel developers. He chose"
        echo "  to release it under GPL v2 — refusing to let history"
        echo "  repeat itself. Today, Git powers virtually all software"
        echo "  development on the planet."
        ;;
    httpd | apache2)
        echo "  Apache: The web server that built the open internet."
        echo "  Born from patchy improvements to the NCSA httpd server,"
        echo "  its name is a play on 'a patchy server.' Today it powers"
        echo "  roughly 30% of all websites globally."
        ;;
    mysql | mariadb)
        echo "  MySQL: Open source at the heart of millions of apps."
        echo "  Its dual GPL/commercial license model sparked debate about"
        echo "  what 'open source' really means when a corporation owns"
        echo "  the copyright. MariaDB was forked to keep it truly free."
        ;;
    vlc)
        echo "  VLC: Built by students at École Centrale Paris who needed"
        echo "  a free tool to stream video over their campus network."
        echo "  Under LGPL, it plays virtually any media format — a gift"
        echo "  to every user who has ever hit a codec error."
        ;;
    firefox)
        echo "  Firefox: A nonprofit's answer to Internet Explorer's monopoly."
        echo "  Under the Mozilla Public License, it stands as proof that"
        echo "  a community-driven browser can compete with trillion-dollar"
        echo "  corporations on the open web."
        ;;
    python3 | python)
        echo "  Python: Shaped entirely by community consensus via PEPs"
        echo "  (Python Enhancement Proposals). Its PSF license allows"
        echo "  commercial use freely — making it the most popular"
        echo "  language in data science and AI today."
        ;;
    *)
        echo "  $PACKAGE: An open-source tool chosen freely, shared openly,"
        echo "  and improved collectively — the essence of the FOSS movement."
        ;;
esac

echo ""
echo "========================================================"
