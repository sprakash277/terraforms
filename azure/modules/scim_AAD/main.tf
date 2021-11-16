terraform {
  required_providers {
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

provider "azuread" {
}

provider "databricks" {
  #host = "https://adb-6470595692372502.2.azuredatabricks.net/?o=6470595692372502"
  #token = "dapi2a8ab40ffe495f00846509ad02796636-3"
  host = var.host
  token = var.token
}


// read group members of given groups from AzureAD every time Terraform is started
data "azuread_group" "this" {
  for_each = local.all_groups
  display_name = each.value
}

locals {
  all_groups = toset(keys(var.groups))
  admin_groups = toset([for k,v in var.groups: k if v.admin])
}

// create or remove groups within databricks - all governed by "groups" variable
resource "databricks_group" "this" {
  for_each = data.azuread_group.this
  display_name = each.key
  workspace_access = var.groups[each.key].workspace_access
  allow_sql_analytics_access = var.groups[each.key].allow_sql_analytics_access
  allow_cluster_create = var.groups[each.key].allow_cluster_create
  allow_instance_pool_create = var.groups[each.key].allow_instance_pool_create
}

// read users from AzureAD every time Terraform is started
data "azuread_user" "this" {
  for_each = toset(flatten([for g in data.azuread_group.this: g.members]))
  object_id = each.value
}

// all governed by AzureAD, create or remove users from databricks workspace
resource "databricks_user" "this" {
  for_each = data.azuread_user.this
  user_name = each.value.user_principal_name
  display_name = each.value.display_name
  active = each.value.account_enabled
}

// put users to respective groups
resource "databricks_group_member" "this" {
  for_each = toset(flatten(
    [for group_name in local.all_groups:
      [for member_id in data.azuread_group.this[group_name].members:
        jsonencode({
          user: member_id,
          group: group_name
        })]]))
  group_id = databricks_group.this[jsondecode(each.value).group].id
  member_id = databricks_user.this[jsondecode(each.value).user].id
}

// Provisioning of admins




