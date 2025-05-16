#!/bin/bash

SERVER="$1"
LABEL="$2"
DELAY="$3"

if [[ -n "$DELAY" ]]; then
  sleep "$DELAY"
fi

TIME_LIMIT=10
OUTPUT=$(timeout "$TIME_LIMIT" iperf3 -c "$SERVER" -p 5201 --bitrate 1000M -u -t 5 -J 2>/dev/null)

if [ $? -ne 0 ] || [ -z "$OUTPUT" ]; then
  echo "iperf3_bits_per_second,server=$SERVER,label=$LABEL value=0"
  exit 0
fi

BITS=$(echo "$OUTPUT" | jq '.end.sum_received.bits_per_second // .end.sum.bits_per_second // 0')
BITS=${BITS:-0}

echo "iperf3_bits_per_second,server=$SERVER,label=$LABEL value=$BITS"

