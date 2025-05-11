module "networking" {
  source = "./modules/networking"
}

module "ec2" {
  source = "./modules/ec2"
  subnet-id = module.networking.ec2-subnet-id
  security-group-id = module.networking.firewall-sg-id
  sh-script-path = "${path.root}/scripts/ansible.sh"
  playbook-path = "${path.root}/ansible/playbook.yml"
  ssh-pub = "~/.ssh/id_ed25519.pub"
  ssh-priv = "~/.ssh/id_ed25519"
}   

module "dns" {
  source = "./modules/dns"
  dmz = var.dmz
  domain-name = var.domain-name
  ec2-public-ip = module.ec2.public_ip
}

output "ec2-public-ip" {
  value = module.ec2.public_ip
}