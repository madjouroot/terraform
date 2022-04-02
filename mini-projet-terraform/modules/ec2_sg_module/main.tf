resource "aws_security_group" "allow_http_https_ssh_to_BemsAccess1" {
  name        = var.bems_SG
  description = var.description
  
  dynamic "ingress" {
      for_each = var.sg_port

      content {
         from_port   = ingress.value #port.value
         to_port     = ingress.value #port.value
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]
      }
  }
   
  dynamic "egress" {
       for_each = var.sg_port

       content {
         from_port   = egress.value #port.value
         to_port     = egress.value #port.value
         protocol    = "tcp"
         cidr_blocks = ["0.0.0.0/0"]

       }
  }
  # ingress {
  #   description      = "BemsAccess1 from VPC"
  #   from_port        = 443
  #   to_port          = 443
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
    
  # }
  # ingress {
  #   description      = "BemsAccess1 from VPC"
  #   from_port        = 80
  #   to_port          = 80
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]
  # }

  # ingress {
  #   from_port        = 22
  #   to_port          = 22
  #   protocol         = "tcp"
  #   cidr_blocks      = ["0.0.0.0/0"]

  # }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
}