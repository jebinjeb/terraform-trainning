terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.61.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}

variable "ami_key_pair_name" {
  default = "deployer_key"
}

resource "aws_instance" "Docker_instance" {
  ami                    = "ami-074cce78125f09d61"
  instance_type          = "t3.micro"
  key_name               = var.ami_key_pair_name
  vpc_security_group_ids = [aws_security_group.main.id]
}

resource "aws_key_pair" "deployer" {
  key_name   = var.ami_key_pair_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDI2Apd8tmeF+9oTUjFsnVqXz7ZT63JIiqL47CBq13FQifHoZsb7ipDkuBtVNurrUUFyVHj0Mrysro/Ti5s2M9zy5mLMcWWivn4VpLajczJm9xAGpOHlWLu+SkzL0Il689w/bIP0x3M6O+Q8D0vMGZuM4gc3oNU09mO86UuMeeitWO0Pn2zRxJGxm9hL6t0jOywqkBegRdxB3RstUnoXKytxkDwauC80fcsHvlJGPjxkhUIKiZkNfHJV+xVFLeHA92vreQKEAmjpULtfFcDqKmGqneo5QAzY5W9esBeBA2lCnXv+5Donq8zshT5FgsC2ueXg5ld1tYLh4gMTwspnuKx jency@jebin-Vostro-3480"
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 1064
    }
  ]
}

