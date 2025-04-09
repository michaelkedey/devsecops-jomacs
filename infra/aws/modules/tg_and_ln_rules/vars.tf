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

variable "tg_port" {

}

variable "protocols" {
  default     = ["HTTP", -1, "tcp"]
  description = "allow traffic in"
  type        = list(any)
  sensitive   = true
}

variable "lb_target_type" {
  default = "instance"
  type    = string
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