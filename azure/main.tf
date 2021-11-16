terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 2.26"
    }

  }
}

provider "azurerm" {
  features {}
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
}
