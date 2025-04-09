resource "aws_lb" "project_lb" {
  name               = var.names["lb"]
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.project_lb_sg.id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets                          = var.subnet_ids
  enable_deletion_protection       = var.delete_ptotection
  enable_cross_zone_load_balancing = var.cross_zone
  tags = merge(
    var.tags_all,
    {
      Name = var.names["lb"]
    }
  )
}

resource "aws_lb_listener" "project_lb_listener" {
  load_balancer_arn = aws_lb.project_lb.id
  port              = var.ports["app"]
  protocol          = var.protocols[0]
  default_action {
    type             = var.lb_default_action
    target_group_arn = aws_lb_target_group.default_target_group.id
  }
  tags = merge(
    var.tags_all,
    {
      Name = var.names["lb"]
    }
  )
}

resource "aws_lb_target_group" "default_target_group" {
  name     = var.names["df_lb_tg"]
  port     = var.ports["app"]
  protocol = var.protocols[0]
  vpc_id   = var.vpc_id

  tags = merge(
    var.tags_all,
    {
      Name = var.names["df_lb_tg"]
    }
  )
}

# resource "aws_lb_listener_rule" "project_app_rule" {
#   listener_arn = "${aws_lb_listener.project_lb_listener.arn}"
#   priority     = var.listener_rule_priority["first"] 
#   action {
#     type             = var.listener_rule_action 
#     target_group_arn = "${aws_lb_target_group.project_app_target_group.arn}"
#   }
#   condition {
#     path_pattern {
#       values = ["app"]
#      }
#    }
# }

# resource "aws_lb_listener_rule" "project_elk_rule" {
#   listener_arn = "${aws_lb_listener.project_lb_listener.arn}"
#   priority     = var.listener_rule_priority["second"]
#   action {
#     type             = var.listener_rule_action 
#     target_group_arn = "${aws_lb_target_group.project_elk_target_group.arn}"
#   }
#   condition {
#     path_pattern {
#       values = ["elk"]
#      }
#    }
# }

# #app target group for load balancer
# resource "aws_lb_target_group" "project_app_target_group" {
#   name     = var.names["app-tg"]
#   port     = var.ports["app"]
#   protocol = var.protocols[0]
#   vpc_id   = var.vpc_id

#   tags = merge(
#     var.tags_all,
#     {
#       Name = var.names["app-tg"]
#     }
#   )
# }

# #associate the instance with the target group
# resource "aws_lb_target_group_attachment" "project_app_tg_attachment" {
#   target_group_arn = aws_lb_target_group.project_app_target_group.arn
#   target_id        = var.instance_id
#   port             = var.ports["app"]
# }

# #elk target group for load balancer
# resource "aws_lb_target_group" "project_elk_target_group" {
#   name     = var.names["elk-tg"]
#   port     = var.ports["elk"]
#   protocol = var.protocols[0]
#   vpc_id   = var.vpc_id

#   tags = merge(
#     var.tags_all,
#     {
#       Name = var.names["elk-tg"]
#     }
#   )
# }

# #associate the instance with the target group
# resource "aws_lb_target_group_attachment" "project_elk_tg_attachment" {
#   target_group_arn = aws_lb_target_group.project_elk_target_group.arn
#   target_id        = var.instance_id
#   port             = var.ports["elk"]
# }

#security group for load balancer
#necessary in order to set the id for the ingress app traffic in the instance sg
resource "aws_security_group" "project_lb_sg" {
  ingress {
    from_port   = var.ports["app"]
    to_port     = var.ports["app"]
    protocol    = var.protocols[2]
    cidr_blocks = var.default_route
  }

  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols[1]
    cidr_blocks = var.default_route
  }
  name   = var.names["lb_sg"]
  vpc_id = var.vpc_id

  tags = merge(
    var.tags_all,
    {
      Name = var.names["lb_sg"]
    }
  )
}

#security group for instances
resource "aws_security_group" "project_instance_sg" {
  name     = var.names["instance_sg"]
  vpc_id   = var.vpc_id
  provider = aws.project_region

  #this rule allows ssh traffic on a custom port
  ingress {
    from_port       = var.ports["custom_ssh"]
    to_port         = var.ports["custom_ssh"]
    protocol        = var.protocols[2]
    security_groups = [aws_security_group.project_jumper_sg.id]
  }
  #this rule allows ingress app traffic from the lb only
  ingress {
    from_port       = var.ports["app"]
    to_port         = var.ports["app"]
    protocol        = var.protocols[2]
    security_groups = [aws_security_group.project_lb_sg.id]
  }

  #this rule allows all traffic out
  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols[1]
    cidr_blocks = var.default_route

  }

  tags = merge(
    var.tags_all,
    {
      Name = var.names["instance_sg"]
    }
  )
}

#security group for jumper
resource "aws_security_group" "project_jumper_sg" {
  name     = var.names["jumper_sg"]
  vpc_id   = var.vpc_id
  provider = aws.project_region

  #this rule allows ssh traffic on a custom port
  ingress {
    from_port   = var.ports["custom_ssh"]
    to_port     = var.ports["custom_ssh"]
    protocol    = var.protocols[2]
    cidr_blocks = var.default_route #modify to your own ip for mor security
  }

  #this rule allows all traffic out
  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols[1]
    cidr_blocks = var.default_route

  }

  tags = merge(
    var.tags_all,
    {
      Name = var.names["jumper_sg"]
    }
  )
}

#security group for elk
resource "aws_security_group" "project_elk_sg" {
  name     = var.names["elk_sg"]
  vpc_id   = var.vpc_id
  provider = aws.project_region

  #this rule allows ssh traffic on a custom port
  ingress {
    from_port       = var.ports["custom_ssh"]
    to_port         = var.ports["custom_ssh"]
    protocol        = var.protocols[2]
    security_groups = [aws_security_group.project_lb_sg.id]
  }

  ingress {
    from_port       = var.ports["elk"]
    to_port         = var.ports["elk"]
    protocol        = var.protocols[2]
    security_groups = [aws_security_group.project_lb_sg.id]
  }

  #this rule allows all traffic out
  egress {
    from_port   = var.ports["all"]
    to_port     = var.ports["all"]
    protocol    = var.protocols[1]
    cidr_blocks = var.default_route

  }

  tags = merge(
    var.tags_all,
    {
      Name = var.names["jumper_sg"]
    }
  )
}