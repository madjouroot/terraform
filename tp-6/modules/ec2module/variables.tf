variable "instance_type" {
  default = "t2.nano"
}

variable "bems_SG" {
  default = "BemsAccess1"
}

variable "aws_common_tag" {
  default = {
      Name = "ec2-bems"
  }
}