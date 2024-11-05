variable "vpc_cidr_block" {}
variable "cidr_private_subnet" {}
variable "cidr_public_subnet" {}
variable "region" {
  type        = string
  description = "AWS region"
}

