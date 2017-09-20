availability_zones 			= ["ap-southeast-1a", "ap-southeast-1b"]
subnets_public1		 			= ["10.3.1.0/24", "10.3.2.0/24"]
subnets_private1	 			= ["10.3.11.0/24", "10.3.12.0/24"]
subnets_private2				= ["10.3.21.0/24", "10.3.22.0/24"]

public1_subnet_type     = "dmz"
private1_subnet_type    = "web"
private2_subnet_type    = "db"

tags = {
  "CustomTag1"     = "CustomVal1"
  "CustomTag2"     = "CustomVal2"
}
