resource "aws_ebs_volume" "myebsUbuntu" {
  availability_zone = var.zone_available
  size              = var.size_ebs

}