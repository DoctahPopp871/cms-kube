/*******************************
hdb EKS Control Plane IAM Role
********************************/

resource "aws_iam_role" "AmazonEKSRole" {
    name = "AmazonEKSControlRole"
    assume_role_policy = <<EOF
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Service": "eks.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
EOF
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name  = "hdb-eks"
  roles = ["${aws_iam_role.AmazonEKSRole.name}"]
}

resource "aws_iam_role_policy_attachment" "AmazonEKSRole_attach_1" {
    role       = "${aws_iam_role.AmazonEKSRole.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
resource "aws_iam_role_policy_attachment" "AmazonEKSRole_attach_2" {
    role       = "${aws_iam_role.AmazonEKSRole.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_iam_role_policy_attachment" "AmazonEKSRole_attach_3" {
    role       = "${aws_iam_role.AmazonEKSRole.name}"
    policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}
resource "aws_iam_role_policy_attachment" "AmazonEKSRole_attach_4" {
    role       = "${aws_iam_role.AmazonEKSRole.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
resource "aws_iam_role_policy_attachment" "AmazonEKSRole_attach_5" {
    role       = "${aws_iam_role.AmazonEKSRole.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}
resource "aws_iam_role_policy_attachment" "AmazonEKSRole_attach_6" {
    role       = "${aws_iam_role.AmazonEKSRole.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
resource "aws_iam_role_policy_attachment" "AmazonEKSRole_attach_7" {
    role       = "${aws_iam_role.AmazonEKSRole.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

/*******************************
hdb EKS  Control Plane IAM Role
********************************/

/*******************************
hdb EKS  Worker Nodes IAM Role
********************************/

resource "aws_iam_role" "AmazonEKSWorkerNode" {
  name = "AmazonEKSWorkerRole"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNode_attach_1" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = "${aws_iam_role.AmazonEKSWorkerNode.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNode_attach_2" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = "${aws_iam_role.AmazonEKSWorkerNode.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNode_attach_3" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.AmazonEKSWorkerNode.name}"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNode_attach_4" {
    role       = "${aws_iam_role.AmazonEKSWorkerNode.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNode_attach_5" {
    role       = "${aws_iam_role.AmazonEKSWorkerNode.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNode_attach_6" {
    role       = "${aws_iam_role.AmazonEKSWorkerNode.name}"
    policy_arn = "arn:aws:iam::413230511243:policy/alb-ingress-controller"
}

resource "aws_iam_instance_profile" "eks-worker-node" {
  name = "hdb-eks-worker"
  role = "${aws_iam_role.AmazonEKSWorkerNode.name}"
}

/*******************************
hdb EKS  Worker Nodes IAM Role
********************************/
