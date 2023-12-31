module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_endpoint_public_access = true

  cluster_name    = var.name
  cluster_version = "1.26"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    main = {
      desired_size   = 1
      instance_types = ["t2.micro"]
    }
  }

  create_aws_auth_configmap = true
  manage_aws_auth_configmap = true

  aws_auth_roles = [
    {
      rolearn  = var.rolearn
      username = var.username
      groups   = ["system:masters"]
    },
  ]

  cluster_security_group_additional_rules = {
    argo_workflow = {
      protocol        = "tcp"
      from_port       = 30000
      to_port         = 30000
      security_groups = [aws_security_group.alb.id]
      description     = "Argo Workflow"
      type            = "ingress"
      self            = true
    }
  }

  node_security_group_additional_rules = {
    argo_workflow = {
      protocol    = "tcp"
      from_port   = 30000
      to_port     = 30000
      cidr_blocks = ["0.0.0.0/0"]
      description = "Argo Workflow"
      type        = "ingress"
    }
    # AdmissionWebhookが動作しないので追加指定
    admission_webhook = {
      description                   = "Admission Webhook"
      protocol                      = "tcp"
      from_port                     = 0
      to_port                       = 65535
      type                          = "ingress"
      source_cluster_security_group = true
    }
    # Node間通信を許可
    ingress_node_communications = {
      description = "Ingress Node to node"
      protocol    = "tcp"
      from_port   = 0
      to_port     = 65535
      type        = "ingress"
      self        = true
    }
    egress_node_communications = {
      description = "Egress Node to node"
      protocol    = "tcp"
      from_port   = 0
      to_port     = 65535
      type        = "egress"
      self        = true
    }
  }
}

resource "aws_autoscaling_attachment" "argo_workflows" {
  autoscaling_group_name = module.eks.eks_managed_node_groups_autoscaling_group_names[0]
  lb_target_group_arn    = aws_lb_target_group.eks.id
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args        = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}
