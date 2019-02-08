resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "hdb01-eks-vpc",
        "kubernetes.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

resource "aws_route_table" "us-east-1" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "hdb eks Public RouteTable"
    }
}

resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.hdb_subnet_cidr_a}"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags {
        Name = "hdb eks Subnet1a",
        "kubernetes.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1.id}"
}


resource "aws_subnet" "us-east-1b-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.hdb_subnet_cidr_b}"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags {
        Name = "hdb eks Subnet1b",
        "kubernetes.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_route_table_association" "us-east-1b-public" {
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
    route_table_id = "${aws_route_table.us-east-1.id}"
}

resource "aws_subnet" "us-east-1c-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.hdb_subnet_cidr_c}"
    availability_zone = "us-east-1c"
    map_public_ip_on_launch = true

    tags {
        Name = "hdb eks Subnet1c",
        "kubernetes.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_route_table_association" "us-east-1c-public" {
    subnet_id = "${aws_subnet.us-east-1c-public.id}"
    route_table_id = "${aws_route_table.us-east-1.id}"
}

resource "aws_subnet" "us-east-1d-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.hdb_subnet_cidr_d}"
    availability_zone = "us-east-1d"
    map_public_ip_on_launch = true

    tags {
        Name = "hdb eks Subnet1d",
        "kubernetes.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_route_table_association" "us-east-1d-public" {
    subnet_id = "${aws_subnet.us-east-1d-public.id}"
    route_table_id = "${aws_route_table.us-east-1.id}"
}


resource "aws_subnet" "us-east-1e-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.hdb_subnet_cidr_e}"
    availability_zone = "us-east-1e"
    map_public_ip_on_launch = true

    tags {
        Name = "hdb eks Subnet1e",
        "kubernetes.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_route_table_association" "us-east-1e-public" {
    subnet_id = "${aws_subnet.us-east-1e-public.id}"
    route_table_id = "${aws_route_table.us-east-1.id}"
}

resource "aws_subnet" "us-east-1f-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.hdb_subnet_cidr_f}"
    availability_zone = "us-east-1f"
    map_public_ip_on_launch = true

    tags {
        Name = "hdb eks Subnet1f",
        "kubernetes.io/cluster/${var.eks-cluster-name}" = "shared"
    }
}

resource "aws_route_table_association" "us-east-1f-public" {
    subnet_id = "${aws_subnet.us-east-1f-public.id}"
    route_table_id = "${aws_route_table.us-east-1.id}"
}
