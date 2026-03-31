#!/bin/bash
# ============================================================
# Script 5: Open Source Manifesto Generator
# Author: Agnish Mondal | Roll: 24BAI10423
# Course: Open Source Software
# Description: Interactively asks the user three questions and
#              composes a personalised open-source philosophy
#              statement, saving it to a .txt file.
# Concepts: read, string concatenation, file output (>), date,
#           aliases (demonstrated in comments below)
# ============================================================

# --- Alias concept demonstration ---
# In a normal shell session you might define:
#   alias today='date +%d\ %B\ %Y'
# which lets you type 'today' instead of the full date command.
# Aliases are shortcuts — the open-source equivalent of shared
# conventions that make collaboration faster and clearer.
# (Aliases don't persist in non-interactive scripts, so we use
#  the full command below, but the concept is the same.)

echo "========================================================"
echo "       OPEN SOURCE MANIFESTO GENERATOR                 "
echo "========================================================"
echo ""
echo "  Answer three questions to generate your personal"
echo "  open-source philosophy statement."
echo ""
echo "--------------------------------------------------------"

# --- Read: interactively get answers from the user ---

# Question 1: a tool they use
read -p "  1. Name one open-source tool you use every day: " TOOL

# Question 2: what freedom means to them
read -p "  2. In one word, what does 'freedom' mean to you?  " FREEDOM

# Question 3: something they would build and share
read -p "  3. Name one thing you would build and share freely: " BUILD

echo ""
echo "  Generating your manifesto..."
echo ""

# --- Get current date using the date command ---
DATE=$(date '+%d %B %Y')

# --- Get current username for personalised filename ---
USERNAME=$(whoami)

# --- Compose the output filename using string concatenation ---
OUTPUT="manifesto_${USERNAME}.txt"

# --- Compose the manifesto paragraph using string concatenation ---
# Each line is built by appending to a variable, then written to file

# Write the manifesto to file using > (overwrite) and >> (append)
# The > operator creates/overwrites the file with the first line
echo "========================================================" > "$OUTPUT"
echo "  MY OPEN SOURCE MANIFESTO" >> "$OUTPUT"
echo "  Generated on: $DATE" >> "$OUTPUT"
echo "  Author: $USERNAME" >> "$OUTPUT"
echo "========================================================" >> "$OUTPUT"
echo "" >> "$OUTPUT"

# Build the main paragraph using string concatenation with >>
echo "  Every day, I rely on $TOOL — a piece of software built" >> "$OUTPUT"
echo "  by people who chose to share their work with the world" >> "$OUTPUT"
echo "  rather than lock it away. To me, freedom in software" >> "$OUTPUT"
echo "  means $FREEDOM: the right to look under the hood, to fix" >> "$OUTPUT"
echo "  what is broken, and to build on what others have shared." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  That is why, if I had something to give back, it would be" >> "$OUTPUT"
echo "  $BUILD — released openly, so the next person does not have" >> "$OUTPUT"
echo "  to start from zero the way I did." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  I believe that software, like knowledge, grows stronger" >> "$OUTPUT"
echo "  when it is shared. Every line of open-source code is a" >> "$OUTPUT"
echo "  small act of trust in humanity — and I intend to honour" >> "$OUTPUT"
echo "  that trust." >> "$OUTPUT"
echo "" >> "$OUTPUT"
echo "  — $USERNAME | $DATE" >> "$OUTPUT"
echo "========================================================" >> "$OUTPUT"

# --- Display the manifesto on screen using cat ---
echo "  [✓] Manifesto saved to: $OUTPUT"
echo ""
echo "--------------------------------------------------------"
cat "$OUTPUT"
echo ""
