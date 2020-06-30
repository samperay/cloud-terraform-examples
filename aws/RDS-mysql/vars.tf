variable "region" {
  default = "us-east-1"
}
# vairables for MYSQL
variable "mysqdbidentifier" {
  default = "blueplanet-testeast-mysql"
}
variable "mysqlengine" {
  default = "mysql"
}
variable "mysqlengineversion" {
  default = "5.7"
}
variable "mysqlusername" {
  default = "admin"
}

# variables for Postgres
variable "postgresdbidentifier" {
  default = "blueplanet-testeast-postgres"
}
variable "postgresengine" {
  default = "postgres"
}
variable "postgresengineversion" {
  default = "11.6"
}
variable "postgresgroupname" {
  default = "postgres11-5audit"
}
variable "postgresusername" {
  default = "postgres"
}
variable "optiongrouppostgres" {
  default = "default:postgres-11"
}

# Variables common on DB
variable "allocated_storage" {
  default = 50
}
variable "storage_type" {
  default = "gp2"
}
variable "instance_class" {
  default = "db.m5.xlarge"
}
variable "password" {
  default = "4HVuGTDCr9ajQm6p"
}
variable "pubaccessible" {
  default = false
}
variable "bkpretentionperiod" {
  default = 7
}
variable "finalsnapidentifier" {
  default = "true"
}
variable "maxallocatedstorage" {
  default = 1000
}
variable "multiaz" {
  default = false
}
variable "defaultkmskey" {
  default = "arn:aws:kms:us-east-1:906862171241:key/b27137e4-5bca-4155-9539-e75318a7040a"
}
variable "monitoringrolearn" {
  default = "arn:aws:iam::906862171241:role/rds-monitoring-role"
}
variable "monitoringinterval" {
  default = 60
}
variable "cacertidentifier" {
  default = "rds-ca-2019"
}
variable "maintenacewindow" {
  default = "sun:03:18-sun:03:48"
}
variable "backupwindow" {
  default = "05:22-05:52"
}
variable "deleteontermination" {
  default = false
}
variable "storageencrypted"{
  default = true
}
# variables on tags
variable "env" {
  default = "testeast"
}
