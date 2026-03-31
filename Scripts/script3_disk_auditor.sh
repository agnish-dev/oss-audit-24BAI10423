#!/bin/bash
# ============================================================
# Script 3: Disk and Permission Auditor
# Author: Agnish Mondal | Roll: 24BAI10423
# Course: Open Source Software
# Description: Loops through key system directories using a
#              for loop and reports permissions, owner, and
#              disk usage. Also checks Git's config directory.
# ============================================================

# --- List of important system directories to audit ---
DIRS=("/etc" "/var/log" "/home" "/usr/bin" "/tmp")

echo "========================================================"
echo "          DISK AND PERMISSION AUDITOR                  "
echo "========================================================"
echo ""
printf "  %-20s %-25s %-10s\n" "DIRECTORY" "PERMISSIONS / OWNER" "SIZE"
echo "  ---------------------------------------------------------------"

# --- For loop: iterate over each directory ---
for DIR in "${DIRS[@]}"; do
    # Check if the directory actually exists before inspecting it
    if [ -d "$DIR" ]; then
        # Use ls -ld and awk to extract permission string, owner, and group
        PERMS=$(ls -ld "$DIR" | awk '{print $1}')     # e.g. drwxr-xr-x
        OWNER=$(ls -ld "$DIR" | awk '{print $3}')     # e.g. root
        GROUP=$(ls -ld "$DIR" | awk '{print $4}')     # e.g. root
        # Use du to get human-readable size; suppress permission errors
        SIZE=$(du -sh "$DIR" 2>/dev/null | cut -f1)
        printf "  %-20s %-25s %-10s\n" "$DIR" "$PERMS $OWNER:$GROUP" "$SIZE"
    else
        # Directory does not exist on this system
        printf "  %-20s %-35s\n" "$DIR" "[NOT FOUND on this system]"
    fi
done

echo ""
echo "--------------------------------------------------------"
echo "  GIT CONFIGURATION DIRECTORY CHECK"
echo "--------------------------------------------------------"
echo ""

# --- Check if Git's global config directory exists ---
# Git stores its system-level config in /etc/gitconfig
# and user-level config in ~/.gitconfig or ~/.config/git/

GIT_SYSTEM_CONF="/etc/gitconfig"
GIT_USER_CONF="$HOME/.gitconfig"
GIT_ALT_CONF="$HOME/.config/git"

# Check system-level git config file
if [ -f "$GIT_SYSTEM_CONF" ]; then
    PERMS=$(ls -l "$GIT_SYSTEM_CONF" | awk '{print $1, $3, $4}')
    echo "  [✓] System git config found : $GIT_SYSTEM_CONF"
    echo "      Permissions              : $PERMS"
else
    echo "  [i] No system-level git config at $GIT_SYSTEM_CONF"
fi

# Check user-level git config file
if [ -f "$GIT_USER_CONF" ]; then
    PERMS=$(ls -l "$GIT_USER_CONF" | awk '{print $1, $3, $4}')
    echo "  [✓] User git config found   : $GIT_USER_CONF"
    echo "      Permissions              : $PERMS"
else
    echo "  [i] No user-level git config at $GIT_USER_CONF"
    echo "      Run: git config --global user.name 'Your Name'"
fi

# Check alternate config directory
if [ -d "$GIT_ALT_CONF" ]; then
    PERMS=$(ls -ld "$GIT_ALT_CONF" | awk '{print $1, $3, $4}')
    echo "  [✓] Alt git config dir found: $GIT_ALT_CONF"
    echo "      Permissions              : $PERMS"
fi

echo ""
echo "--------------------------------------------------------"
echo "  PERMISSION KEY"
echo "--------------------------------------------------------"
echo "  d = directory | r = read | w = write | x = execute"
echo "  Format: [type][owner][group][others]"
echo "  Example: drwxr-xr-x = dir, owner:rwx, group:r-x, other:r-x"
echo "========================================================"
echo ""
