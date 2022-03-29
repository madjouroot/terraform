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
  security_groups = [aws_security_group.allow_BemsAccess1.name]

  provisioner "remote-exec" {
    inline = [
        "sudo yum update",
        "sudo amazon-linux-extras install -y nginx1.12",
        #"sudo systemctl start ngnix"
        "sudo service nginx start"
    ]

    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = file("~/key-madjou.pem")
      host = self.public_ip
    }
  }
}

resource "aws_security_group" "allow_BemsAccess1" {
  name        = "BemsAccess1"
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

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_eip" "lb" {
  instance = aws_instance.myec2.id
  vpc      = true
  # provisioner "local-exec" {
  #   command = "echo  {public IP: ${aws_eip.lb.public_ip} AZ: ${aws_instance.myec2.availability_zone} HOST: ${aws_instance.myec2.id}}>> info_ec2.txt"
  # }

  provisioner "local-exec" {
    command = <<EOT
      echo  public IP: ${aws_eip.lb.public_ip} >> info_ec2.txt;
      echo AZ: ${aws_instance.myec2.availability_zone} >> info_ec2.txt;
      echo HOST: ${aws_instance.myec2.id} >> info_ec2.txt
   EOT
  }
}

# output "instance_ip2" {
#   value       = aws_eip.lb.public_ip
# }

# output "instance_ip3" {
#   value       = aws_instance.myec2.public_ip
# }
