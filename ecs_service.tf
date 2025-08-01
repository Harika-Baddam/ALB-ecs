resource "aws_ecs_service" "strapi_service" {
  name                               = "strapi-service"
  cluster                            = aws_ecs_cluster.strapi_cluster.id
  task_definition                    = aws_ecs_task_definition.strapi_td.arn
  launch_type                        = "FARGATE"
  desired_count                      = 0 # Managed by CodeDeploy

  deployment_controller {
    type = "CODE_DEPLOY"
  }

  network_configuration {
    subnets         = var.private_subnets
    security_groups = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.blue_tg.arn
    container_name   = "strapi"
    container_port   = 1337
  }
}
