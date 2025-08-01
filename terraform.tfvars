vpc_id           = "vpc-xxxxxxxxxxxxxxxxx"
public_subnets   = ["subnet-aaaaaa", "subnet-bbbbbb"]
private_subnets  = ["subnet-cccccc", "subnet-dddddd"]
image            = "123456789012.dkr.ecr.ap-south-1.amazonaws.com/strapi-app:latest"
codedeploy_service_role = "arn:aws:iam::123456789012:role/CodeDeployServiceRole"
