# terraforms

This example uses Azure CLI for Azure Authentication. 



export $GITHUB_TOKEN="CHANGE ME"

export $AZURE_TENANT_ID="CHANGE ME"

export $AZURE_SUBSCRIPTION_ID="CHANGE ME"

export TF_VAR_tenant_id=$AZURE_TENANT_ID

export TF_VAR_subscription_id=$AZURE_SUBSCRIPTION_ID

export TF_VAR_github_token=$GITHUB_TOKEN

* Install Azure CLI -> https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-macos
* Install terraform -> https://learn.hashicorp.com/tutorials/terraform/install-cli


* 1. az login 

        * i. Alternatively , we can Authenticate using the Service Prinipal as mentioned here - https://github.com/ databrickslabs/terraform-provider-databricks/blob/master/docs/index.md#authenticating-with-azure-service-principal
     
        * ii. Or Using Azure MSI , as mentioned here  - https://github.com/databrickslabs/terraform-provider-databricks/blob/master/docs/index.md#authenticating-with-azure-msi
     
* 2. az account set --subscription "REPLACE ME"
    use the correct Azure Subscription id
* 3. Set the terraform path in the $PATH
* 4. run " terraform init " from the parent folder. init deploys the required libraries and dependencies
* 5. run " terraform validate " 
* 6. run " terraform apply "
* 7. To destroy the previous work created by terraform , run " terraform destroy "


# Azure AD Provider

Tenants and Subscriptions
==========================
The AzureAD provider operates on tenants and not on subscriptions. We recommend always specifying az login --allow-no-subscriptions as it will force the Azure CLI to report tenants with no associated subscriptions, or where your user account does not have any roles assigned for a subscription.

provider "azuread" {
  tenant_id = "00000000-0000-1111-1111-111111111111"
}