variable "databricks_account_username" {}
variable "databricks_account_password" {}
variable "databricks_account_id" {}

variable "cross_account_role_arn" {}


variable "aws_profile_for_Credentials" {}

variable "tags" {
  default = {
    Owner = "sumit.prakash@databricks.com"
  }
}

variable "cidr_block" {
  default = "10.4.0.0/16"
}

variable "region" {
}

variable "prefix" {
  default = "cs-sumit1"
}