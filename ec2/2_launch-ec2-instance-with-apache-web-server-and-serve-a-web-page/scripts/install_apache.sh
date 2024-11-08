#!/bin/bash
# Update package lists
sudo apt update -y

# Install Apache2
sudo apt install apache2 -y

# Start Apache and enable it to start on boot
sudo systemctl start apache2
sudo systemctl enable apache2

# Create a custom HTML page to be served by Apache
echo '<!DOCTYPE html>' | sudo tee /var/www/html/index.html > /dev/null
echo '<html lang="en">' | sudo tee -a /var/www/html/index.html > /dev/null
echo '<body style="background-color:black;">' | sudo tee -a /var/www/html/index.html > /dev/null
echo '  <h1 style="color:red;">Week 20 Terraform Project: HTTP access successfully configured!</h1>' | sudo tee -a /var/www/html/index.html > /dev/null
echo '</body>' | sudo tee -a /var/www/html/index.html > /dev/null
echo '</html>' | sudo tee -a /var/www/html/index.html > /dev/null
