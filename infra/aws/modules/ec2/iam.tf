resource "aws_iam_role" "ec2_ssm_role" {
  name               = "EC2SSMRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_ssm_role_attachment" {
  role       = aws_iam_role.ec2_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ec2_ssm_instance_profile" {
  name = "EC2SSMInstanceProfile"
  role = aws_iam_role.ec2_ssm_role.name
}

resource "aws_iam_user_policy_attachment" "existing_user_ssm_policy" {
  user       = var.iam_user 
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_user_policy_attachment" "existing_user_logs_policy" {
  user       = var.iam_user 
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

