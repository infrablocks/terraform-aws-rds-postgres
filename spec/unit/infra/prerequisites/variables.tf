variable "region" {}
variable "availability_zones" {
  type = list(string)
}
variable "vpc_cidr" {}

variable "component" {}
variable "deployment_identifier" {}

variable "private_zone_id" {}
