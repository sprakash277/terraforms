
hubcidr          = "10.3.0.0/23"
spokecidr        = "10.4.0.0/23"
no_public_ip     = true
rglocation       = "westeurope"
metastoreip      = "104.40.169.187"
sccip-1          = "23.97.201.41/32"         // get scc ip from nslookup 
sccip-2          = "51.138.96.158/32"       // Keep scc value as same if only one ip is available for this region
webappip-1       = "52.232.19.246/32"      // Keep webapp value as same if only one ip is available for this region
webappip-2       = "40.74.30.80/32"
dbfs_prefix      = "dbfs"
workspace_prefix = "sumit-europe-hub-spoke"

firewallfqdn = [                                                          // dbfs rule will be added - depends on dbfs storage name
  "dbartifactsprodwesteu.blob.core.windows.net",                         //databricks artifacts
  "dbartifactsprodnortheu.blob.core.windows.net",                       //databricks artifacts secondary
  "dblogprodwesteurope.blob.core.windows.net",                         //log blob
  "prod-westeurope-observabilityeventhubs.servicebus.windows.net",    //eventhub
  "cdnjs.com"                                                        //ganglia
]

//Unity Catalog Specific Configs
databricks_metastore = "52ce4231-6938-44be-b6c7-a88b7e82b7f8"
catalog_name     = "tf_generated"
schema_name      = "demo"
