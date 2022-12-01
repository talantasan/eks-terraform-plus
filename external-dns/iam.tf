data "aws_iam_policy_document" "oid_assum_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test  = "StringEquals"
      variable = "${replace(data.terraform_remote_state.infra.outputs.oidc_url, "https://", "")}:sub"
      values  = ["system:serviceaccount:external-dns:external-dns"]
    }
    principals {
      identifiers = [data.terraform_remote_state.infra.outputs.oidc_arn]
      type  = "Federated"
    }
  }
}


resource "aws_iam_policy" "extenal_dns_policy" {
  name = "talant-external-dns-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "route53:ChangeResourceRecordSets"
      ],
      "Resource": [
        "arn:aws:route53:::hostedzone/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:ListHostedZones",
        "route53:ListResourceRecordSets"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
POLICY
}

resource "aws_iam_role" "extrenal_dns_role" {
  name  = "external-dns-role"
  assume_role_policy  = data.aws_iam_policy_document.oid_assum_role_policy.json
}

resource "aws_iam_role_policy_attachment" "oidc_s3_policy_attach" {
  role  = aws_iam_role.extrenal_dns_role.name
  policy_arn  = aws_iam_policy.extenal_dns_policy.arn
}


