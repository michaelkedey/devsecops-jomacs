variable "tags_all" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  sensitive   = true
  default = {
    "Environment" = "devsecops-jomacs",
    "Owner"       = "michael_kedey"
  }
}

variable "ebs_size" {
  default = 10
  type = number
}

variable "ebs_name" {
  default = "jp-ebs"
}

variable "instance_id" {
  
}