#!/bin/bash
index=1;
read -p "Enter Extension:  " extension
read -p "Enter File name(without extension): " file_name
if [ -f "$file_name.$extension" ]; then
    echo "File exists."
    echo "options:"
    echo "1. run  2. skip  3. step backward  4. exit"
    echo "Contents of the file:"
    for line in $(cat "$file_name"); do
        echo "$index:  $line"
        read -p "Choose an option: " option
        if [ $option -eq 1 ]; then
            cat "$file_name.$extension">>line
            
        fi
        let index=$index+1
    done
else
    echo "File does not exist."
fi