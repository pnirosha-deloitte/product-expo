resource "aws_codedeploy_app" "terraform_codedeploy" {
  compute_platform = "Lambda"
  name             = "terraform-codedeploy"
}

//DEPLOYMENT GROUP......................................
resource "aws_codedeploy_deployment_group" "terraform_deployment_group" {
  app_name              = aws_codedeploy_app.terraform_codedeploy.name
  deployment_group_name = "terraform_deployment_group-group"
  service_role_arn      = aws_iam_role.servicerole-codebuild.arn
  deployment_config_name = "CodeDeployDefault.LambdaAllAtOnce"


  deployment_style {
    deployment_option = "WITH_TRAFFIC_CONTROL"
    deployment_type   = "BLUE_GREEN"
  }
}




