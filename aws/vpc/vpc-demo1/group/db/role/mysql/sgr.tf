# Allow SSH from Bastion
resource "aws_security_group_rule" "sgr_ingress_tcp_22_bastion" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 22
  to_port                  = 22
  source_security_group_id = "${data.terraform_remote_state.role_bastion.role_sg_id}"
  security_group_id        = "${aws_security_group.sg.id}"
}

# Allow MariaDB port from App group
resource "aws_security_group_rule" "sgr_ingress_tcp_3306_app" {
  type                     = "ingress"
  protocol                 = "tcp"
  from_port                = 3306
  to_port                  = 3306
  source_security_group_id = "${data.terraform_remote_state.group_app.group_sg_id}"
  security_group_id        = "${aws_security_group.sg.id}"
}
