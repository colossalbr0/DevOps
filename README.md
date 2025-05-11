# AWS Infrastructure with Terraform and Ansible

This project automates the deployment of a web server infrastructure on AWS using Terraform for infrastructure provisioning and Ansible for configuration management. It includes automatic SSL certificate provisioning and NS records creation on cloudflare, allowing Route53 to manage the domain of choice.

## Project Structure

```
.
├── main.tf                 # Root Terraform configuration
├── variables.tf            # Root level variables
├── terraform.tfvars        # Variable values (gitignored)
├── modules/
│   ├── networking/        # VPC, Subnet, Security Groups
│   ├── ec2/              # EC2 Instance configuration
│   ├── dns/              # Route53 DNS management
│   └── cloudflare/       # Cloudflare DNS management
├── ansible/
│   └── playbook.yml      # Nginx and SSL configuration
└── scripts/
    └── ansible.sh        # Instance initialization script
```

## Prerequisites

- Terraform >= 1.0.0
- AWS CLI configured with appropriate credentials
- A registered domain
- Cloudflare API token (assuming cloudflare is used to manage your domain name)
- Cloudflare Zone ID (also assuming cloudflare is used to manage your domain name)
- Ansible >= 2.9.0

## Required Variables
Create a `terraform.tfvars` file with the following variables:

```hcl
# Cloudflare Configuration
cloudflare-zone-id = "your-api-token"
cloudflare-api-token = "your-account-id"
```

This project assumes your domain name is managed by cloudflare. As such, you also need to set the dmz and sub-domain-name variables in the ```main.tf``` at the root level.
```hcl
module "dns" {
  source = "./modules/dns"
  dmz = var.dmz
  sub-domain-name = var.sub-domain-name   #replace this with your domnain name, e.g example.com
  ec2-public-ip = module.ec2.public_ip    #replace the subdomain that'll point to your EC2 instance, e.g ec2.example.com
}
```

## Infrastructure Components

### Networking Module
- VPC with public subnet
- Internet Gateway
- Route Table
- Security Group (SSH, HTTP, HTTPS)

### EC2 Module
- Ubuntu 22.04 LTS instance
- User data script for Ansible installation
- Automatic Nginx and SSL configuration

### DNS Module
- Route53 public hosted zone
- A records for domain and subdomain
- Automatic DNS record management 
- Automatic DNS (NS) record creation on cloudflare 
- SSL/TLS configuration

## Usage

1. Initialize Terraform:
```bash
terraform init
```

2. Review the planned changes:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply
```

4. To destroy the infrastructure:
```bash
terraform destroy
```

## Features

- **Automated Infrastructure**: Complete infrastructure provisioning with a single command
- **SSL Certificates**: Automatic SSL certificate provisioning using Certbot
- **DNS Management**: Automatic DNS NS management through Cloudflare
- **Security**: Proper security group configuration and SSL/TLS setup
- **Scalability**: Modular design allows for easy scaling and modification