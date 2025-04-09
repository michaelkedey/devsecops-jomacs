variable "tags_all" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  sensitive   = true
  default = {
    "Environment" = "devsecops-jomacs-project",
    "Owner"       = "Michael Kedey"
  }
}

variable "instance_id" {
  type = string
}

variable "vpc_id" {
  type = string
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

variable "protocols" {
  default     = ["HTTP", -1, "tcp"]
  description = "allow traffic in"
  type        = list(any)
  sensitive   = true
}

variable "tg_name" {

}

variable "ln_rule_name" {

}

variable "listener_arn" {

}

variable "listener_rule_action" {
  default = "forward"
  type    = string
}

variable "listener_rule_priority" {

}

variable "listener_rule_path" {

}