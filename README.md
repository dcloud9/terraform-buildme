## Read Me

* Infrastructure and Code should be both scalable. __terraform-buildme__ provides a framework to build a multi-region cloud-agnostic infrastructure using the same code base and at the same time expand or scale by reusing the blocks of code.

* Setting API/access keys are not covered here as they can vary from one cloud provider to another. Ensure proper creds and keys are configured where you run terraform.

* Update vpc-<vpcname>/tfvars -> public_key with the contents of public key (eg. ssh-rsa AAA...).

* __Usage:__ `./buildme london|ireland|virginia|frankfurt prod01|stage66|dev80 plan|apply|destroy|taint|show|refresh|... [-var-file=tfvars/<tfvarsfile.tfvars>] [-target=<resource]`

```
$ ./buildme london dev01 plan -var-file=tfvars/london-dev01-demo1.tfvars -target=aws_instance.instance
```

* Remote state files are recommended to be stored in S3 buckets in the same or different (recommended) AWS account, and versioning enabled for quick recovery of state files.
For reference, create S3 buckets in the following recommended format and attach a bucket policy:

Using AWS console:
`Login in AWS console -> S3 -> Create bucket -> input Bucket name -> input Region -> repeat for mult-region deploy`

Using AWS CLI:
`$ aws s3 mb s3://buildme-<awsaccountID>-<env#>-tfstate-<region> --region us-west-2`

```
bucketname for tfstate files: buildme-<awsaccountID>-<env#>-tfstate-<region>; where region = eu-west-1 for Ireland; eu-west-2 for London; us-east-1 for Virginia; eg. awsaccountID = 123456789012
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::<awsaccountID>:root"
            },
            "Action": "s3:ListBucket",
            "Resource": "arn:aws:s3:::buildme-<awsaccountID>-<env#>-tfstate-<region>"
        },
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::<awsaccountID>:root"
            },
            "Action": [
                "s3:DeleteObject",
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::buildme-<awsaccountID>-<env#>-tfstate-<region>/*"
        }
    ]
}
```
* Alternatively, create your own custom globally unique S3 bucket name for tfstate files.

* Regardless of using recommended or custom S3 bucket name for tfstate files, update tf_env_vars.sh -> S3TFSTATE with S3 bucket name.  Add REGION regardless of single or multi-region stack.

* Git clone the Github repo. Once cloned successfully and before creating a new branch, ensure a `git pull` of master to sync with latest merges with the master branch.

`$ git clone git@github.com:dcloud9/terraform-buildme.git`

```
└── aws
    ├── common
    │   ├── cloudtrail
    │   │   └── tfvars
    │   └── scripts
    │       ├── lambda-backup
    │       │   └── lambda
    │       └── lambda-stopstart
    │           └── lambda
    └── vpc
        ├── global
        └── vpc-tooling
            ├── group
            │   ├── app-devtest
            │   │   ├── role
            │   │   │   └── algo
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   ├── app-prod
            │   │   ├── role
            │   │   │   └── algo
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   ├── app-stage
            │   │   ├── role
            │   │   │   └── algo
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   ├── corp
            │   │   ├── role
            │   │   │   ├── ad
            │   │   │   │   ├── tfvars
            │   │   │   │   └── userdata_files
            │   │   │   └── desktops
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   ├── db-devtest
            │   │   ├── role
            │   │   │   └── mssql
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   ├── db-prod
            │   │   ├── role
            │   │   │   └── mssql
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   ├── db-stage
            │   │   ├── role
            │   │   │   └── mssql
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   └── dmz
            │       ├── role
            │       │   ├── ftp
            │       │   │   ├── tfvars
            │       │   │   └── userdata_files
            │       │   └── vpn
            │       │       ├── tfvars
            │       │       └── userdata_files
            │       └── tfvars
            ├── network
            │   └── tfvars
            └── tfvars
```

