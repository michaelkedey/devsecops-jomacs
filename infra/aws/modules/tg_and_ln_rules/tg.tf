resource "aws_lb_listener_rule" "project_rule" {
  listener_arn = var.listener_arn
  priority     = var.listener_rule_priority
  action {
    type             = var.listener_rule_action
    target_group_arn = aws_lb_target_group.project_target_group.arn
  }
  condition {
    path_pattern {
      values = [var.listener_rule_path]
    }
  }
  tags = merge(
    var.tags_all,
    {
      Name = var.ln_rule_name
    }
  )
}

#app target group for load balancer
resource "aws_lb_target_group" "project_target_group" {
  name     = var.tg_name
  port     = var.ports["app"]
  protocol = var.protocols[0]
  vpc_id   = var.vpc_id

  tags = merge(
    var.tags_all,
    {
      Name = var.tg_name
    }
  )
}

#associate the instance with the target group
resource "aws_lb_target_group_attachment" "project_app_tg_attachment" {
  target_group_arn = aws_lb_target_group.project_target_group.arn
  target_id        = var.instance_id
  port             = var.ports["app"]
}