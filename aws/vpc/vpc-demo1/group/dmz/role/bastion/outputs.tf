output "role_sg_id" {
  value = "${aws_security_group.sg.id}"
}

output "iamrole_name" {
  value = "${aws_iam_role.iamrole.name}"
}

output "role_eips" {
  value = ["${aws_eip.eip.*.public_ip}"]
}
