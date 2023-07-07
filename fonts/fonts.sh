#!/bin/bash

function decompress_files {
    # Find all files in current directory
    files=$(find . -maxdepth 1 -type f)

    for file in $files; do
        case "$file" in
            *.zip* )
                echo "Found .zip file: $file"
                unzip -o "$file"
                ;;
            *.gzip* | *.tar.gz* )
                echo "Found .gzip or .tar.gz file: $file"
                tar xzf "$file"
                ;;
            *.bzip2* | *.tar.bz2* )
                echo "Found .bzip2 or .tar.bz2 file: $file"
                tar xjf "$file"
                ;;
            * )
                # If file does not match any of the above patterns
                echo "File: $file does not match any decompression patterns"
                ;;
        esac
    done
}

# Install jq if it's not installed
if ! command -v jq &> /dev/null
then
    echo "jq not found. Installing..."
    sudo apt-get update
    sudo apt-get install -y jq
fi

if [ "$1" == "clean" ]; then
    jq -c '.[]' fonts-list.json | while read -r obj; do
    	uri=$(echo "$obj" | jq -r '.Uri')
    	name=$(echo "$obj" | jq -r '.Name')    
		rm -rf ./$name
	done
	exit 0
elif [ "$1" != "install" ]; then
	echo "Usage: $0 clean|install"
	exit 1
fi

mkdir "dist"

cd dist

# Read JSON file and process each object
jq -c '.[]' fonts-list.json | while read -r obj; do
    # Extract Uri and Name values
    uri=$(echo "$obj" | jq -r '.Uri')
    name=$(echo "$obj" | jq -r '.Name')

    # Create directory named after "Name" field if it doesn't exist
    mkdir -p "$name"

    # Go to the created directory
    cd "$name" || exit

    # Download the file based on the Uri
    curl -sLO "$uri"

    # Extract file name from Uri
    file=$(basename "$uri")

    # Decompress the downloaded file
    case "$file" in
        *.zip)
            unzip "$file"
            ;;
        *.tar.bz2)
            tar xjf "$file"
            ;;
        *.tar.gz | *.tgz)
            tar xzf "$file"
            ;;
    esac

    # Go back to the parent directory
    cd ..

done

cd ..
