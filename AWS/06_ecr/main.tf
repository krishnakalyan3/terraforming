
provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "credentials"
  profile                 = "krishna"
}

resource "aws_security_group" "ak-sg" {
  name        = "ak-open"
  description = "Allow all inbound traffic"
  vpc_id = "${aws_vpc.ak-vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc" "ak-vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "ak-subnet" {
  vpc_id     = "${aws_vpc.ak-vpc.id}"
  cidr_block = "10.0.1.0/16"

}

resource "aws_ecr_repository" "ak-ecr" {
  name = "ak-iot-spark"
}

resource "aws_ecs_cluster" "ak-ecs" {
  name = "ak-ecs-cluster"
}

resource "aws_ecs_service" "ak-ecs-service" {
  name            = "ak-ecs-service"
  cluster         = "${aws_ecs_cluster.ak-ecs.id}"
  task_definition = "arn:aws:ecs:us-east-1:803222300826:task-definition/spark:2"
  desired_count   = 1
  launch_type     = "FARGATE"
  scheduling_strategy = "REPLICA"

  network_configuration  {
    subnets = ["${aws_subnet.ak-subnet.id}"]
    security_groups = ["${aws_security_group.ak-sg.id}"]
    assign_public_ip = true
  }
}
