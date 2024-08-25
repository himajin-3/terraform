####################
# ami
####################
data "aws_ami" "latest_amazon_linux2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
####################
# ec2
####################
resource "aws_instance" "main" {
  instance_type          = var.default_instance_type
  ami                    = data.aws_ami.latest_amazon_linux2.id
  subnet_id              = aws_subnet.private_1a.id
  vpc_security_group_ids = [aws_security_group.main.id]
  iam_instance_profile   = aws_iam_instance_profile.this.name
  root_block_device {
    volume_size           = 8
    volume_type           = "gp3"
    iops                  = 3000
    throughput            = 125
    delete_on_termination = true

    # EBSのNameタグ
    tags = {
      Name = "${local.name_prefix}-${local.Environment}"
    }
  }
  lifecycle {
    ignore_changes = [
      ami,
    ]
  }

  tags = {
    Name = "${local.name_prefix}-${local.Environment}"
  }
}

####################
# security group
####################
resource "aws_security_group" "main" {
  name   = "${local.name_prefix}-${local.Environment}-sg"
  vpc_id = aws_vpc.main.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.0.0/16"
    ]
  }

  tags = {
    Name = "${local.name_prefix}-${local.Environment}-sg"
  }
}


####################
# ec2 iam role
####################
# インスタンスプロファイルを作成
resource "aws_iam_role" "ssm_role" {
  name               = "${local.name_prefix}-${local.Environment}-ssm"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
 EOF
}

resource "aws_iam_role_policy" "this" {
  name   = "${local.name_prefix}-${local.Environment}-ssm"
  role   = aws_iam_role.ssm_role.name
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ssm:DescribeAssociation",
                "ssm:GetDeployablePatchSnapshotForInstance",
                "ssm:GetDocument",
                "ssm:DescribeDocument",
                "ssm:GetManifest",
                "ssm:GetParameter",
                "ssm:GetParameters",
                "ssm:ListAssociations",
                "ssm:ListInstanceAssociations",
                "ssm:PutInventory",
                "ssm:PutComplianceItems",
                "ssm:PutConfigurePackageResult",
                "ssm:UpdateAssociationStatus",
                "ssm:UpdateInstanceAssociationStatus",
                "ssm:UpdateInstanceInformation"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ssmmessages:CreateControlChannel",
                "ssmmessages:CreateDataChannel",
                "ssmmessages:OpenControlChannel",
                "ssmmessages:OpenDataChannel"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2messages:AcknowledgeMessage",
                "ec2messages:DeleteMessage",
                "ec2messages:FailMessage",
                "ec2messages:GetEndpoint",
                "ec2messages:GetMessages",
                "ec2messages:SendReply"
            ],
            "Resource": "*"
        }
    ]
}
    EOF
}

resource "aws_iam_instance_profile" "this" {
  name = "${local.name_prefix}-${local.Environment}-ssm"
  role = aws_iam_role.ssm_role.name
}
