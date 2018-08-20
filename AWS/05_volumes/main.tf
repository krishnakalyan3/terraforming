# Attach 400 gb volume
# Tip make sure the default security group has ssh enabled

provider "aws" {
  region = "us-east-1"
  shared_credentials_file = "/home/krishna/.aws/credentials"
  profile                 = "krishna"
}

resource "aws_ebs_volume" "volume" {
    availability_zone = "${aws_instance.ec2.availability_zone}"
    size = 400
    tags {
        Name = "Terraform"
    }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.volume.id}"
  instance_id = "${aws_instance.ec2.id}"
}

resource "aws_instance" "ec2" {
  ami           = "ami-c6ac1cbc"
  instance_type = "t2.micro"
  key_name = "terraform"

  tags {
    Name = "Terraform"
  }
}

output "public_ip" {
    value = "${aws_instance.ec2.public_ip}"
}
