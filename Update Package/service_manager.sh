#!/bin/bash

# Function to display menu options
display_menu() {
    echo "Please select an option to manage a service:"
    echo "1) Start a service"
    echo "2) Stop a service"
    echo "3) Restart a service"
    echo "4) Check service status"
    echo "5) Enable service to start on boot"
    echo "6) Disable service from starting on boot"
    echo "7) Exit"
}

# Function to perform actions based on user input
execute_option() {
    read -p "Enter the name of the service (e.g., apache2): " service
    if [ -z "$service" ]; then
        echo "No service name provided. Please try again."
        return
    fi

    case $1 in
        1)
            echo "Starting service: $service..."
            sudo systemctl start "$service"
            ;;
        2)
            echo "Stopping service: $service..."
            sudo systemctl stop "$service"
            ;;
        3)
            echo "Restarting service: $service..."
            sudo systemctl restart "$service"
            ;;
        4)
            echo "Checking status of service: $service..."
            sudo systemctl status "$service"
            ;;
        5)
            echo "Enabling service to start on boot: $service..."
            sudo systemctl enable "$service"
            ;;
        6)
            echo "Disabling service from starting on boot: $service..."
            sudo systemctl disable "$service"
            ;;
        7)
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
    read -p "Enter your choice (1-7): " choice
    execute_option "$choice"
done
