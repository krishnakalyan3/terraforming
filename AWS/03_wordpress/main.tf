
provider "aws" {
  region = "ap-south-1"
  shared_credentials_file = "/home/krishna/.aws/credentials"
  profile                 = "krishna"
}

resource "aws_instance" "ec2" {
  ami           = "ami-037735ffc2393359b"
  instance_type = "t2.micro"
  key_name = "id_rsa"

  tags {
    Name = "WebSite"
  }
}

output "public_ip" {
    value = "${aws_instance.ec2.public_ip}"
}
