#!/usr/bin/env bash

UPTIME=$(cut -d' ' -f1 < /proc/uptime)

ELAPSED=''

# YEARS="$(echo $uptime | awk '{print int($N / 31536000);}')"
DAYS="$(echo "$UPTIME" | awk '{print int($N / 86400);}')"
HOURS="$(echo "$UPTIME" | awk '{print int($N / 3600) % 24;}')"
MINUTES="$(echo "$UPTIME" | awk '{print int($N / 60) % 60;}')"
# SECONDS=$(echo $uptime | awk '{print int($N) % 60;}')

# test $YEARS != 0 && ELAPSED="${ELAPSED}${YEARS}y "
test "$DAYS" != 0 && ELAPSED="${ELAPSED}${DAYS}d "
test "$HOURS" != 0 && ELAPSED="${ELAPSED}${HOURS}h "
test "$MINUTES" != 0 && ELAPSED="${ELAPSED}${MINUTES}m"

echo "$ELAPSED"
