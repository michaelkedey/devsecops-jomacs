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

variable "names" {
  default = {
    app-tg-name     = "jp_app_tg"
    elk-tg-name     = "elk_app_tg"
    app-ln-rule     = "jp_app-ln-rule"
    elk-ln-rule     = "jp-elk-ln-rule"
    elk_instance    = "jp_elk_server"
    app_instance    = "jp_app_server"
    jumper_instance = "jp_jumper_server"
  }
}