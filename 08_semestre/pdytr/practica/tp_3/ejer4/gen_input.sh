#!/bin/bash

# Accept interval, message size, ID, and optional message count as arguments
INTERVAL=$1
SIZE=$2
ID=$3
MESSAGE_COUNT=$4  # New parameter for the number of messages to send

# Function to print usage and exit
usage() {
    echo "Usage: $0 <interval> <size> <id> [<message_count>]"
    echo "  <interval>: Time interval in seconds (positive integer or float)"
    echo "  <size>: Total message size (integer greater than the ID length + 6)"
    echo "  <id>: Unique identifier for the message (non-empty string)"
    echo "  <message_count>: (optional) Number of messages to send before finishing"
    exit 1
}

# Validate the interval (should be a positive number)
# if ! [[ "$INTERVAL" =~ ^[0-9]+([.][0-9]+)?$ ]] || (( $(echo "$INTERVAL <= 0" | bc -l) )); then
#     echo "Error: Interval must be a positive number."
#     usage
# fi

# Validate the size (should be a positive integer and larger than ID length + 6)
if ! [[ "$SIZE" =~ ^[0-9]+$ ]] || [ "$SIZE" -le $(( ${#ID} + 6 )) ]; then
    echo "Error: Size must be a positive integer greater than the length of 'c_<id> m_' (${#ID} + 6)."
    usage
fi

# Validate the ID (should not be empty)
if [ -z "$ID" ]; then
    echo "Error: ID must be a non-empty string."
    usage
fi

# Validate the message count if provided
if [ -n "$MESSAGE_COUNT" ] && ! [[ "$MESSAGE_COUNT" =~ ^[0-9]+$ ]] ; then
    echo "Error: Message count must be a positive integer."
    usage
fi

# Default message count to an infinite loop if not provided
MESSAGE_COUNT=${MESSAGE_COUNT:-0}

# Function to generate a random string to fill the message
generate_random_fill() {
    local size=$1
    # Create a random string to fill the rest of the message
    head /dev/urandom | tr -dc A-Za-z0-9 | head -c "$size"
}

# Initialize the message counter
count=0

# Loop to send messages until the count is reached or infinite
while true; do
    # Calculate the available space for the random fill
    FILL_SIZE=$((SIZE - (${#ID} + 6)))
    if [ "$FILL_SIZE" -lt 0 ]; then
        FILL_SIZE=0  # Prevent negative fill size
    fi

    # Generate the random fill part
    RANDOM_FILL=$(generate_random_fill "$FILL_SIZE")

    # Construct the message in the form "c_${ID} m_${SIZE} <random fill>"
    MESSAGE="c_${ID} m_${SIZE} ${RANDOM_FILL}"

    # Output the message
    echo "$MESSAGE"

    # Increment the message counter
    count=$((count + 1))

    # Break the loop if a message count is specified and reached
    if [ "$MESSAGE_COUNT" -gt 0 ] && [ "$count" -ge "$MESSAGE_COUNT" ]; then
        break
    fi

    # Wait for the specified interval
    sleep "$INTERVAL"
done
