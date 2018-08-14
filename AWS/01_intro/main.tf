
provider "aws" {
  region = "ap-south-1"
}

# Tips
# Make sure your default sg has port 22 open to ssh
# Import id_rsa.pub to your keypairs

resource "aws_instance" "ec2" {
 ami = "ami-188fba77"
 instance_type = "t2.micro"
 key_name = "id_rsa"

 tags {
  Name = "Terraform"
 }
}

output "public_ip" {
    value = "${aws_instance.ec2.public_ip}"
}