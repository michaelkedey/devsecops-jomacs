#vpc variables
variable "cidrs" {

  default = {
    vpc            = "177.70.0.0/24",
    public_subnet  = "177.70.0.0/26",
    public_subnet1 = "177.70.0.128/26",
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
    public_subnet1      = "jp_vpc_bublic_sn1",
    private_subnet      = "jp_vpc_private_sn",
    internet_gateway    = "jp_internet_gw",
    public_route_table  = "jp_public_rt",
    private_route_table = "jp_private_rt"
    internet_gateway    = "jp_igw",
    nat_gateway         = "jp-nat_gw",
    instance_sg         = "jp_isg",
    lb_sg               = "jp_lb_sg",
    app-tg              = "jp-app-tg"
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

variable "lb_sg" {

}