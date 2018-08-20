
provider "aws" {
  region = "ap-south-1"
}

# Tips
# move to script to temp its the only writibale folder
# private key should declared as it is

resource "aws_instance" "ec2" {
 ami = "ami-188fba77"
 instance_type = "t2.micro"
 key_name = "id_rsa"

 provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]}

 connection {
  type        = "ssh"
  agent       = false
  user        = "ubuntu"
  private_key = "${file("~/.ssh/id_rsa")}"
 }

 tags {
  Name = "Terraform"
 }
}

output "public_ip" {
    value = "${aws_instance.ec2.public_ip}"
}