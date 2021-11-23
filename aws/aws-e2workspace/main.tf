/**
 * Databricks E2 workspace with BYOVPC
 *
 * ![preview](./arch.png)
 *
 * Creates AWS IAM cross-account role, AWS S3 root bucket, VPC with Internet gateway, NAT, routing, one public subnet,
 * two private subnets in two different regions. Then it ties all together and creates an E2 workspace.
 */
/*

export DATABRICKS_ACCOUNT_ID="CHANGE ME"
export DATABRICKS_PASSWORD="CHANGE ME"
export DATABRICKS_USERNAME="CHANGE ME"
export CROSS_ACCOUNT_ROLE_ARN="CHANGE ME"
export AWS_PROFILE_FOR_CREDENTIALS="CHANGE ME"

export TF_VAR_databricks_account_id=$DATABRICKS_ACCOUNT_ID
export TF_VAR_databricks_account_password=$DATABRICKS_PASSWORD
export TF_VAR_databricks_account_username=$DATABRICKS_USERNAME
export TF_VAR_cross_account_role_arn=$CROSS_ACCOUNT_ROLE_ARN
export TF_VAR_aws_profile_for_Credentials=$AWS_PROFILE_FOR_CREDENTIALS
export TF_VAR_aws_region=$AWS_REGION
*/

terraform {
  required_providers {
    
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.3.11"
    }
  }
}



resource "random_string" "naming" {
  special = false
  upper   = false
  length  = 6
}

locals {
  prefix = "${var.prefix}-${random_string.naming.result}"
  databricks_account_username = var.databricks_account_username
  databricks_account_password  =  var.databricks_account_password
  databricks_account_id = var.databricks_account_id
  cross_account_role_arn =  var.cross_account_role_arn
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


module "vpc" {
  source = "../modules/VPC/create_vpc"
  databricks_account_id = local.databricks_account_id
  databricks_account_username = local.databricks_account_username
  databricks_account_password = local.databricks_account_password
  cross_account_role_arn = local.cross_account_role_arn
  prefix = "${var.prefix}-${random_string.naming.result}"

  providers = {
    aws = aws
  }
  
}

module "iam" {
  source = "../modules/IAM/use_iam"
  databricks_account_username = local.databricks_account_username
  databricks_account_password = local.databricks_account_password
  cross_account_role_arn = local.cross_account_role_arn
  databricks_account_id  = local.databricks_account_id
  tags = var.tags
  prefix = "${var.prefix}-${random_string.naming.result}"

   providers = {
    aws = aws
  }
  
}

module "root_bucket" {
  source = "../modules/create_root_bucket/"
  databricks_account_username = local.databricks_account_username
  databricks_account_password = local.databricks_account_password
  databricks_account_id  = local.databricks_account_id
  tags = var.tags
  prefix = "${var.prefix}-${random_string.naming.result}"

   providers = {
    aws = aws
  }
  
}


resource "databricks_mws_workspaces" "this" {
  provider        = databricks.mws
  account_id      = var.databricks_account_id
  aws_region      = var.region
  workspace_name  = local.prefix
  deployment_name = local.prefix

  credentials_id           = module.iam.credentials_id
  storage_configuration_id = module.root_bucket.credentistorage_configuration_idals_id
  network_id               = module.vpc.databricks_mws_networks_id
}





