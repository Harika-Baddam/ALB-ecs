# modules/ecs_service/main.tf

resource "aws_ecs_service" "strapi_blue" {
  name                               = "strapi-blue-service"
  cluster                            = var.cluster_id
  task_definition                    = var.blue_task_def_arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.service_sg_id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = var.blue_tg_arn
    container_name   = "strapi"
    container_port   = 1337
  }
  depends_on = [aws_lb_target_group.blue]
}

resource "aws_ecs_service" "strapi_green" {
  name                               = "strapi-green-service"
  cluster                            = var.cluster_id
  task_definition                    = var.green_task_def_arn
  desired_count                      = 1
  launch_type                        = "FARGATE"
  platform_version                   = "LATEST"
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [var.service_sg_id]
    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = var.green_tg_arn
    container_name   = "strapi"
    container_port   = 1337
  }
  depends_on = [aws_lb_target_group.green]
}