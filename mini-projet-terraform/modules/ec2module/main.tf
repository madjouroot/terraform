data "aws_ami" "myUbuntuBionic" {
  most_recent = true
  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"] 
  }
}

resource "aws_instance" "myec2Ubuntu" {
  ami           = data.aws_ami.myUbuntuBionic.id
  instance_type = var.instance_type
  availability_zone = var.AZ
  tags = var.aws_common_tag 
  key_name   = "key-madjou"
  security_groups = [var.bems_SG] #[aws_security_group.allow_http_https_ssh_to_BemsAccess1.name] 
  provisioner "remote-exec" {
    inline = [
        #"sudo yum update",
        "sudo apt update -y",
        #"sudo amazon-linux-extras install -y nginx1.12",
        "sudo apt install -y nginx",
        "sudo systemctl start ngnix",
        "sudo systemctl enable nginx"
        #"sudo service nginx start"
    ]

    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("~/key-madjou.pem")
      host = self.public_ip
    }
  }
  

    provisioner "local-exec" {
      command = <<EOT
        echo  ec2 public IP: ${var.public_ip_default} >> ../ip_ec2.txt;
        echo  ec2 public IP: ${self.public_ip} >> ../ip_ec2.txt
      EOT
    }
}