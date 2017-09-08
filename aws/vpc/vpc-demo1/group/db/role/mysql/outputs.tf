output "role_sg_id" {
  value = "${aws_security_group.sg.id}"
}

output "iamrole_name" {
  value = "${aws_iam_role.iamrole.name}"
}
