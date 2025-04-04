variable "default_route" {
  default   = ["0.0.0.0/0"]
  type      = list(string)
  sensitive = true
}

variable "names" {

  default = {
    instance_sg = "jp_isg",
    jumper_sg   = "jp_jumper_sg",
    lb_sg       = "jp_lb_sg",
    app-tg      = "jp-app-tg",
    lb          = "jp-lb"
  }

  sensitive   = true
  type        = map(string)
  description = "tags for vpc resources"
}

variable "tags_all" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  sensitive   = true
  default = {
    "Environment" = "devsecops-jomacs-project",
    "Owner"       = "Michael Kedey"
  }
}

variable "ports" {
  default = {
    all        = 0
    app        = 80
    custom_ssh = 8008
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

variable "lb_default_action" {
  default = "forward"
  type    = string
}

variable "vpc_id" {
  type = string
}

variable "instance_id" {
  type = string
}

variable "delete_ptotection" {
  default = false
  type    = bool
}

variable "lb_internal" {
  default = false
  type    = bool
}

variable "lb_type" {
  default = "application"
  type    = string
}

variable "subnet_ids" {

}