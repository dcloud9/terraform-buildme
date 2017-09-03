output "role_sg_id" {
  value = "${aws_security_group.sg.id}"
}

output "iamrole_name" {
  value = "${aws_iam_role.iamrole.name}"
}

output "elb_sg_id" {
  value = "${aws_security_group.elb_sg.id}"
}

output "elb_name" {
  value = "${aws_elb.elb.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}

output "elb_zone_id" {
  value = "${aws_elb.elb.zone_id}"
}
