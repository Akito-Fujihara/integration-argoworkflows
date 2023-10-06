data "aws_iam_policy_document" "artifact_repo_1_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = ["${aws_s3_bucket.artifact_repo_1.arn}/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = ["${aws_s3_bucket.artifact_repo_1.arn}"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation"
    ]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_policy" "artifact_repo_1_access" {
  name   = "argowf-artifact-repo-1-access"
  policy = data.aws_iam_policy_document.artifact_repo_1_access.json
}

data "aws_iam_policy_document" "artifact_repo_2_access" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]
    resources = ["${aws_s3_bucket.artifact_repo_2.arn}/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = ["${aws_s3_bucket.artifact_repo_2.arn}"]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:GetBucketLocation"
    ]
    resources = ["arn:aws:s3:::*"]
  }
}

resource "aws_iam_policy" "artifact_repo_2_access" {
  name   = "argowf-artifact-repo-2-access"
  policy = data.aws_iam_policy_document.artifact_repo_1_access.json
}
