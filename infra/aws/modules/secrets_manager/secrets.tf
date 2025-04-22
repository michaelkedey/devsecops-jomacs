resource "aws_secretsmanager_secret" "jp_elastic_password" {
  name = var.secrets_name
}

resource "aws_secretsmanager_secret_version" "elastic_password_value" {
  secret_id     = aws_secretsmanager_secret.jp_elastic_password.id
  secret_string = var.tmp_elastic_password
}
