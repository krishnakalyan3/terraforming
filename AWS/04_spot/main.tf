# P2 Spot Instance
# FastAI AMI

resource "aws_security_group" "fastai" {
  description = "Fast.ai instance security group"
  vpc_id      = "${var.vpc_id}"

  # SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jupyter
  ingress {
    from_port   = 8888
    to_port     = 8898
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/krishna/.aws/credentials"
  profile                 = "krishna"
}

resource "aws_spot_instance_request" "spot" {
  ami           = "ami-c6ac1cbc"
  spot_price    = "0.90"
  instance_type = "p2.xlarge"
  vpc_security_group_ids = ["${aws_security_group.fastai.id}"]

  tags {
    Name = "Spot Instance"
  }
}

output "public_ip" {
    value = "${aws_spot_instance_request.spot.public_ip}"
}
