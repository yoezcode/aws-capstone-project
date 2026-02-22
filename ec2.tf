data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}

resource "aws_instance" "wordpress" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.private_a.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = false
  key_name                    = aws_key_pair.capstone.key_name

  user_data = templatefile("${path.module}/userdata.sh.tmpl", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
    db_host     = aws_db_instance.wp.endpoint
  })
  depends_on = [aws_nat_gateway.nat, aws_db_instance.wp]

  tags = {
    Name = "wordpress-webserver"
  }
}