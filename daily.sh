#!/bin/bash

# Go to script folder (repo)
cd "$(dirname "$0")"

# Today's date
TODAY=$(date +%Y-%m-%d)

# Make today's folder
mkdir -p "$TODAY"

echo "Organizing files into $TODAY..."

# Move all files/folders except .git, daily.sh, and date folders
shopt -s dotglob nullglob
for ITEM in *; do
    if [[ "$ITEM" == ".git" ]] || [[ "$ITEM" == "daily.sh" ]] || [[ "$ITEM" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
        continue
    fi
    mv "$ITEM" "$TODAY"/
done

echo "Files moved. Committing..."

# Git commands
git add .
git commit -m "Auto upload $TODAY"
git push

echo "Done! Uploaded to GitHub."
