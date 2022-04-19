/***************************************************************************************
* Create a Unity Catalog metastore (and the AWS bucket & IAM role if required)
****************************************************************************************/

//export TF_VAR_unity_metastore_bucket="CHANGE_ME"
//export TF_VAR_unity_metastore_iam="CHANGE_ME"
//export TF_VAR_databricks_workspace_ids="CHANGE_ME"
//export TF_VAR_unity_admin_groups="CHANGE_ME"
//export TF_VAR_databricks_account_id="CHANGE_ME"
//export TF_VAR_databricks_workspace_host="CHANGE_ME"
//export TF_VAR_databricks_account_username="CHANGE_ME"
//export TF_VAR_databricks_account_password="CHANGE_ME"


resource "databricks_metastore" "unity" {
  provider      = databricks.workspace
  name          = "unity-metastore-sumit1"
  storage_root  = "s3://${var.unity_metastore_bucket}"
  owner         = var.unity_admin_groups
  force_destroy = true
}

resource "databricks_metastore_data_access" "default_dac" {
  provider      = databricks.workspace
  metastore_id = databricks_metastore.unity.id
  name         = "default_dac"
  is_default   = true
  aws_iam_role {
    role_arn = var.unity_metastore_iam
  }
}

resource "databricks_metastore_assignment" "default_metastore" {
  provider      = databricks.workspace
  workspace_id         = var.databricks_workspace_ids
  metastore_id         = databricks_metastore.unity.id
  default_catalog_name = "hive_metastore"
}



