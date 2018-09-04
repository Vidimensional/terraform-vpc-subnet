resource "aws_subnet" "subnet" {
  vpc_id                  = "${var.vpc_id}"
  cidr_block              = "${var.cidr_block}"
  availability_zone       = "${var.availability_zone}"
  map_public_ip_on_launch = "${var.public}"

  tags {
    Name    = "${var.tags["Project"]}-${var.tags["Env"]}-${var.public != "false" ? "public" : "private"}-${substr(var.availability_zone, length(var.availability_zone)-1, 1)}"
    Subnet  = "${var.public != "false" ? "public" : "private"}"
    Project = "${var.tags["Project"]}"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${var.vpc_id}"

  tags {
    Project = "${var.tags["Project"]}"
    Env     = "${var.tags["Env"]}"
  }
}

resource "aws_route" "internet_route" {
  count                  = "${var.public != "false" ? 1 : 0 }"
  route_table_id         = "${aws_route_table.rt.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${var.gateway_id}"
}

resource "aws_route_table_association" "a" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.rt.id}"
}
