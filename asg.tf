resource "aws_autoscaling_group" "wp" {
  name = "wp-asg"

  desired_capacity = 2
  max_size         = 3
  min_size         = 1

  vpc_zone_identifier = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id
  ]

  launch_template {
    id      = aws_launch_template.wp.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.wp.arn]

  health_check_type         = "ELB"
  health_check_grace_period = 300

  tag {
    key                 = "Name"
    value               = "wordpress"
    propagate_at_launch = true
  }
}