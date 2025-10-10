variable "vpc_cidr_block" {
    type = string
    default = "192.168.0.0/16"
}

variable "subnet_cidr_block" {
    type = string 
    default = "192.168.0.0/22"
}

variable "az" {
    type = string
    default = "ap-southeast-1a"
}

variable "auto_public_ip" {
  type = bool 
  default = true
}

variable "ami_id" {
  type = string 
  default = "ami-088d74defe9802f14"
}

variable "ins_type" {
  type = string 
  default = "t3.micro"
}

variable "keypair" {
  type = string
  default = "tf-key"
}
