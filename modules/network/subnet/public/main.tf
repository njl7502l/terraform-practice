# Public
# ------------------------------------------------------------------------------
resource "aws_subnet" "public_subnets" {
  for_each = { for v in setproduct(
    var.subnet.public_types,
    var.subnet.azs
  ) : join(",", v) => v }

  vpc_id = var.vpc_id
  cidr_block = cidrsubnet(
    var.vpc.cidr_block,
    var.subnet.newbits,
    var.subnet.public_netnums[each.value[0]][each.value[1]]
  )
  availability_zone       = "ap-northeast-1${each.value[1]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.common.app_name}-${var.common.env}-public-${each.value[0]}-${each.value[1]}-subnet"
  }
}

# IGW
# ------------------------------------------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
}

# igwへのルートテーブル作成
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# publicのサブネットにはigwへのルートテーブルを関連付け
resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
