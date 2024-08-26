
# NAT Gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1a.id
  tags = {
    Name = "nat-gateway"
  }
  depends_on = [aws_eip.nat]
}

# Elastic IP
resource "aws_eip" "nat" {
  vpc = true
  tags = {
    Name = "nat-eip"
  }
}
