## Storing Terraform State File in S3 for Secure Management

**Prerequisites**:

- AWS CLI installed and configured.

- Terraform installed.

- AWS IAM user with necessary permissions to access S3.

**Working with docker with terraform project**

**link** 

🔗  https://github.com/Shashank-1202/Terraform-with-docker

 ![alt text](image-1.png) 
  
project file consists with main.tf, provider.tf, resource.tf, terraform.tfstate and terraform.tfstate.backup.

**Steps to store the .tfstate file into s3 bucket**

Configure aws with s3 bucket
```sh
aws configure
```
provide the required details:
```sh
AWS Access Key ID [None]: ******
AWS Secret Access Key [None]: *******
Default region name [None]: us-east-1
Default output format [None]: 
```
create a s3 bucket with unique name in the current region
```sh
aws s3 mb s3://myterrafor-statefile-bucket --region us-east-1
```
After the creation of bucket, terminal will show

*make_bucket: myterrafor-statefile-bucket*

**configure terraform backend**

Add S3 bucket code in the terraform provider block (provider.tf)
```sh
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
   backend "s3" {
    bucket         = "myterrafor-statefile-bucket"  # Change this to your actual S3 bucket name
    key            = "terraform.tfstate"  # Path inside S3
    region         = "us-east-1"
    encrypt        = true
  }
}
```
**Run the following command to initialize Terraform and migrate the local state file to S3:**
```sh
terraform init
```
you will get the following prompt in the terminal

*Do you want to copy existing state to the new backend?*
  *Pre-existing state was found while migrating the previous "local" backend to the*
  *newly configured "s3" backend. No existing state was found in the newly*
  *configured "s3" backend. Do you want to copy this state to the new "s3"*
  *backend? Enter "yes" to copy and "no" to start with an empty state.*

  *Enter a value*:

  **enter a value: yes to proceed with the migration.**

  #### Verify State File in S3

  Check if the Terraform state file is stored in the S3 bucket:
  
  ```sh
  aws s3 ls s3://myterraform-statefile-bucket
  ```

  #### check the file in the s3 bucket (through GUI)
  
  ![alt text](image.png)


  After creating a s3 bucket, we can enable the bucket versioning through aws cli (**if you required**)

  *Once the bucket is created, enable versioning*:
 ```sh
 aws s3api put-bucket-versioning --bucket myterraform-statefile-bucket --versioning-configuration Status=Enabled
 ```
 *To confirm that versioning is enabled, run*:
 ```sh
 aws s3api get-bucket-versioning --bucket myterraform-statefile-bucket
 ```
 #### Delete S3 Bucket


**Remove all objects from the bucket**:
```sh
aws s3 rm s3://myterraform-statefile-bucket --recursive
```
**Delete the bucket**:
```sh
aws s3 rb s3://myterraform-statefile-bucket
```
