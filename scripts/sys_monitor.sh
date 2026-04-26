#!/bin/bash
LOG_FILE="$HOME/server_log.txt"
echo "[$(date)] System Check: Users online: $(who | wc -l), Load average: $(uptime | awk -F'average:' '{print $2}')" >> "$LOG_FILE"