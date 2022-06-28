resource "databricks_metastore_assignment" "this" {
  
  provider = databricks.created_workspace
  workspace_id         = azurerm_databricks_workspace.this.workspace_id
  metastore_id         = var.databricks_metastore
  default_catalog_name = "hive_metastore"
}

resource "databricks_catalog" "catalog" {

  provider = databricks.created_workspace
  metastore_id = var.databricks_metastore
  name         = local.catalog
  comment      = "This catalog is managed by terraform"
  properties = {
    purpose = "Demo"
  }
  depends_on = [databricks_metastore_assignment.this]
}

resource "databricks_schema" "things" {

  provider = databricks.created_workspace
  catalog_name = databricks_catalog.catalog.id
  name         = var.schema_name

  comment = "This database is managed by terraform"
  properties = {
    kind = "various"
  }
}