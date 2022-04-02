variable "instance_type" {
  default = "t2.micro"
}

 variable "bems_SG" {
   default = "BemsAccess1"
}

variable "aws_common_tag" {
  default = {
      Name = "ec2-ubuntu"
  }
}

variable "public_ip_default" {
  default = "NULL"  
}

variable "AZ" {
  default = "us-east-1d"
}
