#!/bin/bash

start_index=$1
end_index=$2

rm -rf inputFile

# Check if the start index is less than or equal to the end index
if [ "$start_index" -gt "$end_index" ]; then
    echo "Start index must be less than end index for this assignment"
    
fi

for ((i=start_index; i<=end_index; i++)); do
	random_number=$((RANDOM % 250))  # Generates a random number between 0 and 250
    echo "$i, $random_number" >> inputFile
done
