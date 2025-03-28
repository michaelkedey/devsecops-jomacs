variable "instance_type" {
  type = map(string)
  default = {
    project    = "t2.micro",
    production = "m5.large"
  }
  description = "instance type for bastion server"
}

variable "subnet_id" {
  description = "subnet id to launch instance in"
  type        = string
}

variable "security_groups" {
  type        = set(string)
  description = "security group to deploy server in"
}

variable "names" {
  default = {
    instance_name = "jp_bastion"
  }
  type = map(string)
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

variable "public_ip" {
  type = bool

}

variable "key_name" {
  type = string
}