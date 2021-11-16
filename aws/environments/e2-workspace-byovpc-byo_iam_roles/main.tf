terraform {
  required_providers {
    databricks = {
      source  = "databrickslabs/databricks"
      version = "0.3.0"
    }
  }
}

/*
export TF_VAR_databricks_account_id=$DATABRICKS_ACCOUNT_ID
export TF_VAR_databricks_account_password=$DATABRICKS_PASSWORD
export TF_VAR_databricks_account_username=$DATABRICKS_USERNAME
export TF_VAR_cross_account_role_arn=$CROSS_ACCOUNT_ROLE_ARN
export TF_VAR_aws_profile_for_Credentials=$AWS_PROFILE_FOR_CREDENTIALS
export TF_VAR_aws_region=$AWS_REGION
*/




module "this" {
  source                      = "../../modules/aws-e2workspace"
  databricks_account_id       = var.databricks_account_id
  databricks_account_password = var.databricks_account_password
  databricks_account_username = var.databricks_account_username
  cross_account_role_arn      = var.cross_account_role_arn
  aws_profile_for_Credentials = var.aws_profile_for_Credentials
  region                      = var.aws_region
  

  //region = "us-east-1"

  tags = {
    Owner = "sumit.prakash@databricks.com"
  }
}

