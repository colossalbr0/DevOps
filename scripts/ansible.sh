#!/bin/bash

# Install Ansible
sudo apt-get update
sudo apt-get install software-properties-common -y
sudo apt-add-repository ppa:ansible/ansible -y
sudo apt-get update -y
sudo apt install ansible -y

sleep 150
cd /home/ubuntu
ansible-playbook playbook.yml -e "domain_name=public.ops.clbro.com email=ops@ops.clbro.com" >> /home/ubuntu/ansible.log 2>&1