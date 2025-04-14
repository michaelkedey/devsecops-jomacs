variable "instance_type" {
  type = map(string)
  default = {
    project    = "t2.micro",
    production = "t3.large"
  }
  description = "instance type for project server"
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
    app-tg-name     = "jp-app-tg"
    elk-tg-name     = "jp-elk-tg"
    app-ln-rule     = "jp_app-ln-rule"
    elk-ln-rule     = "jp-elk-ln-rule"
    elk_instance    = "jp_elk_server"
    app_instance    = "jp_app_server"
    jumper_instance = "jp_jumper_server"
  }
}

variable "listener_rule_priority" {
  type = map(number)
  default = {
    "first"  = 10
    "second" = 20
  }
}

variable "app_listener_rule_path" {
  default = "/app/*"

}

variable "app_static_listener_rule_path" {
  default = "/app/static"

}

variable "elk_listener_rule_path" {
  default = "/elk"

}

variable "ports" {
  default = {
    all        = 0
    app        = 80
    custom_ssh = 8008
    elk        = 5601
  }
  sensitive = true
  type      = map(number)
}