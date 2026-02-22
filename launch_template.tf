resource "aws_launch_template" "wp" {
  name_prefix   = "wp-template"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.capstone.key_name

  vpc_security_group_ids = [aws_security_group.web.id]

  #launch templates require base64 encoded
  user_data = base64encode(templatefile("${path.module}/userdata.sh.tmpl", {
    db_name     = var.db_name
    db_user     = var.db_user
    db_password = var.db_password
    db_host     = aws_db_instance.wp.address
  }))

}