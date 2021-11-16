# terraforms

This example uses Azure CLI for Azure Authentication. 

1. az login 
        i. Alternatively , we can Authenticate using the Service Prinipal as mentioned here - https://github.com/databrickslabs/terraform-provider-databricks/blob/master/docs/index.md#authenticating-with-azure-service-principal
     
        ii. Or Using Azure MSI , as mentioned here  - https://github.com/databrickslabs/terraform-provider-databricks/blob/master/docs/index.md#authenticating-with-azure-msi
     
2. az account set --subscription "REPLACE ME"
    use the correct Azure Subscription id
4. Set the terraform path in the $PATH
5. run " terraform init " from the parent folder. init deploys the required libraries and dependencies
6. run " terraform validate " 
7. run " terraform apply "
8. To destroy the previous work created by terraform , run " terraform destroy "
