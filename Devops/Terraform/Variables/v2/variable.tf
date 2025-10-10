variable "vpc_cidr_block" {
    type = string
    
}

variable "subnet_cidr_block" {
    type = string 
    
}

variable "az" {
    type = string
    
}

variable "auto_public_ip" {
  type = bool 
  
}

variable "ami_id" {
  type = string 
  
}

variable "ins_type" {
  type = string 

}

variable "keypair" {
  type = string

}
