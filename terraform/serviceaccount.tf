module "argowf_s3_access" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.0"

  role_name = "argowf-s3-access"
  allow_self_assume_role = false

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = [
        "argo-workflows:argo-workflows-server",
        "argo-workflows:argo-workflows-workflow-controller",
      ]
    }
  }
  role_policy_arns = {
    s3_1 = aws_iam_policy.artifact_repo_1_access.arn,
    s3_2 = aws_iam_policy.artifact_repo_2_access.arn,
  }
}

module "artifact_repo_1_s3_access" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.0"

  role_name = "s3-1-access"
  allow_self_assume_role = false

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = [
        "argo-workflows:artifact-repo-1-access",
      ]
    }
  }
  role_policy_arns = {
    s3_1 = aws_iam_policy.artifact_repo_1_access.arn,
  }
}

module "artifact_repo_2_s3_access" {
  source = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "5.30.0"

  role_name = "s3-2-access"
  allow_self_assume_role = false

  oidc_providers = {
    main = {
      provider_arn = module.eks.oidc_provider_arn
      namespace_service_accounts = [
        "argo-workflows:artifact-repo-2-access",
      ]
    }
  }
  role_policy_arns = {
    s3_1 = aws_iam_policy.artifact_repo_2_access.arn,
  }
}
