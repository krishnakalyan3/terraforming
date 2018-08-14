# Terrafrom Scripts

SNo.| Topic
--- | ---
1 | Launch EC2 and SSH
2 | Remote Execution
3 | Security Groups, VPC
4 | Spot P3 Instance


resource "aws_security_group" "sg" {
  name        = "terraform_sg"

  # SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP access from the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
 
### Learning Resources
- [Terraform: Up and Running](https://books.google.de/books?id=ZH1VDgAAQBAJ)