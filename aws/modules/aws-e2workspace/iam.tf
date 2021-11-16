// Uncomment below in Customer env, User in DB env doesn't have permission to create IAM hence we will just use the IAM


/*

data "databricks_aws_assume_role_policy" "this" {
  external_id = var.databricks_account_id
}

data "databricks_aws_crossaccount_policy" "this" {
}

resource "aws_iam_role" "cross_account_role" {
  name               = "sumit-iam-role-DB-ManagedVPC"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "this" {
  name   = "${local.prefix}-policy"
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.this.json
}
*/

resource "databricks_mws_credentials" "this" {
  provider         = databricks.mws
  account_id       = var.databricks_account_id
  // Uncomment below in Customer env, User in DB env doesn't have permission to create IAM hence we will just use the IAM
  //role_arn         = aws_iam_role.cross_account_role.arn
  //depends_on       = [aws_iam_role_policy.this]
  role_arn           = var.cross_account_role_arn
  credentials_name = "${local.prefix}-creds"
  
}