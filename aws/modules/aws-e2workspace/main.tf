/**
 * Databricks E2 workspace with BYOVPC
 *
 * ![preview](./arch.png)
 *
 * Creates AWS IAM cross-account role, AWS S3 root bucket, VPC with Internet gateway, NAT, routing, one public subnet,
 * two private subnets in two different regions. Then it ties all together and creates an E2 workspace.
 */


resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "fs-cf-sumit-${random_string.naming.result}"
}

provider "aws" {
  region = var.region
  profile = var.aws_profile_for_Credentials
}

// initialize provider in "MWS" mode to provision new workspace
provider "databricks" {
  alias    = "mws"
  host     = "https://accounts.cloud.databricks.com"
  username = var.databricks_account_username
  password = var.databricks_account_password
}

