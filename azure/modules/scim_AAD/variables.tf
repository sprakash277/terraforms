variable "groups" {
  default     = {
    "aweaver" = {
      workspace_access = true
      allow_sql_analytics_access = false
    },
    "Cosmin Lita MS Teams Invites" = {
      workspace_access = false
      allow_sql_analytics_access = true
    }
  }
}
