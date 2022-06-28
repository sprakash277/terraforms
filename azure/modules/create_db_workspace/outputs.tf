output "databricks_host" {
  value = "https://${azurerm_databricks_workspace.this.workspace_url}/"
}

output "workspace_id" {
  value = "${azurerm_databricks_workspace.this.workspace_id}"
}
