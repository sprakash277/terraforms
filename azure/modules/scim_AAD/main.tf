data "azuread_group" "this" {
  for_each = toset(keys(var.groups))
  display_name = each.value
}

resource "databricks_group" "this" {
  for_each = data.azuread_group.this
  display_name = each.key
  workspace_access = var.groups[each.key].workspace_access
  allow_sql_analytics_access = var.groups[each.key].allow_sql_analytics_access
}

data "azuread_user" "this" {
  for_each = toset(flatten([for g in data.azuread_group.this: g.members]))
  object_id = each.value
}

resource "databricks_user" "this" {
  for_each = data.azuread_user.this
  user_name = each.value.user_principal_name
  display_name = each.value.display_name
  active = each.value.account_enabled
}

resource "databricks_group_member" "this" {
for_each = toset(flatten(
    [for group_name in keys(var.groups): 
      [for member_id in data.azuread_group.this[group_name].members: 
        jsonencode({ // and we can go deeper...
          user: member_id,
          group: group_name
        })]]))
  group_id = databricks_group.this[jsondecode(each.value).group].id
  member_id = databricks_user.this[jsondecode(each.value).user].id
}
