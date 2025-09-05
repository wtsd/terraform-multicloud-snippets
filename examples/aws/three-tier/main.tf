terraform {
  required_version = ">= 1.5.0"
  required_providers { aws = { source = "hashicorp/aws", version = "~> 5.0" } }
}
provider "aws" {}
module "vpc" {
  source     = "../../../modules/aws/vpc"
  name       = var.name
  cidr_block = var.cidr_block
  az_count   = 2
  enable_nat = true
  tags       = { Project = var.name }
}
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter { name = "name", values = ["al2023-ami-*-x86_64"] }
}
resource "aws_security_group" "alb" {
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-alb-sg"
  ingress { from_port=80 to_port=80 protocol="tcp" cidr_blocks=["0.0.0.0/0"] }
  egress  { from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"] }
}
resource "aws_lb" "alb" {
  name               = "${var.name}-alb"
  load_balancer_type = "application"
  subnets            = module.vpc.public_subnet_ids
  security_groups    = [aws_security_group.alb.id]
}
resource "aws_lb_target_group" "tg" {
  name     = "${var.name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id
  health_check { path = "/" }
}
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port = 80
  protocol = "HTTP"
  default_action { type = "forward", target_group_arn = aws_lb_target_group.tg.arn }
}
resource "aws_security_group" "app" {
  vpc_id = module.vpc.vpc_id
  name   = "${var.name}-app-sg"
  ingress { from_port = 80, to_port = 80, protocol = "tcp", security_groups = [aws_security_group.alb.id] }
  egress  { from_port=0 to_port=0 protocol="-1" cidr_blocks=["0.0.0.0/0"] }
}
resource "aws_launch_template" "lt" {
  name_prefix   = "${var.name}-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  user_data = base64encode(<<-EOT
    #!/bin/bash
    yum install -y httpd
    echo "<h1>${var.name} app tier</h1>" > /var/www/html/index.html
    systemctl enable httpd && systemctl start httpd
  EOT
  )
  vpc_security_group_ids = [aws_security_group.app.id]
}
resource "aws_autoscaling_group" "asg" {
  name                      = "${var.name}-asg"
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 2
  vpc_zone_identifier       = module.vpc.private_subnet_ids
  health_check_type         = "EC2"
  launch_template { id = aws_launch_template.lt.id, version = "$Latest" }
  target_group_arns = [aws_lb_target_group.tg.arn]
  lifecycle { create_before_destroy = true }
}
resource "aws_db_subnet_group" "db" {
  name       = "${var.name}-db-subnets"
  subnet_ids = module.vpc.private_subnet_ids
}
resource "aws_db_instance" "db" {
  identifier              = "${var.name}-db"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  username                = var.db_username
  password                = var.db_password
  allocated_storage       = 20
  skip_final_snapshot     = true
  db_subnet_group_name    = aws_db_subnet_group.db.name
  publicly_accessible     = false
}
