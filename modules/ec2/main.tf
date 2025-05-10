module "networking" {
  source = "../networking"
}

data "aws_ami" "ubuntu" {
    most_recent = true

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["099720109477"]
}


resource "aws_key_pair" "sshkey" {
  key_name   = "ops-key"
  public_key = file(var.ssh-pub)
}


resource "aws_instance" "main" {
    ami           = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id     = var.subnet-id
    vpc_security_group_ids = [var.security-group-id]
    key_name      = aws_key_pair.sshkey.key_name
    user_data     = file("${var.sh-script-path}")  # install ansible, sleep for 180s, then run playbook to install nginx!

    connection {
        type        = "ssh"
        user        = "ubuntu"
        private_key = file(var.ssh-priv)
        host        = self.public_ip
    }

    provisioner "file" {
        source = "${var.playbook-path}"
        destination = "/home/ubuntu/playbook.yml"
    }
}