#!/bin/bash

declare -A FILE_PARTS

function split_filename {
    # Get file path from command line arguments
    file=${1}

    # Extract filename and extension
    filename=$(basename "$file")
    # Store the name and extension in the associative array
    FILE_PARTS[name]="${filename%.*}"
    FILE_PARTS[extension]="${filename##*.}"
}

function add_fonts {
    files=$(find . -maxdepth 5 -type f -regex '.*\(ttf\|ttc\)$')
    mkdir -p /usr/local/share/fonts/ 2> /dev/null
    for file in $files; do
        mv "$file" "/usr/local/share/fonts/"
    done
    fc-cache /usr/local/share/fonts/ 2> /dev/null
}

function check_sudo {
    # Check if the script is run as root (i.e., with sudo)
    if [ "$EUID" -ne 0 ]; then
        echo "Please run as root"
        exit
    fi
}

function decompress_files {
    # Find all files in downstream directories
    files=$(find . -maxdepth 5 -type f -regex '.*\(zip\|tar\.gz\|tar\.gzip\|tgz\|tar\.bz2\|tar\.bzip2\|tar\.xz\)$')
    rm -r dist 2> /dev/null
    mkdir dist
    cd dist
    for file in $files; do
        case "$file" in
            *.zip* )
                echo "Found .zip file: $file"
                mv "../$file" .
                split_filename $file
                mkdir "${FILE_PARTS[name]}"
                mv "$file" "${FILE_PARTS[name]}/"
                cd "${FILE_PARTS[name]}"
                unzip -o "$file"
                cd ..
                ;;
            *.gzip* | *.tar.gz* )
                echo "Found .gzip or .tar.gz file: $file"
                split_filename $file
                mkdir "${FILE_PARTS[name]}"
                mv "$file" "${FILE_PARTS[name]}/"
                cd "${FILE_PARTS[name]}"
                tar xzf "$file"
                cd ..
                ;;
            *.bzip2* | *.tar.bz2* )
                echo "Found .bzip2 or .tar.bz2 file: $file"
                split_filename $file
                mkdir $FILE_PARTS[name]
                mv "$file" "${FILE_PARTS[name]}/"
                cd "${FILE_PARTS[name]}"
                tar xjf "$file"
                cd ..
                ;;
            * )
                # If file does not match any of the above patterns
                echo "File: $file does not match any decompression patterns"
                ;;
        esac
    done
    cd ..
}


function get_json {
    # Get pattern and extension from command line arguments
    pattern=${1:-fonts}
    extension=${2:-json}
    extract=${2:-true}

    # Find files matching the pattern and extension
    files=$(find . -type f -name "*$pattern*.$extension")

    # Find JSON files containing 'fonts'
    files=$(find . -type f -name '*fonts*.json')

    for file in $files; do
        # Parse JSON file and process each object
        jq -c '.[]' "$file" | while read -r obj; do
            # Extract Uri and Name values
            uri=$(echo "$obj" | jq -r '.url')
            name=$(echo "$obj" | jq -r '.name')

            # Download the file based on the Uri and get the original file name
            original_file_name=$(curl -JLO "$uri" -w '%{filename_effective}' -o /dev/null)

            # If Name doesn't end with a known extension, correct it
        
            ext=$(echo "$original_file_name" | grep -oE '(zip|tar\.gz|tar\.gzip|tgz|tar\.bz2|tar\.bzip2|tar\.xz)' | head -1)
            mv "$original_file_name" "$name.$ext" 2> /dev/null
        
        done
    done
}

function check_jq {
    # Install jq if it's not installed
    if ! command -v jq &> /dev/null
    then
        echo "jq not found. Installing..."
        sudo apt-get update
        sudo apt-get install -y jq
    fi
}

function inner_prompt {
    case "$1" in
    "get")
        # Get pattern and extension from command line arguments
        shift;
        check_jq;
        get_json;
        ;;
    "unpack")
        # Get pattern and extension from command line arguments
        ls *
        decompress_files;
        ;;
    "clean")
        echo "Cleaning up..."
        rm -rf dist
        ;;
    "help")
        echo "Usage: $0 [command] [options]"
        echo "Commands:"
        echo "$0  get [pattern] [extension] - Downloads files described in JSON files matching the pattern and extension. The pattern defaults to 'fonts' and the extension defaults to 'json'. Each downloaded file is renamed to match the 'name' field in the JSON object, with the extension extracted from the original file name."
        echo "$0  unpack - Finds all compressed files in the current directory and subdirectories up to five levels deep. For each file found, it creates a new directory with the same name (excluding the extension), decompresses the file into this directory, and then removes the original file."
        echo "$0  clean - Removes the 'dist' directory if it exists."
        echo "$0  help - Displays this help message."
        echo "$0  pack - Packs all files in the 'dist' directory into a .tar.gz archive named 'fonts.tar.gz'."
        echo "$0  load - Searches the current directory and subdirectories up to five levels deep for .ttf or .ttc files, moves these files into /usr/local/share/fonts/, and then updates the font cache."
        ;;
    "pack")
        echo "Packing files..."
        find dist -type f -name "*.zip" -exec rm {} \;
        find dist/* -maxdepth 0 -type d -exec tar -czvf {}.tar.gz {} \;
        tar -czvf fonts.tar.gz dist
        ;;
    "load")
        check_sudo
        echo "Loading fonts..."
        add_fonts
        ;;
    *)
        echo "Unknown command: $1"
        echo "Use '$0 help' for a list of available commands."
        ;;
    esac
}

function prompt {
    if [ "$1" == "all" ];then
        shift;
        echo "Running all commands .."
        prompt get
        prompt unpack
        sudo prompt load
        prompt pack
        prompt clean
        exit 0
    else
        inner_prompt "$@"
    fi
}

# Call the function with all supplied command line arguments
prompt "$@"
