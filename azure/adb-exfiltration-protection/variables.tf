variable "hubcidr" {
  type    = string
  default = "10.178.0.0/20"
}

variable "spokecidr" {
  type    = string
  default = "10.179.0.0/20"
}

variable "no_public_ip" {
  type    = bool
  default = true
}

variable "rglocation" {
  type    = string
  default = "southeastasia"
}

variable "metastoreip" {
  type = string
}

variable "sccip-1" {
  type = string
}

variable "sccip-2" {
  type = string
}

variable "webappip-1" {
  type = string
}

variable "webappip-2" {
  type = string
}

variable "dbfs_prefix" {
  type    = string
  default = "dbfs"
}

variable "workspace_prefix" {
  type    = string
  default = "adb"
}

variable "firewallfqdn" {
  type = list(any)
}

variable "databricks_metastore" {
  type    = string
}

variable "catalog_name" {
  type    = string
}

variable "schema_name" {
  type    = string
}

