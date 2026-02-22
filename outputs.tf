output "wordpress_url" {
  value = "http://${aws_instance.wordpress.public_ip}"
}

output "rds_endpoint" {
  value = aws_db_instance.wp.address
}

output "bastion" {
  value = aws_instance.bastion.public_ip
}