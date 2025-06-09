#!/bin/bash
echo "Welcome to Debucker"
index=1
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

    while IFS= read -r line; do
        echo "$index:  $line"
        read -p "Enter:  " option

        if [ "$option" -eq 1 ]; then
            echo "$line" >> temp.$extension
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
                    read -p "1. GCC or 2. clang" compiler;
                    if [ compiler==1 ]; then
                        gcc temp.$extension -o temp.exe && ./temp.exe && rm temp.exe
                    
                    elif [ compiler==2 ]; then
                        clang temp.$extension -o temp.exe && ./temp.exe && rm temp.exe
                    else
                        echo "⚠️ Unknown compiler choice."
                    fi
                    ;;
                cpp)
                    read -p "1. G++ or 2. clang++" compiler;
                    if [ compiler==1 ]; then
                        g++ temp.$extension -o temp.exec && ./temp.exe && rm temp.exe
                    elif [ compiler==2 ]; then
                        clang++ temp.$extension -o temp.exe && ./temp.exe && rm temp.exe
                    else
                        echo "⚠️ Unknown compiler choice."
                    fi 
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

        elif [ "$option" -eq 2 ]; then
            continue

        elif [ "$option" -eq 3 ]; then
            exit 0

        else
            echo "Invalid option"
            break
        fi

        index=$((index + 1))
    done < "$file_name.$extension"
else
    echo "File does not exist."
fi

rm temp.$extension
