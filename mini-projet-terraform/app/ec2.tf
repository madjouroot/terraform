provider "aws" {
    shared_credentials_files = ["~/.aws/credentials"]
    region  = "us-east-1"
}


module "app_ec2" {
    source = "../modules/ec2module/" 
    aws_common_tag = {
      Name = "ec2-app-ubuntu"
    }
    bems_SG = module.app_sg.out_sg
    public_ip_default = module.app_ip_public.out_ip_public
    AZ = "us-east-1d"
}

module "app_ip_public" { 
    source = "../modules/ec2_ip_public/" 
    
    
}
module "app_sg" {
    source = "../modules/ec2_sg_module/" 
   
}
module "app_volume_ebs" {
    source = "../modules/volume_ebs_module/" 
  
}

resource "aws_eip_association" "eip_app_ubuntu" {
  instance_id   = module.app_ec2.out_ec2_module
  allocation_id = module.app_ip_public.out_ip_public_id
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = module.app_volume_ebs.out_volume_ebs
  instance_id = module.app_ec2.out_ec2_module

}