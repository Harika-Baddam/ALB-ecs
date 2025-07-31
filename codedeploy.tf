resource "aws_codedeploy_app" "strapi" {
  name              = "strapi-app"
  compute_platform  = "ECS"
}