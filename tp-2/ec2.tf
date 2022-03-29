provider "aws" {
    #shared_config_files      = ["~/.aws/config"]
    shared_credentials_files = ["~/.aws/credentials"]
  region  = "us-east-1"
  #access_key = "AKIAYCQBZLVWGSDO6IDP"
  #secret_key =  "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"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0c02fb55956c7d316" #"ami-0057d8e6fb0692b80" 
  instance_type = "t2.micro"
  key_name   = "key-madjou"
  tags = {
    Name = "ec2-bems"
  }

  # root_block_device {
  #     delete_on_termination = true
  # }
}
