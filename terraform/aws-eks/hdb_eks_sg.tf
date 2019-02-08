/*******************************
  hdb Web Security Group
********************************/
resource "aws_security_group" "hdb_www_all" {
    name = "hdb_www_all"
    description = "hdb www-all"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  vpc_id = "${aws_vpc.default.id}"

  tags {
      Name = "hdb_www_all"
  }
}

/*******************************
  hdb Web Security Group
********************************/
resource "aws_security_group" "hdb_www_server" {
    name = "hdb_www_server"
    description = "hdb www-server"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.hdb_www_all.id}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.hdb_www_all.id}"]
    }
    ingress {
        from_port = 3001
        to_port = 3001
        protocol = "tcp"
        security_groups = ["${aws_security_group.hdb_www_all.id}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  vpc_id = "${aws_vpc.default.id}"

  tags {
      Name = "hdb_www_server"
  }
}

/*******************************
  hdb Admin Security Group
********************************/
resource "aws_security_group" "hdb_admin" {
    name = "hdb_admin"
    description = "hdb Admin"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.mgmt_cidr}","199.20.36.1/32"]
    }
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  vpc_id = "${aws_vpc.default.id}"

  tags {
      Name = "hdb_Admin"
  }
}

/*******************************
  hdb EKS Control Plane Security Group
********************************/
resource "aws_security_group" "hdb_eks_cp" {
    name = "hdb_eks_cp"
    description = "hdb EKS Control Plane"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["${var.mgmt_cidr}","199.20.36.1/32"]
    }
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        security_groups = ["${aws_security_group.hdb_eks_wrkr.id}"]
    }

    egress {
        from_port = 1025
        to_port = 65535
        protocol = "tcp"
        security_groups = ["${aws_security_group.hdb_eks_wrkr.id}"]
    }

  tags {
      Name = "hdb_EKS_Cp"
  }
}

/*******************************
  hdb EKS Worker Node Security Group
********************************/
resource "aws_security_group" "hdb_eks_wrkr" {
    name = "hdb_eks_wrkr"
    description = "hdb EKS Worker Nodes"
    vpc_id = "${aws_vpc.default.id}"

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        self = true
        description = "Allow node to communicate with each other"
    }
    ingress {
        from_port = 1025
        to_port = 65535
        protocol = "tcp"
        security_groups = ["sg-082a5dc15885466fb"]
        description = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

 tags = "${
      map(
       "Name", "hdb_EKS_Wkr",
       "kubernetes.io/cluster/${var.eks-cluster-name}", "owned",
      )
    }"
}
