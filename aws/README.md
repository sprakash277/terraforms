Step1. Get the AWS credentails
    For Databricks AWS, use gimme-aws-creds commannd
          i. brew install gimme-aws-creds
         ii. curl "https://gimmecreds.sec.databricks.com/?username=xxxxx" --silent --output ~/.okta_aws_login_config 
        iii. Run "gimme-aws-creds" that creates temporary Credentials file in "~/.aws/credentials "
        
Step2. Use the Credentials profile of AWS in Terraform       
