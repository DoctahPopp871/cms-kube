resource "aws_eks_cluster" "hdb-eks" {
  name            = "${var.eks-cluster-name}"
  role_arn        = "arn:aws:iam::413230511243:role/AmazonEKSControlRole"

  vpc_config {
    security_group_ids = ["${aws_security_group.hdb_eks_cp.id}"]
    subnet_ids         = ["${aws_subnet.us-east-1b-public.id}","${aws_subnet.us-east-1c-public.id}","${aws_subnet.us-east-1d-public.id}"]
  }
  depends_on = [
    "aws_iam_role_policy_attachment.AmazonEKSRole_attach_5",
    "aws_iam_role_policy_attachment.AmazonEKSRole_attach_6",
  ]
}

#resource "aws_ecr_repository" "hdb-be-prod" {
#  name = "hdb-be-prod"
#}


locals {
  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.hdb-eks.endpoint}
    certificate-authority-data: ${aws_eks_cluster.hdb-eks.certificate_authority.0.data}
  name: ${var.eks-cluster-name}
contexts:
- context:
    cluster: ${var.eks-cluster-name}
    user: aws
  name: ${var.eks-cluster-name}
current-context: ${var.eks-cluster-name}
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.eks-cluster-name}"
        - "-r"
        - "${var.aws_role_arn}"
KUBECONFIG
}

output "kubeconfig" {
  value = "${local.kubeconfig}"
}
