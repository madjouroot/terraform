provider "aws" {
    #shared_config_files      = ["~/.aws/config"]
  #shared_credentials_files = ["~/.aws/credentials"]
  region  = "us-east-1"
  secret_key = "6i9CXuTEBl6Orv/x6eh/jgQGwXWSHwdZwwJLg0dy"
   access_key = "AKIAUWRVPZDXMIYDJMHM"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0778521d914d23bc1" 
  instance_type = "t2.micro"
  key_name   = "jenkins_key"
  tags = {
    Name = "ubuntu"
  }

  # root_block_device {
  #     delete_on_termination = true
  # }
}
