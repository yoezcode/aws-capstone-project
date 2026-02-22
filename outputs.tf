output "rds_endpoint" {
  value = aws_db_instance.wp.address
}

output "bastion_ip" {
  value = aws_instance.bastion.public_ip
}

output "alb_url" {
  value = aws_lb.wp.dns_name
}

output "asg_name" {
  value = aws_autoscaling_group.wp.name
}