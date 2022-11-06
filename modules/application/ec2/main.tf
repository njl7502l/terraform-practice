data "aws_iam_policy_document" "ec2_task_assumerole" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "ec2_inline_policy" {
  statement {
    effect    = "Allow"
    actions   = ["iam:PassRole"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values   = ["ec2.amazonaws.com"]
      variable = "iam:PassedToService"
    }
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:*",
      "s3-object-lambda:*"
    ]
    resources = [
      "*"
    ]
  }
}

resource "aws_iam_role" "role" {
  name               = "test_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_task_assumerole.json
}

resource "aws_iam_role_policy" "s3_policy_01" {
  name   = "s3_sgw-hoge_role"
  role   = aws_iam_role.role.id
  policy = data.aws_iam_policy_document.ec2_inline_policy.json
}

resource "aws_iam_instance_profile" "s3_full_access_profile" {
  name = "s3_full_access_profile"
  role = aws_iam_role.role.name
}

# 最新のAMIを取得
data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "testEC2" {
  for_each = toset([for az in var.subnet_azs : var.subnet_public_ids["web,${az}"]])

  ami                         = data.aws_ssm_parameter.amzn2_ami.value
  instance_type               = "t2.micro"
  key_name                    = "hanazono-key-pair"
  subnet_id                   = each.value
  iam_instance_profile        = aws_iam_instance_profile.s3_full_access_profile.name
  monitoring                  = true
  user_data                   = file("../../modules/application/ec2/user_data.sh")
  vpc_security_group_ids      = [var.sg_web_ec2_id]
  associate_public_ip_address = "true" # ipアドレスの自動割当設定

  depends_on = [
    var.subnet_public_ids
  ]
}
