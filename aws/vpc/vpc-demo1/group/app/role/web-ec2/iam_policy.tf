# Deny instances to read tfstate files stored in S3
data "aws_iam_policy_document" "s3_read" {
  statement {
    effect = "Allow"

    actions = [
      "s3:List*",
      "s3:Get*",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    effect  = "Deny"
    actions = ["s3:*"]

    resources = [
      "arn:aws:s3:::${replace(var.s3tfstate, var.region, "*")}",
    ]
  }
}

resource "aws_iam_policy" "s3_read" {
  description = "${var.environment_role} S3 ReadOnly Policy"
  name        = "iampolicy-${var.environment_role}-s3-read-${var.region}"
  policy      = "${data.aws_iam_policy_document.s3_read.json}"
}

resource "aws_iam_role_policy_attachment" "iamrole_attach" {
  role       = "${aws_iam_role.iamrole.name}"
  policy_arn = "${aws_iam_policy.s3_read.arn}"
}
