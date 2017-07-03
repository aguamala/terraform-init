#--------------------------------------------------------------
# AWS VPC
#--------------------------------------------------------------
resource "aws_vpc" "mod" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", "${var.name}"))}"
}

resource "aws_internet_gateway" "mod" {
  vpc_id = "${aws_vpc.mod.id}"
  tags   = "${merge(var.tags, map("Name", "${var.name}-igw"))}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.mod.id}"
}

#get AZs
#FIXME: When data.aws_availability_zones supports count interpolation we can use it instead of var.azs
#data "aws_availability_zones" "available" {}

#--------------------------------------------------------------
# private subnets
#--------------------------------------------------------------
resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.mod.id}"
  cidr_block        = "${cidrsubnet(var.cidr, var.cidrsubnet_newbits, count.index + var.cidrsubnet_netnum_private)}"
  availability_zone = "${var.azs[count.index]}"
  count             = "${length(var.azs)}"
  tags              = "${merge(var.tags, map("Name", "${var.name}-private-${count.index}"))}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${var.private_propagating_vgws}"]
  tags             = "${merge(var.tags, map("Name", "${var.name}-private"))}"
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.azs)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${aws_route_table.private.id}"
}

#--------------------------------------------------------------
# public subnets
#--------------------------------------------------------------
resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.mod.id}"
  cidr_block              = "${cidrsubnet(var.cidr, var.cidrsubnet_newbits, count.index + var.cidrsubnet_netnum_public)}"
  availability_zone       = "${var.azs[count.index]}"
  count                   = "${length(var.azs)}"
  tags                    = "${merge(var.tags, map("Name", "${var.name}-public-${count.index}"))}"
  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.mod.id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]
  tags             = "${merge(var.tags, map("Name", "${var.name}-public"))}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.azs)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}
