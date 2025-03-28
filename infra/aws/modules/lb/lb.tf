resource "aws_lb" "project_lb" {
  name               = var.names["lb"]
  internal           = var.lb_internal
  load_balancer_type = var.lb_type
  security_groups    = [aws_security_group.project_lb_sg.id]
  #subnets            = [for subnet in aws_subnet.public : subnet.id]
  subnets                    = var.subnet_ids
  enable_deletion_protection = var.delete_ptotection

  #   access_logs {
  #     bucket  = aws_s3_bucket.lb_logs.id
  #     prefix  = "test-lb"
  #     enabled = true
  #   }

  tags = merge(
    var.tags_all,
    {
      Name = var.names["app-tg"]
    }
  )
}

#load balancer traffic listener
resource "aws_lb_listener" "project_lb_listener" {
  load_balancer_arn = aws_lb.project_lb.arn
  port              = var.ports["app"]
  protocol          = var.protocols[0]

  default_action {
    type             = var.lb_default_action
    target_group_arn = aws_lb_target_group.project_target_group.arn
  }
  tags = var.tags_all
}

#target group for load balancer
resource "aws_lb_target_group" "project_target_group" {
  name     = var.names["app-tg"]
  port     = var.ports["app-tg"]
  protocol = var.protocols[0]
  vpc_id   = var.vpc_id

  tags = merge(
    var.tags_all,
    {
      Name = var.names["app-tg"]
    }
  )
}

#associate the instance with the target group
resource "aws_lb_target_group_attachment" "project_tg_attachment" {
  target_group_arn = aws_lb_target_group.project_target_group.arn
  target_id        = var.instance_id
  port             = var.ports["app"]
}

#security group for load balancer
#necessary in order to set the id for the ingress app traffic in the instance sg
resource "aws_security_group" "project_lb_sg" {
  ingress {
    from_port   = var.ports["app"]
    to_port     = var.ports["app"]
    protocol    = var.protocols[0]
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
    from_port   = var.ports["custom_ssh"]
    to_port     = var.ports["custom_ssh"]
    protocol    = var.protocols[2]
    cidr_blocks = var.default_route
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