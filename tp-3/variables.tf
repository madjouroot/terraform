variable "instance_type" {
  default = "t2.nano"
}

variable "aws_common_tag" {
  default = {
      Name = "ec2-bems"
  }
}

variable "bems_SG" {
   default = "BemsAccess1"
}
