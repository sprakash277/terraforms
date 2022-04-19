terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "~>0.4.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.68.0"
    }
  }
}

provider "aws" {
  region  = var.region
  profile = var.aws_profile
}

// initialize provider in "MWS" mode, to add users at account-level
provider "databricks" {
  alias      = "mws"
  host       = "https://accounts.cloud.databricks.com"
  account_id = var.databricks_account_id
  username   = var.databricks_account_username
  password   = var.databricks_account_password
}
