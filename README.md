# Terraform-Project-Team1

In your AWS account: 
### 1. create S3 bucket with name of "tfstate-<Account_ID>" in region "us-east-1"

### 2. create DynamoDB table name of "tfstate-team1" with LockID key

### 3. Under main>VPC>backend.tf and change "tfstate-*******" to "tfstate-<Account_ID>"
### 4. Under main>VPC>.gitignore file remove [#] next to .backend.tf file
## 5. To run:

```
make build
```
## 6. To destroy:
```
make destroy
```