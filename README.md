# terraforms

This example uses Azure CLI for Azure Authentication. 

1. az logon
2. az account set --subscription "REPLACE ME"
    use the correct Azure Subscription id
4. Set the terraform path in the $PATH
5. run " terraform init " from the parent folder. init deploys the required libraries and dependencies
6. run " terraform validate " 
7. run " terraform apply "
8. To destroy the previous work created by terraform , run " terraform destroy "
