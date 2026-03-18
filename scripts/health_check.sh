#!/bin/bash

# 1. Validate input
if [ -z "$1" ]; then
    echo "Usage: $0 <host> [port]"
    exit 1
fi

# 2. Initialize variables
HOST=$1
PORT=${2:-80}
LOG_FILE="health_check.log"

# 3. Logging function
timestamp() {
  date "+%Y-%m-%d %H:%M:%S"
}

log() {
    echo "$(timestamp) - $1" >> "$LOG_FILE"
}

log "# ./health_check.sh $HOST $PORT"


# 4. Ping test
ping -c 2 -W 2 "$HOST" > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "Server unreachable"
    log "Server unreachable"
    exit 2
else
    echo "Server is reachable."
    log "Server is reachable."
fi

# 5. HTTP check
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://$HOST:$PORT --max-time 5)

if [ "$HTTP_CODE" -ge 200 ];
then
    STATUS="UP"
else
    STATUS="DOWN"
fi

echo "Web service on port $PORT is $STATUS."

log "Web service on port $PORT is $STATUS."

# 6. Disk usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}') 

echo "Disk usage on / is $DISK_USAGE."

log "Disk usage on / is $DISK_USAGE."


# 7. Final log summary
log "Health check completed"
echo "Results logged to health_check.log"

