#!/bin/bash
read -p "Enter File name(with extension): " file_name
if [ -f "$file_name" ]; then
    echo "File exists."
    echo "Contents of the file:"
    for line in $(cat "$file_name"); do
        echo "$line\n\n"
    done
else
    echo "File does not exist."
fi