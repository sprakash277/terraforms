terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }
    databricks = {
      source = "databrickslabs/databricks"
      version = "0.3.11"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.8.0"
    }

  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  #subscription_id = "3f2e4d32-8e8d-46d6-82bc-5bb8d962328b"
}


 provider "azuread" {
   tenant_id = var.tenant_id
  #tenant_id = "9f37a392-f0ae-4280-9796-f1864a10effc"
}
provider "databricks" {

  host  = module.create_db_workspace.databricks_host
  token = module.create_pat_token.databricks_token
}  


module "create_db_workspace" {
  source = "./modules/create_db_workspace"
}


module "create_pat_token" {
  source = "./modules/create_pat_token"
  host = module.create_db_workspace.databricks_host

}


module "scim_AAD" {
  source = "./modules/scim_AAD"
  host = module.create_db_workspace.databricks_host
  token = module.create_pat_token.databricks_token
  providers = {

    databricks = databricks
    azuread = azuread
  }
  
}
