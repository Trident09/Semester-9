#!/bin/bash

# Create a directory
echo "Creating directory 'test_dir'..."
mkdir test_dir

# Create a text file inside it
echo "Creating file 'test_file.txt' inside test_dir..."
touch test_dir/test_file.txt

# Append content to the file
echo "Appending content to the file..."
echo "This is the first line." >> test_dir/test_file.txt
echo "This is the second line." >> test_dir/test_file.txt

# Display file contents
echo "Displaying file contents:"
cat test_dir/test_file.txt

# Delete the file and directory
echo "Deleting file and directory..."
rm test_dir/test_file.txt
rmdir test_dir

echo "Operations completed successfully!"