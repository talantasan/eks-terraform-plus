data "aws_iam_openid_connect_provider" "external_dns" {
    arn = "arn:aws:iam::543987887526:oidc-provider/oidc.eks.us-east-1.amazonaws.com/id/946DBCD9CC2B1C3DC8E7A5644889977C"
}

output "oidc_data" {
    value = "${replace(data.aws_iam_openid_connect_provider.external_dns.url, "https://", "")}:sub"
}

data "aws_iam_policy_document" "oid_assum_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test  = "StringEquals"
      variable = "${replace(data.aws_iam_openid_connect_provider.external_dns.url, "https://", "")}:sub"
      values  = ["system:serviceaccount:external-dns:externaldns"]
    }
    principals {
      identifiers = [data.aws_iam_openid_connect_provider.external_dns.arn]
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


