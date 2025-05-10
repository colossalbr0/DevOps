# AWS Infrastructure with Terraform and Ansible

This project automates the deployment of a web server infrastructure on AWS using Terraform for infrastructure provisioning and Ansible for configuration management. It includes automatic DNS management through Cloudflare and SSL certificate provisioning.

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
- Cloudflare API token
- Ansible >= 2.9.0

## Required Variables

Create a `terraform.tfvars` file with the following variables:

```hcl
# AWS Configuration
aws_region = "us-east-1"

# Cloudflare Configuration
cloudflare_api_token = "your-api-token"
cloudflare_account_id = "your-account-id"

# Domain Configuration
domain_name = "yourdomain.com"
subdomain = "www"
email = "your-email@domain.com"
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

### Cloudflare Module
- Automatic DNS record creation
- SSL/TLS configuration
- Proxy configuration

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
- **DNS Management**: Automatic DNS record management through Cloudflare
- **Security**: Proper security group configuration and SSL/TLS setup
- **Scalability**: Modular design allows for easy scaling and modification

## Security Considerations

- SSH access is restricted to specific IP ranges
- SSL/TLS is enabled by default
- Security groups are configured with minimal required access
- Sensitive variables are marked as sensitive in Terraform

## Maintenance

### Adding New Domains
1. Update the `terraform.tfvars` file with new domain information
2. Run `terraform apply`

### Updating SSL Certificates
- Certificates are automatically renewed by Certbot
- Manual renewal can be triggered through Ansible

### Scaling
- The modular design allows for easy addition of new instances
- DNS records are automatically updated for new instances

## Troubleshooting

### Common Issues

1. **SSL Certificate Issues**
   - Check Certbot logs: `sudo certbot certificates`
   - Verify DNS propagation
   - Check security group rules

2. **DNS Propagation**
   - Verify Cloudflare configuration
   - Check DNS record TTL
   - Verify domain registration

3. **Instance Access**
   - Verify security group rules
   - Check instance status
   - Verify SSH key configuration

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Terraform AWS Provider
- Cloudflare Provider
- Ansible
- Certbot 