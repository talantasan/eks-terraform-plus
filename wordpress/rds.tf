resource "aws_db_instance" "wordpress" {
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