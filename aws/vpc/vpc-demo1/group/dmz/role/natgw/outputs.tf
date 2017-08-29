output "nat_gw_eip" {
  value = "${aws_eip.eip.public_ip}"
}
