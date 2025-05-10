resource "aws_vpc" "Main-VPC" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
}


resource "aws_security_group" "Main-VPC-Firewall" {
    vpc_id = aws_vpc.Main-VPC.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_subnet" "Ec2-Subnet" {
    vpc_id = aws_vpc.Main-VPC.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "us-east-1a"
}


resource "aws_internet_gateway" "Main-IGW" {
    vpc_id = aws_vpc.Main-VPC.id
}
 

resource "aws_route_table" "Main-IGW-RT" {
    vpc_id = aws_vpc.Main-VPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Main-IGW.id
    }
}


resource "aws_route_table_association" "Main-IGW-RT-Association" {
    subnet_id = aws_subnet.Ec2-Subnet.id
    route_table_id = aws_route_table.Main-IGW-RT.id
}