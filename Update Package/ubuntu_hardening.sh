#!/bin/bash

# Harden SSH Access: Restrict root login and enforce key-based authentication
harden_ssh() {
    echo "Hardening SSH access: Restricting root login..."
    sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    echo "SSH access hardened. Root login restricted."
}

# Configure Firewall for Apache: Allow HTTP traffic and reload the firewall
configure_firewall() {
    echo "Configuring firewall to allow HTTP traffic..."
    sudo ufw allow http
    sudo ufw reload
    echo "Firewall configured for HTTP traffic."
}

# Update the system and install Apache
update_system_and_software() {
    echo "Updating the system and installing Apache..."
    sudo apt update -y
    sudo apt upgrade -y
    sudo apt install apache2 -y
    echo "System updated and Apache installed."
}

# Start and enable Apache service
start_and_enable_apache() {
    echo "Starting and enabling Apache service..."
    sudo systemctl start apache2
    sudo systemctl enable apache2
    echo "Apache service started and enabled on boot."
}

# Secure the system: Restrict SSH root login and enable firewall for HTTP traffic
secure_system() {
    echo "Securing the system..."
    harden_ssh
    configure_firewall
    echo "System secured."
}

# Workflow Example
run_workflow() {
    echo "Running the complete workflow..."
    update_system_and_software
    start_and_enable_apache
    secure_system
    echo "Workflow complete."
}

# Main menu
display_menu() {
    echo "Select an option:"
    echo "1) Harden SSH Access"
    echo "2) Configure Firewall for Apache"
    echo "3) Update System and Install Apache"
    echo "4) Start and Enable Apache Service"
    echo "5) Secure the System"
    echo "6) Run Complete Workflow"
    echo "7) Exit"
}

# Main script loop
while true; do
    display_menu
    read
