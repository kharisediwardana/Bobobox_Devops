#!/bin/bash

# 1. Validate input
if [ -z "$1" ]; then
    echo "Usage: $0 <host> [port]"
    exit 1
fi

# 2. Initialize variables
HOST=$1
PORT=${2:-80}

# 3. Logging function


# 4. Ping test
ping -c 2 -W 2 "$HOST" > /dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "Server unreachable"
    echo "Ping Failed: Server unreachable"
    exit 2
else 
    echo "Ping successfull"
fi

if [ $? -ne 0 ]; then
  echo "Server unreachable"
  echo "Ping failed: Server unreachable"
  exit 2
else
  echo "Ping successful"
fi

# 5. HTTP check
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://$HOST:$PORT --max-time 5)

if [ "$HTTP_CODE" -ge 200 ];
then
    STATUS="UP"
else
    STATUS="DOWN"
fi

echo "HTTP service is $STATUS"
# 6. Disk usage
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}') 

echo "Disk usage: $DISK_USAGE"
# 7. Final log summary 
echo "Health check completed"

