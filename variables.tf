variable "public" {
  default = "false"
}

variable "gateway_id" {
  default = ""
}

variable "vpc_id" {}
variable "cidr_block" {}
variable "availability_zone" {}

variable "tags" {
  default {
    Project = ""
    Env     = ""
  }
}
