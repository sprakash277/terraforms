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
}


 provider "azuread" {
   tenant_id = var.tenant_id
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
