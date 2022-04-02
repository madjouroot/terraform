resource "aws_eip" "ip_public_ubuntu" {
  #instance = aws_instance.myec2Ubuntu.id
  vpc      = true
  # provisioner "local-exec" {
  #   command = <<EOT
  #     echo  eip public IP: ${aws_eip.ip_public_ubuntu.public_ip} >> ../ip_ec2.txt;
  #   EOT
  # }
}