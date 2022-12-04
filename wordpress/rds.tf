data "aws_vpc" "eks_vpc" {
    
}
resource "aws_db_instance" "default" {
  allocated_storage    = 10
  db_name              = var.var_db_name
  engine               = "mysql"
  engine_version       = var.var_engine_version
  instance_class       = var.var_instance_class
  username             = "admin"
  password             = "talanttest122"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}

variable "var_db_name" {
    default = "wordpressdb"
}
variable "var_engine_version" {
    default = "db.t3.micro"
}

# Security group for RDS
resource "aws_security_group" "RDS_allow_rule" {
  vpc_id = aws_vpc.prod-vpc.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.ec2_allow_rule.id}"]
  }
  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow cluster nodes"
  }

}



