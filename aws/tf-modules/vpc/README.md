Terraform AWS VPC Module
===========

A Terraform module to create a VPC and associated resources within AWS.  This module will create:

- A Virtual Private Cloud
- An Internet Gateway
- A VPC Security Group with default egress to all

Input Variables
---------------

- `cidr_block` - (Required) The CIDR block for the VPC
- `enable_dns_support` - (Optional) A boolean flag to enable/disable DNS support in the VPC. Defaults to true.
- `enable_dns_hostnames` -  (Optional) A boolean flag to enable/disable DNS hostnames in the VPC. Defaults to true.
- `environment` - (Required) The name of the environment that the resource belongs to - used for tagging.
- `owner` - (Optional) The owner responsible for managing the resource - used for tagging.
- `region` - (Required) The region that the resource belongs to - used for tagging.
- `built_by` - (Required) The id of the person - used for tagging. e.g. jbloggs or jbloggs@email.com
- `tags` - (Optional) A map of additional tags to associate with the resource. Defaults to {}

Output Variables
----------------

- `vpc_id` - The id of the VPC
- `vpc_igw_id` - The id of the internet gateway
- `vpc_sg_id` The id of VPC security group

Usage
-----

```
module "vpc" {
  source = "../../tf-modules/vpc"

  environment = "dev1"
  cidr_block = "10.x.0.0/16"
  region = "eu-west-1"
  built_by = "jbloggs"
  tags = "{map(
  	"AddTag1", "AddVal1"
  	"AddTag2", "AddVal2"
  )}"
}
```