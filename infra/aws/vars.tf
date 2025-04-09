variable "iam_user" {
  type        = string
  default     = "gina"
  description = "iam user name"
}

variable "public_ip" {
  type = map(bool)
  default = {
    yes = true
    no  = false
  }

}

variable "key_name" {
  type    = string
  default = "ginakey"
}