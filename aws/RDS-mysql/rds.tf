provider "aws" {
  region = var.region
}
# Get VPC ID using Name Tag
data "aws_vpcs" "eksvpc" {
  tags = {
    Name = "blueplanet-vpc-testeast"
  }
}
output "vpcid" {
  value = join(",", data.aws_vpcs.eksvpc.ids)
}
# Get EKS CIDR using Name Tag
data "aws_vpc" "ekscidr" {
  tags = {
    Name = "blueplanet-vpc-testeast"
  }
}
output "vpc_cidr" {
  value = "${data.aws_vpc.ekscidr.cidr_block}"
}
# Create a SG group for RDS
resource "aws_security_group" "eks-env-db" {
  name        = "eks-env-db"
  description = "Connect DB to EKS Applications"
  vpc_id      = join(",", data.aws_vpcs.eksvpc.ids)
  ingress {
    description = "EKS VPC to MySQL"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.ekscidr.cidr_block}"]
  }
  ingress {
    description = "EKS VPC to PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${data.aws_vpc.ekscidr.cidr_block}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "eks-env-db"
    Env = var.env
  }
}
# Get Public Subnets-1 of EKS Cluster
data "aws_subnet" "publicsubnet1" {
  tags = {
    Name = "blueplanet-testeast-public-subnets-1"
  }
}
output "publicsubnet1" {
  value = data.aws_subnet.publicsubnet1.id
}
# Get public subnet-2 of EKS cluster
data "aws_subnet" "publicsubnet2" {
  tags = {
    Name = "blueplanet-testeast-public-subnets-2"
  }
}
output "publicsubnet2" {
  value = data.aws_subnet.publicsubnet2.id
}
# Create subnet group
resource "aws_db_subnet_group" "public_rds" {
  name       = "testeast-public-subnets"
  subnet_ids = [data.aws_subnet.publicsubnet1.id, data.aws_subnet.publicsubnet2.id]
  tags = {
    Name = "public_rds"
    Env = var.env
  }
}
# Get Private Subnets-1 of EKS Cluster
data "aws_subnet" "privatesubnet1" {
  tags = {
    Name = "blueplanet-testeast-private-subnets-1"
  }
}
output "privatesubnet1" {
  value = data.aws_subnet.privatesubnet1.id
}
# Get private subnet-2 of EKS cluster
data "aws_subnet" "privatesubnet2" {
  tags = {
    Name = "blueplanet-testeast-private-subnets-2"
  }
}
output "privatesubnet2" {
  value = data.aws_subnet.privatesubnet2.id
}
# Create subnet group
resource "aws_db_subnet_group" "private_rds" {
  name       = "testeast-private-subnets"
  subnet_ids = [data.aws_subnet.privatesubnet1.id, data.aws_subnet.privatesubnet2.id]
  tags = {
    Name = "private_rds"
    Env = var.env
  }
}

# Create parametergroup and assign to MYSQL on this VPC

resource "aws_db_parameter_group" "mysqlparam" {
  name   = "blueplanet-testeast-mysql5-7permissive"
  family = "mysql5.7"

  parameter {
    name  = "log_bin_trust_function_creators"
    value = "1"
  }

  parameter {
    name  = "event_scheduler"
    value = "ON"
  }

  parameter {
    name = "sql_mode"
    value = "NO_ENGINE_SUBSTITUTION"
  }

  parameter {
    name = "max_connections"
    value = "{DBInstanceClassMemory/12582880}"
  }
}

# create options group and assign to MYSQL on this VPC
resource "aws_db_option_group" "mysqloptiongroup" {
  name                     = "blueplanet-testeast-mysql5-7audit"
  option_group_description = "Enable Audit plugin for mysql db"
  engine_name              = "mysql"
  major_engine_version     = "5.7"

  option {
    option_name = "MARIADB_AUDIT_PLUGIN"

    option_settings {
      name = "SERVER_AUDIT_EVENTS"
      value = "CONNECT,QUERY"
    }

    option_settings {
      name = "SERVER_AUDIT_QUERY_LOG_LIMIT"
      value = "1024"
    }

  }

}

# Create RDS instance
resource "aws_db_instance" "rds" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.mysqlengine
  engine_version       = var.mysqlengineversion
  instance_class       = var.instance_class
  name                 = var.env
  username             = var.mysqlusername
  password             = var.password
  identifier           = var.mysqdbidentifier
  parameter_group_name = aws_db_parameter_group.mysqlparam.name
  publicly_accessible  = var.pubaccessible
  final_snapshot_identifier = var.finalsnapidentifier
  max_allocated_storage = var.maxallocatedstorage
  multi_az = var.multiaz
  backup_retention_period = var.bkpretentionperiod
  monitoring_interval = var.monitoringinterval
  deletion_protection = var.deleteontermination
  ca_cert_identifier = var.cacertidentifier
  maintenance_window = var.maintenacewindow
  backup_window = var.backupwindow
  kms_key_id = var.defaultkmskey
  storage_encrypted = var.storageencrypted
  monitoring_role_arn = var.monitoringrolearn
  option_group_name = aws_db_option_group.mysqloptiongroup.name
  vpc_security_group_ids = [aws_security_group.eks-env-db.id]
  db_subnet_group_name = aws_db_subnet_group.private_rds.id
  enabled_cloudwatch_logs_exports = ["audit"]
  tags = {
    Name = var.mysqdbidentifier
    Env = var.env
  }
}
output "rds_endpoint" {
  value = aws_db_instance.rds.endpoint
}
# Create postgresSQL
resource "aws_db_instance" "postgres" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  engine               = var.postgresengine
  engine_version       = var.postgresengineversion
  instance_class       = var.instance_class
  name                 = var.env
  username             = var.postgresusername
  password             = var.password
  identifier           = var.postgresdbidentifier
  parameter_group_name = var.postgresgroupname
  backup_retention_period = var.bkpretentionperiod
  publicly_accessible  = var.pubaccessible
  final_snapshot_identifier = var.finalsnapidentifier
  max_allocated_storage = var.maxallocatedstorage
  multi_az = var.multiaz
  kms_key_id = var.defaultkmskey
  storage_encrypted = var.storageencrypted
  monitoring_interval = var.monitoringinterval
  deletion_protection = var.deleteontermination
  ca_cert_identifier = var.cacertidentifier
  maintenance_window = var.maintenacewindow
  backup_window = var.backupwindow
  monitoring_role_arn = var.monitoringrolearn
  option_group_name = var.optiongrouppostgres
  vpc_security_group_ids = [aws_security_group.eks-env-db.id]
  db_subnet_group_name = aws_db_subnet_group.private_rds.id
  enabled_cloudwatch_logs_exports = ["postgresql","upgrade"]
  tags = {
    Name = var.postgresdbidentifier
    Env = var.env
  }
}
output "postgres_endpoint" {
  value = aws_db_instance.postgres.endpoint
}
