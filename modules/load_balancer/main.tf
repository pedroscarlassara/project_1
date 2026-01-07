resource "aws_lb_target_group_attachment" "project-target-group-instance"{
  target_group_arn = aws_lb_target_group.project-alb-target-group.arn
  target_id = var.application_instance_id
  port = 80
}

resource "aws_lb_target_group" "project-alb-target-group" {
  name = "project-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
}

resource "aws_lb" "project-alb" {
  name = "project-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [var.alb_sg_id]
  subnets = [var.project_public_subnet_1_id, var.project_public_subnet_2_id]

  tags = {
    Name = "Project ALB"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.project-alb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.project-alb-target-group.arn
  }
}