variable "instance_type" {
}

variable "subnet_id" {
  description = "subnet id to launch instance in"
  type        = string
}

variable "security_groups" {
  type        = set(string)
  description = "security group to deploy server in"
}

variable "instance_name" {

}

variable "tags_all" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  sensitive   = true
  default = {
    "Environment" = "devsecops-jomacs",
    "Owner"       = "michael_kedey"
  }
}

variable "key_name" {
  type = string
}

variable "public_ip" {}