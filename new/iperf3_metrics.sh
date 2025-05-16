root@monitor-vultr-ewr-01:~# cat /usr/local/bin/iperf3_metrics.sh
#!/bin/bash

SERVER="$1"
LABEL="$2"
DELAY="$3"

if [[ -n "$DELAY" ]]; then
  sleep "$DELAY"
fi

TIME_LIMIT=10
IPERF_PORT=5201

run_udp() {
  OUTPUT=$(timeout "$TIME_LIMIT" iperf3 -c "$SERVER" -p "$IPERF_PORT" -u --bitrate 1000M -t 5 -J 2>/dev/null)

  if [[ $? -ne 0 || -z "$OUTPUT" ]]; then
    echo "iperf3_bits_per_second,server=$SERVER,label=$LABEL,proto=udp value=0"
    echo "iperf3_jitter_ms,server=$SERVER,label=$LABEL,proto=udp value=0"
  else
    BITS=$(echo "$OUTPUT" | jq '.end.sum_received.bits_per_second // .end.sum.bits_per_second // 0')
    JITTER=$(echo "$OUTPUT" | jq '.end.sum.jitter_ms // 0')
    echo "iperf3_bits_per_second,server=$SERVER,label=$LABEL,proto=udp value=$BITS"
    echo "iperf3_jitter_ms,server=$SERVER,label=$LABEL,proto=udp value=$JITTER"
  fi

  # Latency using ICMP ping
  LATENCY=$(ping -c 1 -W 1 "$SERVER" | grep 'time=' | sed -n 's/.*time=\(.*\) ms/\1/p')
  LATENCY=${LATENCY:-0}
  echo "iperf3_latency_ms,server=$SERVER,label=$LABEL,proto=icmp value=$LATENCY"
}

run_tcp() {
  OUTPUT=$(timeout "$TIME_LIMIT" iperf3 -c "$SERVER" -p "$IPERF_PORT" -t 5 -J 2>/dev/null)

  if [[ $? -ne 0 || -z "$OUTPUT" ]]; then
    echo "iperf3_bits_per_second,server=$SERVER,label=$LABEL,proto=tcp value=0"
    echo "iperf3_latency_ms,server=$SERVER,label=$LABEL,proto=tcp value=0"
  else
    BITS=$(echo "$OUTPUT" | jq '.end.sum_received.bits_per_second // .end.sum.bits_per_second // 0')
    START_TIME=$(echo "$OUTPUT" | jq '.start.timestamp.timesecs')
    CONNECT_TIME=$(echo "$OUTPUT" | jq '.start.connected[0].connect_ts // .start.connected[0].connecting_to.connect_ts // 0')
    LATENCY=$(echo "$CONNECT_TIME $START_TIME" | awk '{printf "%.3f", ($1 - $2) * 1000}')
    echo "iperf3_bits_per_second,server=$SERVER,label=$LABEL,proto=tcp value=$BITS"
    echo "iperf3_latency_ms,server=$SERVER,label=$LABEL,proto=tcp value=$LATENCY"
  fi
}

# Run both tests
run_udp
run_tcp
