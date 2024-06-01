#!/bin/bash

# Function to print the current timestamp
print_timestamp() {
  echo "$(date +%Y-%m-%d\ %H:%M:%S)"
}

# Get the start time
start_time=$(date +%s)

# Loop for 120 seconds
while (( $(date +%s) - start_time < 120 )); do

  # Get memory usage
  memory_usage=$(free -h | awk '/^Mem:/ {print $3 "/" $2}')

  # Get CPU usage
  cpu_usage=$(top -bn1 | awk '/^%Cpu/ {print $2 "%"}')

  # Get network bandwidth
  network_bandwidth=$(ifstat -i enp0s8 -q 1 1 | awk 'NR==3 {split($0, values, " "); print values[1] " Kbps in / " values[2] " Kbps out"}')

  # Print the information
  echo "Timestamp: $(print_timestamp)"
  echo "Memory Usage: $memory_usage"
  echo "CPU Usage: $cpu_usage"
  echo "Network Bandwidth: $network_bandwidth"
  echo "--------------------------"

  # Sleep for 13 seconds
  sleep 13

done

# Print end of monitoring
echo "Monitoring completed."
