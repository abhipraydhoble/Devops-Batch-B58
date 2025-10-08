resource "aws_security_group" "firewall" {
    name = "terraform-demo-sg"
    vpc_id = "vpc-0cbfb6660e08bb029"  
    
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
