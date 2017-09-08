resource "aws_iam_instance_profile" "iamprofile" {
  name = "iamprofile-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.region}"
  role = "${aws_iam_role.iamrole.name}"
}

resource "aws_iam_role" "iamrole" {
  name = "iamrole-${var.environment_role}-${var.environment}-${var.environment_vpc}-${var.region}"
  path = "/"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": { "Service": "ec2.amazonaws.com" },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
