output "main-vpc-id" {
  value = aws_vpc.Main-VPC.id
}

output "ec2-subnet-id" {
  value = aws_subnet.Ec2-Subnet.id
}

output "firewall-sg-id" {
  value = aws_security_group.Main-VPC-Firewall.id
}