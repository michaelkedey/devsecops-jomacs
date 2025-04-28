resource "aws_kms_key" "elk_secrets_key" {
  description             = "KMS key for ELK secrets encryption"
  deletion_window_in_days = var.deletion_window
  enable_key_rotation     = true
}

resource "aws_secretsmanager_secret" "jp_elastic_password" {
  name       = var.secrets_name
  kms_key_id = aws_kms_key.elk_secrets_key.arn
  lifecycle {
    prevent_destroy = true
    ignore_changes  = [tags]
  }
}

resource "aws_secretsmanager_secret_version" "jp_elastic_password_value" {
  secret_id     = aws_secretsmanager_secret.jp_elastic_password.id
  secret_string = var.tmp_elastic_password

  lifecycle {
    ignore_changes = [secret_string]
  }
}

