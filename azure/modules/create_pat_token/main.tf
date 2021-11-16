// initialize provider in normal mode
terraform {
  required_providers {
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.3.11"
    }
  }
}

provider "databricks" {
  alias = "created_workspace"

  host  = var.host
}

// create PAT token to provision entities within workspace
resource "databricks_token" "pat" {
  provider = databricks.created_workspace
  comment  = "Terraform Provisioning"
  // 100 day token
  lifetime_seconds = 8640000
}


