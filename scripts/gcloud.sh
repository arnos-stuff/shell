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



cd $HOME

curl -LO "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-437.0.
1-linux-x86_64.tar.gz?hl=fr"

decompress_files

echo "export PATH=\"$PATH;$HOME/google-cloud-sdk/bin\"" >> .bashrc

echo "export PATH=\"$PATH;$HOME/google-cloud-sdk/bin\"" >> .zshrc
