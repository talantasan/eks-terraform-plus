data "tls_certificate" "myeks"{
    url = aws_eks_cluster.this.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "myeks" {
  url = aws_eks_cluster.this.identity[0].oidc[0].issuer

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [data.tls_certificate.myeks.certificates[0].sha1_fingerprint]

  tags = {
    Name = "Common"
  }
}

# Create sample iam policy document for my-test service account in default namespace
data "aws_iam_policy_document" "oid_assum_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"
    condition {
      test  = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.myeks.url, "https://", "")}:sub"
      values  = ["system:serviceaccount:default:my-test"]
    }
    principals {
      identifiers = [aws_iam_openid_connect_provider.myeks.arn]
      type  = "Federated"
    }
  }
}

# Create role and attach policy
resource "aws_iam_role" "oidc_role" {
  name  = "oidc-s3-role"
  assume_role_policy  = data.aws_iam_policy_document.oid_assum_role_policy.json
}

# Create policy 
resource "aws_iam_policy" "oidc_s3_policy" {
  name  = "s3-oidc-sa-test"
  policy = jsonencode({
    Statement = [{
      Action = [
        "s3:ListAllMyBuckets",
        "s3:GetBucketLocation"
      ]
      Effect = "Allow"
      Resource = "arn:aws:s3:::*"
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "oidc_s3_policy_attach" {
  role  = aws_iam_role.oidc_role.name
  policy_arn  = aws_iam_policy.oidc_s3_policy.arn
}

output "oidc_role_arn" {
  value = aws_iam_role.oidc_role.arn
}