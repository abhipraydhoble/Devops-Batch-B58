# create vpc 

resource "aws_vpc" "net" {
    cidr_block = var.vpc_cidr_block
    tags = {
        Name = "tf-vpc-b58"
    }
}


resource "aws_subnet" "pub" {
    vpc_id = aws_vpc.net.id
    availability_zone = var.az
    cidr_block = var.subnet_cidr_block
    map_public_ip_on_launch = var.auto_public_ip
    tags = {
        Name = "Public-Subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.net.id 
    tags = {
        Name = "igw-tf-vpc-b58"
    }
}


resource "aws_route_table" "rt-pub" {
    vpc_id = aws_vpc.net.id 
    tags = {
        Name = "RT-Public"
    }
   
   route {
    gateway_id = aws_internet_gateway.igw.id 
    cidr_block = "0.0.0.0/0"
   }
}

resource "aws_route_table_association" "rta" {
    route_table_id = aws_route_table.rt-pub.id 
    subnet_id = aws_subnet.pub.id
}
  


resource "aws_security_group" "firewall" {
    name = "tf-vpc-sg"
    vpc_id = aws_vpc.net.id
    
    ingress {
        from_port = 22 
        to_port = 22 
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0 
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}



resource "aws_instance" "server" {
    ami = var.ami_id
    instance_type = var.ins_type
    key_name = var.keypair
    vpc_security_group_ids = [aws_security_group.firewall.id]
    subnet_id = aws_subnet.pub.id 
    user_data = <<-EOF
    #!/bin/bash
    sudo -i
    yum update -y
    yum install httpd -y
    systemctl start httpd 
    systemctl enable httpd 
    echo "Hie Terraform" > /var/www/html/index.html
    EOF

    tags = {
        Name = "webserver"
    }
}