* Tree structure definition as follows:
    * `aws` - Terraform provider, eg. aws, azure, google, openstack
        * `common` - Scripts, settings, etc common/shared across all downstream VPCs. Tfstate files could exist at this level.
        * `vpc` - Placeholder for multiple `vpc-` names
            * `global` - Placeholder for common/shared env vars
            * `vpc-<vpc-name>` - Can be more than 1 VPC if different downstream groups or roles will be stood. Layer1 VPC SG stood here. Tfstate file exists.
                * `network` - Subnets, Routing tables, Routes, VPC Endpoints: S3. Tfstate file exists
                * `group` - Placeholder for multiple group names. Layer 2 Group SG stood here.
                    * `corp` - Group for corp roles/instances, eg. Active Directory, WorkSpaces/VDIs, CI/CD tools. Tfstate file exists.
                        * `role` - Placeholder for multiple roles.
                            * `ad` - Active Directory. Layer3 Role SG stood here. Tfstate file exists.
                            * `desktops` - Workstations/VDIs. Layer3 Role SG stood here. Tfstate file exists.    
                    * `dmz` - Group for public facing roles/instance, eg. Sophos, Fortigate, bastion, SFTP. Tfstate file exists.
                        * `role` - Placeholder for multiple roles.
                            * `ftp` - Secure FTP. Layer3 Role SG stood here. Tfstate file exists.
                            * `vpn` - Firewall/VPN. Layer3 Role SG stood here. Tfstate file exists.
                    * `moregroups` - Add more groups here as required
                        * `moreroles` - Add more roles here as required
            * `vpc-<vpc-foo>` - Add more VPCs here. Tfstate file exists.
                * `network` - Subnets, Routing tables, Routes, VPC Endpoints: S3. Tfstate file exists.
                * `group` - Placeholder for multiple group names. Layer 2 Group SG stood here.
                    * `corp` - Group for corp roles/instances, eg. Active Directory, WorkSpaces/VDIs, CI/CD tools. Tfstate file exists.
                        * `role` - Placeholder for multiple roles.
                            * `ad` - Active Directory. Layer3 Role SG stood here. Tfstate file exists.
                            * `desktops` - Workstations/VDIs. Layer3 Role SG stood here.   Tfstate file exists.                  
                    * `dmz` - Group for public facing roles/instance, eg. Sophos, Fortigate, bastion, SFTP. Tfstate file exists.
                        * `role` - Placeholder for multiple roles.
                            * `ftp` - Secure FTP. Layer3 Role SG stood here. Tfstate file exists.
                            * `vpn` - Firewall/VPN. Layer3 Role SG stood here. Tfstate file exists.
                    * `moregroups` - Add more groups here as required
                        * `moreroles` - Add more roles here as required

