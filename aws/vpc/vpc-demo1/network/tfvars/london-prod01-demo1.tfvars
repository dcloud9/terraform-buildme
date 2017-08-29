availability_zones 			= ["eu-west-2a", "eu-west-2b"]
subnets_public1		 			= ["10.0.1.0/24", "10.0.2.0/24"]
subnets_private1	 			= ["10.0.11.0/24", "10.0.12.0/24"]
subnets_private2				= ["10.0.21.0/24", "10.0.22.0/24"]

public1_subnet_type     = "dmz"
private1_subnet_type    = "web"
private2_subnet_type    = "db"

tags = {
  "CustomTag1"     = "CustomVal1"
  "CustomTag2"     = "CustomVal2"
}
