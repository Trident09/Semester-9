#!/bin/bash

# Backup Script

echo "Directory Backup Script"
echo "======================="

# Read directory to backup
read -p "Enter directory path to backup: " source_dir

# Check if directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Directory '$source_dir' does not exist!"
    exit 1
fi

# Read backup destination
read -p "Enter backup destination path: " backup_dest

# Create backup destination if it doesn't exist
if [ ! -d "$backup_dest" ]; then
    mkdir -p "$backup_dest"
fi

# Get current date and time
current_date=$(date +"%Y%m%d_%H%M%S")

# Get directory name for backup filename
dir_name=$(basename "$source_dir")

# Create backup filename
backup_file="${backup_dest}/${dir_name}_backup_${current_date}.tar.gz"

# Create backup
echo "Creating backup..."
tar -czf "$backup_file" -C "$(dirname "$source_dir")" "$(basename "$source_dir")"

# Check if backup was successful
if [ $? -eq 0 ]; then
    echo "Backup created successfully!"
    echo "Backup file: $backup_file"
    echo "Backup size: $(du -h "$backup_file" | cut -f1)"
else
    echo "Error: Backup failed!"
    exit 1
fi