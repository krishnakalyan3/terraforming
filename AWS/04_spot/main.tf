# P2 Spot Instance
# FastAI AMI

# TODO
# Create a keypair for N.V Region
# Volume with 800 GB
# Remote Exec
# Update IAM and FastAI

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/krishna/.aws/credentials"
  profile                 = "krishna"
}

resource "aws_spot_instance_request" "spot" {
  ami           = "ami-c6ac1cbc"
  spot_price    = "0.90"
  instance_type = "p2.xlarge"

  tags {
    Name = "P3 Spot"
  }
}

output "public_ip" {
    value = "${aws_spot_instance_request.spot.public_ip}"
}
