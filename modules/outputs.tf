output "blue_service_name" {
  value = aws_ecs_service.strapi_blue.name
}

output "green_service_name" {
  value = aws_ecs_service.strapi_green.name
}