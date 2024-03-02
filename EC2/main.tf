<<<<<<< HEAD
#provider "aws" {
#    profile = "terraform" # .aws\configに記載
#    region  = "ap-northeast-1"
#}
=======
provider "aws" {
    profile = "terraform" # .aws\configに記載
    region  = "ap-northeast-1"
}
>>>>>>> origin/master

resource "aws_instance" "hello-world" {
    ami           = "ami-0ce107ae7af2e92b5"
    instance_type = "t2.micro"

    tags = {
        Name = "helloworld"
    }

    user_data = <<EOF
#!/bin/bash
amazon-linux-extras install -y nginx1.12
systemctl start nginx
EOF
}
