variable "iam_user" {
  type        = string
  default     = "gina"
  description = "iam user name"
}

variable "public_ip" {
  type    = bool
  default = true

}

variable "key_name" {
  type    = string
  default = "ginakey"
}