####################
# vpc endpoint
####################
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${local.region}.ssm"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.main.id]
  subnet_ids          = [aws_subnet.private_1a.id]
  private_dns_enabled = true
 
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-vpc-endpoint"
  }
}
 
resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${local.region}.ec2messages"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.main.id]
  subnet_ids          = [aws_subnet.private_1a.id]
  private_dns_enabled = true
 
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-vpc-endpoint"
  }
}
 
resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.main.id
  service_name        = "com.amazonaws.${local.region}.ssmmessages"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.main.id]
  subnet_ids          = [aws_subnet.private_1a.id]
  private_dns_enabled = true
 
  tags = {
    Name = "${local.name_prefix}-${local.Environment}-vpc-endpoint"
  }
}