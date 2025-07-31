variable "vpc_id" {}
variable "public_subnet_ids" {
  type = list(string)
}
variable "alb_security_group_id" {}
variable "cluster_id" {}
variable "blue_task_def_arn" {}
variable "green_task_def_arn" {}
variable "private_subnet_ids" {
  type = list(string)
}
variable "service_sg_id" {}
variable "blue_tg_arn" {}
variable "green_tg_arn" {}