provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region  = "us-east-1"
}

data "aws_ami" "myServer" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}

resource "aws_instance" "myec2" {
  ami           = data.aws_ami.myServer.id #"ami-0c02fb55956c7d316" 
  instance_type = var.instance_type
  key_name   = "key-madjou"
  tags = var.aws_common_tag
  #security_groups = [aws_security_group.allow_BemsAccess1.name]
  security_groups = [var.bems_SG]
}

resource "aws_security_group" "allow_BemsAccess1" {
  name        = var.bems_SG  #"BemsAccess1"
  description = "Allow BemsAccess1 inbound traffic"
 
  ingress {
    description      = "BemsAccess1 from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  ingress {
    description      = "BemsAccess1 from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    }
}

resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
}

output "instance_ips" {
 value       = aws_eip.lb.public_ip
}


