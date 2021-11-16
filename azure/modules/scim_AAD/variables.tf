variable "groups" {
description = "Map of AAD group names into object describing workspace & Databricks SQL access permissions"
  type = map(object({
    workspace_access = bool
    allow_sql_analytics_access = bool
    allow_cluster_create = bool
    allow_instance_pool_create = bool
    admin = bool  # if this group for Databricks admins
  }))
  default    = {
    "Cosmin Lita MS Teams Invites" = {
    workspace_access = true
    allow_sql_analytics_access = true
    allow_cluster_create = true
    allow_instance_pool_create = true
    admin = false  # if this group for Databricks admins
    }
  }
}

variable "host" {
  type = string
  default = "Change Me"
}

variable "token" {
  type = string
  default = "Change Me"
}
