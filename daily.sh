#!/bin/bash

# Move to script directory (the repo folder)
cd "$(dirname "$0")"

# Get today's date
TODAY=$(date +%Y-%m-%d)

# Make today's folder if it doesn't exist
mkdir -p "$TODAY"

echo "Organising files into $TODAY..."

# Loop through all items in the repo folder
for ITEM in *; do
    # Skip the script itself, the .git folder, and existing date folders
    if [[ "$ITEM" == "daily.sh" ]]; then continue; fi
    if [[ "$ITEM" == ".git" ]]; then continue; fi
    if [[ "$ITEM" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then continue; fi

    # If it's a file or folder, move it into today's folder
    mv "$ITEM" "$TODAY"/
done

echo "Files moved. Committing..."

# Git process
git add .
git commit -m "Auto upload $TODAY"
git push

echo "Done! Uploaded to GitHub."

