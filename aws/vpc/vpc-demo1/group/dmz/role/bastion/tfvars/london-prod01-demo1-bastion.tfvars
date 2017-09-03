active = "AZ1"
ami = "ami-489f8e2c"
associate_public_ip_address = true
hostname = ["bastion1", "bastion2"]
#domainname = "mydomain.io"
instance_type = "t2.nano"
use_eip = "yes"


tags = {
  "AMIBackup"     = "yes"
}
