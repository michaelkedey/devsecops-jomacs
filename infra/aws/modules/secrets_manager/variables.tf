variable "secrets_name" {
  type    = string
  default = "elasticsearch_password"
}

variable "tmp_elastic_password" {
  type    = string
  default = "tmp_elastic_password"
}
variable "deletion_window" {
  default = 7
  type    = number
}