variable "bems_SG" {
  default = "BemsAccess1"
}

variable "description" {
    #default = "Allow BemsAccess1 inbound traffic"
     default = "Ingress and Egress for vault"
}

variable "sg_port" {
  description = "list of ingress and egress ports"
  default = [443,80,22,0]  
}