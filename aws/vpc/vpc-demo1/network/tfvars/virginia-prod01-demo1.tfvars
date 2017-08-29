availability_zones 			= ["us-east-1a", "us-east-1b"]
subnets_public1		 			= ["10.1.1.0/24", "10.1.2.0/24"]
subnets_private1	 			= ["10.1.11.0/24", "10.1.12.0/24"]
subnets_private2				= ["10.1.21.0/24", "10.1.22.0/24"]

public1_subnet_type     = "dmz"
private1_subnet_type    = "web"
private2_subnet_type    = "db"

tags = {
  "CustomTag1"     = "CustomVal1"
  "CustomTag2"     = "CustomVal2"
}
