#!/bin/bash

# Function to display menu options
display_menu() {
    echo "Please select an option:"
    echo "1) Update all installed packages"
    echo "2) Upgrade a specific package"
    echo "3) List all installed packages"
    echo "4) Install a new package"
    echo "5) Remove a package"
    echo "6) Exit"
}

# Function to perform actions based on user input
execute_option() {
    case $1 in
        1)
            echo "Updating all installed packages..."
            sudo apt update && sudo apt upgrade -y
            ;;
        2)
            read -p "Enter the name of the package to upgrade: " package
            if [ -n "$package" ]; then
                echo "Upgrading package: $package..."
                sudo apt install --only-upgrade "$package" -y
            else
                echo "No package name provided. Skipping."
            fi
            ;;
        3)
            echo "Listing all installed packages..."
            dpkg --get-selections | less
            ;;
        4)
            read -p "Enter the name of the package to install: " package
            if [ -n "$package" ]; then
                echo "Installing package: $package..."
                sudo apt install "$package" -y
            else
                echo "No package name provided. Skipping."
            fi
            ;;
        5)
            read -p "Enter the name of the package to remove: " package
            if [ -n "$package" ]; then
                echo "Removing package: $package..."
                sudo apt remove "$package" -y
            else
                echo "No package name provided. Skipping."
            fi
            ;;
        6)
            echo "Exiting script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac
}

# Main script loop
while true; do
    display_menu
    read -p "Enter your choice (1-6): " choice
    execute_option "$choice"
done
