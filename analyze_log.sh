#!/bin/bash

# Use the first argument as the log file, or the default
LOG_FILE="${1:-transit_session.log}"

# Stop with exit code 1 if the file doesn't exist
if [ ! -f "$LOG_FILE" ]; then
    echo "Error: log file '$LOG_FILE' not found."
    exit 1
fi

sessions=$(grep -c "New session started" "$LOG_FILE")
zebras=$(grep -c "Zebra crossing! Stopping" "$LOG_FILE")
lanes=$(grep -c "Changing lane" "$LOG_FILE")
driver=$(grep "Driver  *:" "$LOG_FILE" | tail -1 | sed 's/.*Driver *: *//')
topspeed=$(grep "Top speed" "$LOG_FILE" | tail -1 | sed 's/.*Top speed *: *//')

echo "===== LOG SUMMARY ($LOG_FILE) ====="
echo "Sessions        : $sessions"
echo "Zebra stops     : $zebras"
echo "Lane changes    : $lanes"
echo "Latest driver   : ${driver:-N/A}"
echo "Latest top speed: ${topspeed:-N/A}"