variable "instance_type" {
  type = map(string)
  default = {
    project    = "t2.micro",
    production = "m5.large"
  }
  description = "instance type for project server"
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
    instance_name = "jp_server"
  }
  type = map(string)
}

variable "key_name" {
  default = "ginakey"
  type    = string
}

variable "tags_all" {
  type        = map(string)
  description = "A map of tags to assign to the resource."
  sensitive   = true
  default = {
    "Environment" = "devsecops-jomacs",
    "Owner"       = "Michael Kedey"
  }
}

#VPC
#vpc variables
variable "cidrs" {

  default = {
    vpc            = "177.70.0.0/24",
    public_subnet  = "177.70.0.0/26",
    private_subnet = "177.70.0.64/26",
    default_route  = "0.0.0.0/0"
  }

  sensitive   = true
  type        = map(string)
  description = "cidr blocks for vpc components"
}


variable "default_route" {
  default   = ["0.0.0.0/0"]
  type      = list(string)
  sensitive = true
}

variable "names" {

  default = {
    vpc                 = "jp_vpc",
    public_subnet       = "jp_vpc_bublic_sn",
    private_subnet      = "jp_vpc_private_sn",
    internet_gateway    = "jp_internet_gw",
    public_route_table  = "jp_public_rt",
    private_route_table = "jp_private_rt"
    internet_gateway    = "jp_igw",
    nat_gateway         = "jp-nat_gw"
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

variable "azs" {
  default   = ["us-east-1a", "us-east-1b"]
  type      = list(string)
  sensitive = true
}

variable "eip_domain" {
  default   = "vpc"
  type      = string
  sensitive = true
}

variable "ports" {
  default = {
    all = 0
  }
  sensitive = true
  type      = map(number)
}

variable "protocols" {
  default     = ["HTTP", -1, "tcp"]
  description = "allow only tcp traffic in"
  type        = list(any)
  sensitive   = true
}

variable "instance_id" {

}