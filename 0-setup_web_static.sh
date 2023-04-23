#!/usr/bin/env bash

# Update apt-get
sudo apt-get update

# Install Nginx if not already installed
sudo apt-get -y install nginx

# Create required directories
sudo mkdir -p /data/web_static/releases/test/
sudo mkdir -p /data/web_static/shared/
sudo mkdir -p /data/web_static/releases/

# Create a fake HTML file for testing
echo "This is a test" | sudo tee /data/web_static/releases/test/index.html

# Create symbolic link
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current

# Give ownership of the /data/ folder to the ubuntu user and group
sudo chown -R ubuntu:ubuntu /data/
chgrp -R ubuntu /data/

# Update Nginx configuration
sudo sed -i '44i\ \tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-enabled/default

# Restart Nginx service
sudo service nginx restart


