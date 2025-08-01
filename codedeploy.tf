resource "aws_codedeploy_app" "strapi_app" {
  name = "StrapiCodeDeployApp"
  compute_platform = "ECS"
}

resource "aws_codedeploy_deployment_group" "strapi_dg" {
  app_name              = aws_codedeploy_app.strapi_app.name
  deployment_group_name = "StrapiDeploymentGroup"
  service_role_arn      = var.codedeploy_service_role

  deployment_config_name = "CodeDeployDefault.ECSCanary10Percent5Minutes" # or "CodeDeployDefault.ECSAllAtOnce"

  ecs_service {
    cluster_name = aws_ecs_cluster.strapi_cluster.name
    service_name = aws_ecs_service.strapi_service.name
  }

  load_balancer_info {
    target_group_pair_info {
      prod_traffic_route {
        listener_arns = [aws_lb_listener.alb_listener.arn]
      }

      target_group {
        name = aws_lb_target_group.blue_tg.name
      }

      target_group {
        name = aws_lb_target_group.green_tg.name
      }
    }
  }

  auto_rollback_configuration {
    enabled = true
    events  = ["DEPLOYMENT_FAILURE"]
  }

  deployment_style {
    deployment_type   = "BLUE_GREEN"
    deployment_option = "WITH_TRAFFIC_CONTROL"
  }

  blue_green_deployment_config {
    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }
}
