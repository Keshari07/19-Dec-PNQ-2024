#!/bin/bash

# Function to display the menu
display_menu() {
    echo "Please select a task:"
    echo "1) User Management"
    echo "2) SELinux Management"
    echo "3) Firewall Management"
    echo "4) SSH Security"
    echo "5) Exit"
}

# Function for user management
user_management() {
    echo "User Management Options:"
    echo "1) Add a new user"
    echo "2) Set a password for a user"
    echo "3) Delete a user"
    read -p "Choose an option (1-3): " um_option

    case $um_option in
        1)
            read -p "Enter the username to add: " username
            sudo useradd "$username" && echo "User $username added."
            ;;
        2)
            read -p "Enter the username to set password for: " username
            sudo passwd "$username"
            ;;
        3)
            read -p "Enter the username to delete: " username
            sudo userdel "$username" && echo "User $username deleted."
            ;;
        *)
            echo "Invalid option for User Management."
            ;;
    esac
}

# Function for SELinux management
selinux_management() {
    echo "SELinux Management Options:"
    echo "1) Check SELinux status"
    echo "2) Temporarily disable SELinux"
    echo "3) Permanently disable SELinux"
    read -p "Choose an option (1-3): " se_option

    case $se_option in
        1)
            sestatus
            ;;
        2)
            sudo setenforce 0 && echo "SELinux temporarily disabled."
            ;;
        3)
            sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config && echo "SELinux permanently disabled."
            ;;
        *)
            echo "Invalid option for SELinux Management."
            ;;
    esac
}

# Function for Firewall management
firewall_management() {
    echo "Firewall Management Options:"
    echo "1) List active firewall rules"
    echo "2) Add a service (e.g., HTTP)"
    echo "3) Reload the firewall"
    read -p "Choose an option (1-3): " fw_option

    case $fw_option in
        1)
            sudo ufw status verbose
            ;;
        2)
            read -p "Enter the service to add (e.g., http): " service
            sudo ufw allow "$service" && echo "Service $service added."
            ;;
        3)
            sudo ufw reload && echo "Firewall rules reloaded."
            ;;
        *)
            echo "Invalid option for Firewall Management."
            ;;
    esac
}

# Function for SSH security
ssh_security() {
    echo "SSH Security Options:"
    echo "1) Restrict SSH root login"
    echo "2) Restart SSH service"
    echo "3) Generate an SSH key"
    read -p "Choose an option (1-3): " ssh_option

    case $ssh_option in
        1)
            sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config && echo "Root login restricted."
            ;;
        2)
            sudo systemctl restart sshd && echo "SSH service restarted."
            ;;
        3)
            ssh-keygen -t rsa -b 4096 && echo "SSH key generated."
            ;;
        *)
            echo "Invalid option for SSH Security."
            ;;
    esac
}

# Main script loop
while true; do
    display_menu
    read -p "Enter your choice (1-5): " choice

    case $choice in
        1)
            user_management
            ;;
        2)
            selinux_management
            ;;
        3)
            firewall_management
            ;;
        4)
            ssh_security
            ;;
        5)
            echo "Exiting script. Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            ;;
    esac
done
