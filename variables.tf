variable "region" {
  default = "us-west-2"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "project_name" {
  default = "aws-capstone-project"
}

variable "ssh_allowed_ip" {
  description = "Your public IP"
  sensitive   = true
}

variable "db_name" {
  default = "wordpress"
}

variable "db_user" {
  default = "wp_user"
}

variable "db_password" {
  sensitive = true
}