variable "region" {}
variable "vpc_cidr" {}
variable "availability_zones" {}
variable "private_network_cidr" {}

variable "component" {}
variable "deployment_identifier" {}

variable "bastion_ami" {}
variable "bastion_ssh_public_key_path" {}
variable "bastion_ssh_allow_cidrs" {}

variable "domain_name" {}
variable "public_zone_id" {}
variable "private_zone_id" {}

variable "database_instance_class" {}

variable "database_name" {}
variable "database_master_user" {}
variable "database_master_user_password" {}

variable "infrastructure_events_bucket" {}
variable "snapshot_identifier" {}
