output "out_ip_public" {
  value       = aws_eip.ip_public_ubuntu.public_ip
}

output "out_ip_public_id" {
  value       = aws_eip.ip_public_ubuntu.id
}

