#!/bin/bash

# Function to extract file ID from Google Drive link
get_file_id() {
    echo $1 | awk 'gsub("&export=download", "", $0)' | grep -Po 'id=\K[^"&?]*'
}

echo "Enter Google Drive Link: "
read link

# Validate that a link has been provided
if [ -z "$link" ]; then
    echo "Error: Please enter a Google Drive link."
    exit 1
fi

echo "Enter File Name: "
read filename

# Extract file ID from the link
fileid=$(get_file_id "$link")

# Validate that the file ID was successfully extracted
if [ -z "$fileid" ]; then
    echo "Error: Unable to extract file ID from the provided link."
    exit 1
fi

# Construct the final download link
final_link="https://drive.google.com/uc?id=${fileid}&export=download&confirm=yes"

# Download the file using curl
curl -o "$filename" -L "$final_link"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "Download complete. File saved as: $filename"
else
    echo "Error: Unable to download the file."
fi
