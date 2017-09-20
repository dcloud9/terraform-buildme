# buildme

## Prerequisites

* terraform (https://www.terraform.io/downloads)
* git - any git-compatible app will do
* awscli (Optional) `$ sudo pip install awscli`

## Readme and just do it 

* Infrastructure and Code should be both scalable. __terraform-buildme__ provides a framework to build a multi-region cloud-agnostic infrastructure using the same code base and at the same time expand or scale by reusing the blocks of code.

* Setting API/access keys are not covered here as they can vary from one cloud provider to another. Ensure proper creds and keys are configured where you run terraform.

* Update vpc-\<name\>/tfvars -> public_key with the contents of public key (eg. ssh-rsa AAA...).

* __Usage:__ `./buildme london|ireland|virginia|frankfurt prod01|stage66|dev80 plan|apply|destroy|taint|show|refresh|... [-var-file="tfvars/<tfvarsfile.tfvars>"] [-target=<resource]`

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

* Regardless of using recommended or custom S3 bucket name for tfstate files, update tf_env_vars.sh -> S3TFSTATE with S3 bucket name.  Add "REGION" regardless of single or multi-region stack, makes your infra multi-region ready.

* Git clone the Github repo. Once cloned successfully and before creating a new branch, ensure a `git pull` of master to sync with latest merges with the master branch.

`$ git clone git@github.com:dcloud9/terraform-buildme.git`

```
└── aws
    ├── common
    │   └── scripts
    └── vpc
        └── vpc-demo1
            ├── group
            │   ├── app
            │   │   ├── role
            │   │   │   ├── web-asg
            │   │   │   │   ├── tfvars
            │   │   │   │   └── userdata_files
            │   │   │   └── web-ec2
            │   │   │       ├── tfvars
            │   │   │       └── userdata_files
            │   │   └── tfvars
            │   ├── db
            │   │   ├── role
            │   │   │   ├── mysql
            │   │   │   │   ├── tfvars
            │   │   │   │   └── userdata_files
            │   │   └── tfvars
            │   └── dmz
            │       ├── role
            │       │   ├── natgw
            │       │   │   ├── tfvars
            │       │   └── bastion
            │       │       ├── tfvars
            │       │       └── userdata_files
            │       └── tfvars
            ├── network
            │   └── tfvars
            └── tfvars
```

### Tree structure

    * `aws` - Terraform provider, eg. aws, azure, google, openstack
        * `common` - Scripts, settings, etc common/shared across all downstream VPCs. Tfstate files could exist at this level.
        * `vpc` - Placeholder for multiple `vpc-` names
            * `vpc-<name>` - Can be more than 1 VPC if different downstream groups or roles will be stood. Layer1 VPC SG stood here. Tfstate file exists.
                * `network` - Subnets, Routing tables, Routes, VPC Endpoints: S3. Tfstate file exists
                    * `dmz` - Group for public facing roles/instance, eg. NAT GateWay, bastion. Tfstate file exists.
                        * `role` - Placeholder for multiple roles.
                            * `natgw` - AWS NAT GW. Layer3 Role SG stood here. Tfstate file exists.
                            * `bastion` - Bastion/jumpbox. Layer3 Role SG stood here. Tfstate file exists.
                    * `moregroups` - Add more groups here as required
                        * `moreroles` - Add more roles here as required
            * `vpc-<foo>` - Add more VPCs here. Tfstate file exists.
                * `network` - Subnets, Routing tables, Routes, VPC Endpoints: S3. Tfstate file exists.
                * `group` - Placeholder for multiple group names. Layer 2 Group SG stood here.                  
                    * `dmz` - Group for public facing roles/instance, eg. VPN, SFTP. Tfstate file exists.
                        * `role` - Placeholder for multiple roles.
                            * `sftp` - Secure FTP. Layer3 Role SG stood here. Tfstate file exists.
                            * `vpn` - Firewall/VPN. Layer3 Role SG stood here. Tfstate file exists.
                    * `moregroups` - Add more groups here as required
                        * `moreroles` - Add more roles here as required

## Start building

1. Install the latest or at least Terraform v0.9.5 from https://www.terraform.io/downloads.html. Note the instructions below are valid for Linux Only. Tweaks might be needed in Mac or Windows OS. Feel free to contribute back to the community :)
2. Note of potential breaking changes in Terraform releases before applying changes in the infrastructure. Plan, plan, plan. Refer to *Changelogs* of relevant version (https://github.com/hashicorp/terraform/blob/vX.Y.Z/CHANGELOG.md)
Eg. https://github.com/hashicorp/terraform/blob/v0.9.11/CHANGELOG.md
3. `$ cd terraform-buildme/aws/vpc/vpc-<name>` - To build a VPC. VPC SG created here at this level. Eg. sg-[env#]-[vpc-name]; sg-prod01-demo1; where env# = env number in case of cloning the env for example in troubleshooting, quarantine, forensics, or blue/green deployments
    * Create a min of 2048-bit key and update public_key value of keypair.tf with the contents of .pub file
        * `$ ssh-keygen -b 2048 -C kp-<env#>-<vpcname>  ./kp-<env#>-<vpcname>`
    * Rename the private key to a .pem file to diff with .pub, then secure it (ie. `$ chmod 400 kp-<env#>-<vpcname>.pem`) and save in the shared drive for decrypting Win Administrator password or SSH'ng to Linux instances.
4. `$ cd terraform-buildme/aws/vpc/vpc-name/network` - To build the VPC core network. 
5. `$ cd terraform-buildme/aws/vpc/vpc-name/group/<groupname>` - To build the Group SG. sg-[env#]-[vpc-name]; sg-dev01-trading-apps
6. `$ cd terraform-buildme/aws/vpc/vpc-name/group/<groupname>/role/<rolename>` - To build the role including Role SG. sg-[role]-[env#]-[vpc-name]; sg-web-prod01-demo1
7. `$ ./buildme <region> <env#> plan -var-file="tfvars/<region>-<env#>-<rolename|vpcname>.tfvars"` - Plan, plan, plan. Customise tfvars accordingly on region, env#, or role levels and keep the terraform scripts **immutable**
8. `$ ./buildme <region> <env#> apply -var-file="tfvars/<region>-<env#>-<rolename|vpcname>.tfvars"` - Plan, plan, plan, and more plan before you apply. 
9. `$ ./buildme <region> <env#> destroy -var-file="tfvars/<region>-<env#>-<rolename|vpcname>.tfvars"` - To destroy the 'stack'

### Some helpful Terraform commands:
* `$ ./buildme <region> <env#> taint aws_instance.instance` - Example of tainting EC2 resource for a quick rebuild with destroying the whole stack. Any resource within the stack can be tainted if needed. Run `plan` after tainting.
* `$ ./buildme <region> <env#> plan|apply -var-file="tfvars/<region>-<env#>-<rolename|vpcname>.tfvars" -target=aws_instance.instance -target=<another-targeted.resource>` - For targeting specific resources. Terraform will automatically pick up other resources as it works out dependencies.
