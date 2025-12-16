#!/bin/bash

# macOS User Input Validation Script

echo "User Validation Script (macOS)"
echo "=============================="

# Read username from user
read -p "Enter username to check: " username

# Check if user exists on macOS
if dscl . -read /Users/"$username" &>/dev/null; then
    echo "User '$username' exists on the system."

    echo "User Information:"
    echo "-----------------"
    dscl . -read /Users/"$username" \
        UniqueID \
        RealName \
        NFSHomeDirectory \
        UserShell

else
    echo "User '$username' does not exist on the system."

    read -p "Would you like to create this user? (y/n): " create_user

    if [[ "$create_user" == "y" || "$create_user" == "Y" ]]; then
        echo "Creating user '$username'..."

        # Get next available UID (macOS users usually start from 501)
        next_uid=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -n | tail -1)
        next_uid=$((next_uid + 1))

        sudo dscl . -create /Users/"$username"
        sudo dscl . -create /Users/"$username" UserShell /bin/bash
        sudo dscl . -create /Users/"$username" RealName "$username"
        sudo dscl . -create /Users/"$username" UniqueID "$next_uid"
        sudo dscl . -create /Users/"$username" PrimaryGroupID 20
        sudo dscl . -create /Users/"$username" NFSHomeDirectory /Users/"$username"

        sudo mkdir /Users/"$username"
        sudo chown -R "$username":staff /Users/"$username"

        if [ $? -eq 0 ]; then
            echo "User '$username' created successfully."
            sudo passwd "$username"
        else
            echo "Error: Failed to create user. Check your privileges."
        fi
    else
        echo "User creation cancelled."
    fi
fi