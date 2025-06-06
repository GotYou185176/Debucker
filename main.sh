#!/bin/bash
index=1;
read -p "Enter File name(without extension): " file_name
read -p "Enter Extension:  " extension
touch temp.$extension
if [ -f "$file_name.$extension" ]; then
    echo " "
    echo "Options: "
    echo "1. Run    2. Skip    3. Exit"
    echo " "
    echo " "
    echo "Contents of the file:"
    for line in $(cat "$file_name.$extension"); do
        echo "$index:  $line"
        read -p "Enter:  " option
        if [ $option -eq 1 ]; then
            cat "$file_name.$extension">>line
            echo "Attempting to execute temp.$extension..."

            case "$extension" in
                sh)
                    bash temp.$extension
                    ;;
                py)
                    python3 temp.$extension
                    ;;
                js)
                    node temp.$extension
                    ;;
                java)
                    javac temp.$extension && java "${file_name}"  # Assumes class name = file name
                    ;;
                c)
                    gcc temp.$extension -o temp_exec && ./temp_exec && rm temp_exec
                    ;;
                cpp)
                    g++ temp.$extension -o temp_exec && ./temp_exec && rm temp_exec
                    ;;
                rb)
                    ruby temp.$extension
                    ;;
                php)
                    php temp.$extension
                    ;;
                pl)
                    perl temp.$extension
                    ;;
                *)
                    echo "⚠️ Unknown extension: .$extension — cannot execute."
                    ;;
            esac
            echo "Execution completed."
            echo " "
            echo " "
            echo " "
        elif [ $option -eq 0 ]; then
            echo "Exiting..."
            exit 0

        elif [ $option -eq 2 ]; then
            continue
        elif [ $option -eq 3 ]; then
            break
        else
            echo "Invalid option"
            break
        fi
        let index=$((index+1))

    done
else
    echo "File does not exist."
fi
rm temp.$extension