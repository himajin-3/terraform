
####################
# vpc
####################
resource "aws_vpc" "main" {
  cidr_block           = var.vpc
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-vpc"
  }
}
 
####################
# subnet
####################
# プライベートサブネット作成
resource "aws_subnet" "private_1a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet
  availability_zone = "ap-northeast-1a"
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-private-1a"
  }
}
 
####################
# route table
####################
# private_ルートテーブル作成
resource "aws_route_table" "private_1a" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-private-1a"
  }
}
 
# private_ルートテーブル紐づけ
resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.private_1a.id
}
