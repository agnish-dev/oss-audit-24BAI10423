#!/bin/bash
# ============================================================
# Script 4: Log File Analyzer
# Author: Agnish Mondal | Roll: 24BAI10423
# Course: Open Source Software
# Description: Reads a log file line by line using a while-read
#              loop, counts keyword occurrences, and prints the
#              last 5 matching lines. Accepts command-line args.
# Usage: ./script4_log_analyzer.sh <logfile> [keyword]
# Example: ./script4_log_analyzer.sh /var/log/syslog error
# ============================================================

# --- Command-line arguments ---
LOGFILE=$1              # First argument: path to log file
KEYWORD=${2:-"error"}   # Second argument: keyword to search (default: 'error')

# --- Counter variables ---
COUNT=0         # Counts how many lines contain the keyword
TOTAL=0         # Counts total lines read

echo "========================================================"
echo "             LOG FILE ANALYZER                         "
echo "========================================================"
echo ""
echo "  Log File : ${LOGFILE:-'(none provided)'}"
echo "  Keyword  : $KEYWORD"
echo ""

# --- Validate: check that a log file argument was provided ---
if [ -z "$LOGFILE" ]; then
    echo "  [ERROR] No log file specified."
    echo "  Usage  : $0 <logfile> [keyword]"
    echo "  Example: $0 /var/log/syslog error"
    echo ""
    # If no file provided, demonstrate with a generated sample log
    echo "  [INFO] Generating a demo log file for demonstration..."
    LOGFILE="/tmp/demo_oss_audit.log"
    # Create a sample log with mixed content
    cat > "$LOGFILE" <<EOF
2026-03-20 10:01:05 INFO  System startup complete
2026-03-20 10:01:10 INFO  Git service initialized
2026-03-20 10:02:00 ERROR Failed to read config file
2026-03-20 10:02:15 WARNING Deprecated flag used in commit hook
2026-03-20 10:03:00 INFO  Repository scan complete
2026-03-20 10:03:45 ERROR Permission denied on /var/git/repo
2026-03-20 10:04:10 INFO  Backup completed successfully
2026-03-20 10:04:55 ERROR Index corruption detected
2026-03-20 10:05:00 WARNING Large binary file added to staging
2026-03-20 10:05:30 INFO  Push to remote origin successful
EOF
    echo "  [INFO] Demo log created at: $LOGFILE"
    echo ""
fi

# --- Validate: check that the log file actually exists ---
if [ ! -f "$LOGFILE" ]; then
    echo "  [ERROR] File not found: $LOGFILE"
    exit 1
fi

# --- Validate: check that the file is not empty ---
# do-while style retry: check size and warn, then proceed
if [ ! -s "$LOGFILE" ]; then
    echo "  [WARNING] Log file exists but is empty: $LOGFILE"
    echo "  [INFO] Nothing to analyze. Exiting gracefully."
    exit 0
fi

echo "--------------------------------------------------------"
echo "  SCANNING LOG FILE..."
echo "--------------------------------------------------------"
echo ""

# --- While-read loop: read the file line by line ---
while IFS= read -r LINE; do
    TOTAL=$((TOTAL + 1))    # Increment total line counter

    # if-then: check if this line contains the keyword (case-insensitive)
    if echo "$LINE" | grep -iq "$KEYWORD"; then
        COUNT=$((COUNT + 1))    # Increment keyword match counter
    fi

done < "$LOGFILE"   # Redirect file content into the while loop

echo "  Total lines scanned  : $TOTAL"
echo "  Keyword '$KEYWORD' found : $COUNT time(s)"
echo ""

# --- Show the last 5 matching lines using tail + grep ---
echo "--------------------------------------------------------"
echo "  LAST 5 LINES MATCHING '$KEYWORD'"
echo "--------------------------------------------------------"
echo ""

# Use grep to filter matching lines, then tail to get last 5
MATCHES=$(grep -i "$KEYWORD" "$LOGFILE" | tail -5)

if [ -n "$MATCHES" ]; then
    # Print each matching line with a prefix for clarity
    echo "$MATCHES" | while IFS= read -r MATCH_LINE; do
        echo "  >> $MATCH_LINE"
    done
else
    echo "  No matching lines found."
fi

echo ""
echo "========================================================"
echo "  Analysis complete. Log: $LOGFILE | Keyword: $KEYWORD"
echo "========================================================"
echo ""
