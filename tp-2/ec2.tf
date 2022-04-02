provider "aws" {
    #shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
  region  = "us-east-1"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0c02fb55956c7d316" 
  instance_type = "t2.micro"
  key_name   = "key-madjou"
  tags = {
    Name = "ec2-bems"
  }

  # root_block_device {
  #     delete_on_termination = true
  # }
}
