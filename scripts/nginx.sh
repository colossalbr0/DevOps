#!/bin/bash

#wonky way to install nginx. Should probaby add checks later.
sudo apt-get update


echo "Installing Nginx..."
sudo apt-get install nginx -y


echo "Starting Nginx..."
sudo systemctl start nginx

echo "Enabling Nginx to start on boot..."
sudo systemctl enable nginx
