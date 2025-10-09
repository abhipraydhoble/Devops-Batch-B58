# create vpc 

resource "aws_vpc" "net" {
    cidr_block = "192.168.0.0/16"
    tags = {
        Name = "tf-vpc-b58"
    }
}


resource "aws_subnet" "pub" {
    vpc_id = aws_vpc.net.id
    availability_zone = "ap-southeast-1a"
    cidr_block = "192.168.0.0/22"
    map_public_ip_on_launch = true 
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
    ami = "ami-088d74defe9802f14"
    instance_type = "t3.micro"
    key_name = "tf-key"
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