1. Install at least Terraform v0.9.5 or latest from https://www.terraform.io/downloads.html. Note the instructions below are valid for Linux Only. Tweaks might be needed in Mac or Windows OS.
2. Note of potential breaking changes in Terraform releases before applying changes in the infrastructure. Plan, plan, plan. Refer to *Changelogs* of relevant version (https://github.com/hashicorp/terraform/blob/vX.Y.Z/CHANGELOG.md)
Eg. https://github.com/hashicorp/terraform/blob/v0.9.8/CHANGELOG.md
3. `git clone git@bitbucket.org:hentsu/env-setup.git` - This would assign temporary AWS Access Keys using STS in order to run terraform properly.
4. `$ ./env-setup/customer-aws-auth-onelogin.py` - Input your Hentsu AD creds. Choose the target AWS *Admin* account.
5. `$ aws ec2 desribe-vpcs` - (Optional) Ensure the correct STS token works well with your targeted AWS account.
6. `$ cd XX-infra/aws/vpc/vpc-name` - To build a VPC. VPC SG created here at this level. Eg. sg-[env#]-[vpc-name]; sg-prd1-tooling; where env# = env number in case of cloning the env for example in troubleshooting, quarantine, forensics, or blue/green deployments
    * Create a min of 2048-bit key and update public_key value of keypair.tf with the contents of .pub file
        * `$ ssh-keygen -b 2048 -C kp-<env#>-<vpcname>  ./kp-<env#>-<vpcname>`
    * Rename the private key to a .pem file to diff with .pub, then secure it (ie. `$ chmod 400 kp-<env#>-<vpcname>.pem`) and save in the shared drive for decrypting Win Administrator password or SSH'ng to Linux instances.
7. `$ cd XX-infra/aws/vpc/vpc-name/network` - To build the VPC core network. 
8. `$ cd XX-infra/aws/vpc/vpc-name/group/<groupname>` - To build the Group SG. sg-[env#]-[vpc-name]; sg-dev1-trading-apps
9. `$ cd XX-infra/aws/vpc/vpc-name/group/<groupname>/role/<rolename>` - To build the role including Role SG. sg-[role]-[env#]-[vpc-name]; sg-dev1-trading-apps
10. `$ ./run.sh <region> <env#> plan -var-file=tfvars/<region>-<env#>-<rolename|vpcname>.tfvars` - Plan, plan, plan. Customise tfvars accordingly on region, env#, or role levels and keep the terraform scripts **immutable**
11. `$ ./run.sh <region> <env#> apply -var-file=tfvars/<region>-<env#>-<rolename|vpcname>.tfvars` - Plan, plan, plan, and more plan before you apply. 
12. `$ ./run.sh <region> <env#> destroy -var-file=tfvars/<region>-<env#>-<rolename|vpcname>.tfvars` - To destroy the 'stack'

#### CloudTrail and cross-account S3 access
Though it's a one-off manual set up of S3 bucket and policies to store the CloudTrail logs, it's key to provision the S3 bucket in "audit" account before running `apply`
1. Login to AWS console of "audit" account and create an S3 bucket choosing the correct region, eg. `s3-trail-XX-<region>`
2. In Permissions -> Bucket Policy section add the following policy, replace XX with Hentsu client code and region with relevant AWS region, eg. eu-west-1
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::s3-trail-XX-<region>"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
                "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::s3-trail-XX-<region>/*",
            "Condition": {
                "StringLike": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
```
3. In Management -> Life -> Add lifecycle rule as follows
```
Rule name: logs-rule
Prefix: logs/
Current version: Transition to Amazon Glacier after 365 days
Leave others default
```

#### Some helpful Terraform commands:
* `$ ./run.sh <region> <env#> taint aws_instance.instance` - Example of tainting EC2 resource for a quick rebuild with destroying the whole stack. Any resource within the stack can be tainted if needed. Run `plan` after tainting.
* `$ ./run.sh <region> <env#> plan|apply -var-file=tfvars/<region>-<env#>-<rolename|vpcname>.tfvars -target=aws_instance.instance -target=<another-targeted.resource>` - For targeting specific resources. Terraform will automatically pick up other resources as it works out dependencies.

#### Troubleshooting
* If you hit the error below on `plan` or `apply`, it means your STS token has expired, usually __1hr__ lifetime. Re-run `customer-aws-auth-onelogin.py` to renew the token and update the .aws/credentials file with valid AWS Access Keys.
```
Configuring S3 bucket for the remote state file...
Initializing the backend...

Error configuring the backend "s3": ExpiredToken: The security token included in the request is expired
    status code: 403, request id: 77a2231e-4d01-11e7-afd4-9d39c9f4d4da

Please update the configuration in your Terraform files to fix this error
then run this command again.

------------------------------------------------------------
Backend reinitialization required. Please run "terraform init".
Reason: Initial configuration of the requested backend "s3"

The "backend" is the interface that Terraform uses to store state,
perform operations, etc. If this message is showing up, it means that the
Terraform configuration you're using is using a custom configuration for
the Terraform backend.

Changes to backend configurations require reinitialization. This allows
Terraform to setup the new configuration, copy existing state, etc. This is
only done during "terraform init". Please run that command now then try again.

If the change reason above is incorrect, please verify your configuration
hasn't changed and try again. At this point, no changes to your existing
configuration or state have been made.

Failed to load backend: Initialization required. Please see the error message above.
```
