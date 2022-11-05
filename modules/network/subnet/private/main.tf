# Private
# ------------------------------------------------------------------------------
resource "aws_subnet" "private_subnets" {
  for_each = { for v in setproduct(
    var.subnet.private_types,
    var.subnet.azs
  ) : join(",", v) => v }

  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(
    var.vpc.cidr_block,
    var.subnet.newbits,
    var.subnet.private_netnums[each.value[0]][each.value[1]]
  )
  availability_zone       = "ap-northeast-1${each.value[1]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.common.app_name}-${var.common.env}-private-${each.value[0]}-${each.value[1]}-subnet"
  }
}

# NAT GW
# ------------------------------------------------------------------------------
resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "natgw" {
  subnet_id     = var.subnet_public_ids["web,a"]
  allocation_id = aws_eip.eip.id
}

resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw.id
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
