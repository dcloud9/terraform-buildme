availability_zones 			= ["eu-west-1a", "eu-west-1b"]
subnets_public1		 			= ["10.2.1.0/24", "10.2.2.0/24"]
subnets_private1	 			= ["10.2.11.0/24", "10.2.12.0/24"]
subnets_private2				= ["10.2.21.0/24", "10.2.22.0/24"]

public1_subnet_type     = "dmz"
private1_subnet_type    = "web"
private2_subnet_type    = "db"

tags = {
  "CustomTag1"     = "CustomVal1"
  "CustomTag2"     = "CustomVal2"
}
