# resource "aws_sns_topic" "terraform_notif" {
#   # name = "product-expo-stagefailure-notification"
#   count =  1
#   name = aws_sns_topic.terraform_notif == "product-expo-stagefailure-notification" ? 1 : 0
# }
# # resource "aws_sns_topic_subscription" "sns-topic" {
# # #   provider  = "aws.sns2codepipeline"
# #   topic_arn = aws_sns_topic.terraform_notif.arn
# #   protocol  = "email"
# #   endpoint  = "nirosha@deloitte.com"
# # }
# data "aws_iam_policy_document" "notif_access" {
#   statement {
#     actions = ["sns:Publish"]
#     principals {
#       type        = "Service"
#       identifiers = ["codestar-notifications.amazonaws.com"]
#     }
#     resources = aws_sns_topic.terraform_notif == "product-expo-stagefailure-notification" ? 1 : 0
#     # resources = [aws_sns_topic.terraform_notif.arn]
#   }
# }
# resource "aws_sns_topic_policy" "default" {
#   arn    = aws_sns_topic.terraform_notif.arn
#   policy = data.aws_iam_policy_document.notif_access.json
# }
# resource "aws_codestarnotifications_notification_rule" "terraform-codepipeline-failure-notif" {
#   count =  0
#   name = aws_codestarnotifications_notification_rule.terraform-codepipeline-failure-notif == "notifs_for_failures" ? 1 : 0
#   detail_type    = "BASIC"
#   event_type_ids = ["codepipeline-pipeline-action-execution-failed", 
#                     "codepipeline-pipeline-stage-execution-failed", 
#                     "codepipeline-pipeline-pipeline-execution-failed"]
#   # name     = "notifs_for_failures"
#   resource = aws_codepipeline.terraform-codepipeline.arn
#   target {
#     address = "arn:aws:sns:us-east-2:203978866841:product-expo-stagefailure-notification:18227274-f940-4fef-a1ab-c454fad4306b"
#   }
# }resource "aws_sns_topic" "terraform_notif" {
#   # name = "product-expo-stagefailure-notification"
#   count =  1
#   name = aws_sns_topic.terraform_notif == "product-expo-stagefailure-notification" ? 1 : 0
# }
# # resource "aws_sns_topic_subscription" "sns-topic" {
# # #   provider  = "aws.sns2codepipeline"
# #   topic_arn = aws_sns_topic.terraform_notif.arn
# #   protocol  = "email"
# #   endpoint  = "nirosha@deloitte.com"
# # }
# data "aws_iam_policy_document" "notif_access" {
#   statement {
#     actions = ["sns:Publish"]
#     principals {
#       type        = "Service"
#       identifiers = ["codestar-notifications.amazonaws.com"]
#     }
#     resources = aws_sns_topic.terraform_notif == "product-expo-stagefailure-notification" ? 1 : 0
#     # resources = [aws_sns_topic.terraform_notif.arn]
#   }
# }
# resource "aws_sns_topic_policy" "default" {
#   arn    = aws_sns_topic.terraform_notif.arn
#   policy = data.aws_iam_policy_document.notif_access.json
# }
# resource "aws_codestarnotifications_notification_rule" "terraform-codepipeline-failure-notif" {
#   count =  0
#   name = aws_codestarnotifications_notification_rule.terraform-codepipeline-failure-notif == "notifs_for_failures" ? 1 : 0
#   detail_type    = "BASIC"
#   event_type_ids = ["codepipeline-pipeline-action-execution-failed", 
#                     "codepipeline-pipeline-stage-execution-failed", 
#                     "codepipeline-pipeline-pipeline-execution-failed"]
#   # name     = "notifs_for_failures"
#   resource = aws_codepipeline.terraform-codepipeline.arn
#   target {
#     address = "arn:aws:sns:us-east-2:203978866841:product-expo-stagefailure-notification:18227274-f940-4fef-a1ab-c454fad4306b"
#   }
# }

# resource "aws_sns_topic_subscription" "sns-topic" {
# #   provider  = "aws.sns2codepipeline"
#   topic_arn = aws_sns_topic.terraform_notif.arn
#   protocol  = "email"
#   endpoint  = "nirosha@deloitte.com"
# }
# data "aws_iam_policy_document" "notif_access" {
#   statement {
#     actions = ["sns:Publish"]
#     principals {
#       type        = "Service"
#       identifiers = ["codestar-notifications.amazonaws.com"]
#     }
#     resources = [aws_sns_topic.notif.arn]
#   }
# }
# resource "aws_sns_topic_policy" "default" {
#   arn    = aws_sns_topic.notif.arn
#   policy = data.aws_iam_policy_document.notif_access.json
# }
# resource "aws_codestarnotifications_notification_rule" "terraform-codepipeline-failure-notif" {
#   detail_type    = "BASIC"
#   event_type_ids = ["codepipeline-pipeline-action-execution-failed", 
#                     "codepipeline-pipeline-stage-execution-failed", 
#                     "codepipeline-pipeline-pipeline-execution-failed"]
#   name     = "notifs_for_failures"
#   resource = aws_codepipeline.terraform-codepipeline.arn
#   target {
#     address = "arn:aws:sns:us-east-2:203978866841:product-expo-stagefailure-notification:18227274-f940-4fef-a1ab-c454fad4306b"
#   }
# }
























# resource "aws_sns_topic" "terraform_notif" {  
#   name = "product-expo-stagefailure-notification"
# }

# data "aws_iam_policy_document" "notif_access" {
#    statement {
#      actions = ["sns:Publish"]

#      principals {
#        type        = "Service"
#        identifiers = ["codestar-notifications.amazonaws.com"]
#      }

#      resources = [aws_sns_topic.terraform_notif.arn]
#    }
#  }
#  resource "aws_sns_topic_policy" "default" {
#    arn    = aws_sns_topic.terraform_notif.arn
#    policy = data.aws_iam_policy_document.notif_access.json
#  }

# resource "aws_codestarnotifications_notification_rule" "terraform-codepipeline-failure-notif" {
#   detail_type    = "BASIC"
#   event_type_ids = ["codepipeline-pipeline-action-execution-failed", 
#   "codepipeline-pipeline-stage-execution-failed", 
#   "codepipeline-pipeline-pipeline-execution-failed"]

#   name     = "notifs_for_failures"
#   resource = aws_codepipeline.terraform-codepipeline.arn

#   target {
#     address = "arn:aws:sns:us-east-2:203978866841:product-expo-stagefailure-notification"
#   }
# }
# resource "aws_sns_topic_subscription" "sns-topic" {
#   #provider  = aws.sns2codepipeline
#   topic_arn = aws_sns_topic.terraform_notif.arn
#   protocol  = "email"
#   endpoint  = "pnirosha@deloitte.com"
# }


# resource "aws_sns_topic_subscription" "sns-topic" {
# #   provider  = "aws.sns2codepipeline"
#   topic_arn = aws_sns_topic.terraform_notif.arn
#   protocol  = "email"
#   endpoint  = "nirosha@deloitte.com"
# }
# data "aws_iam_policy_document" "notif_access" {
#   statement {
#     actions = ["sns:Publish"]
#     principals {
#       type        = "Service"
#       identifiers = ["codestar-notifications.amazonaws.com"]
#     }
#     resources = [aws_sns_topic.notif.arn]
#   }
# }
# resource "aws_sns_topic_policy" "default" {
#   arn    = aws_sns_topic.notif.arn
#   policy = data.aws_iam_policy_document.notif_access.json
# }
# resource "aws_codestarnotifications_notification_rule" "terraform-codepipeline-failure-notif" {
#   detail_type    = "BASIC"
#   event_type_ids = ["codepipeline-pipeline-action-execution-failed", 
#                     "codepipeline-pipeline-stage-execution-failed", 
#                     "codepipeline-pipeline-pipeline-execution-failed"]
#   name     = "notifs_for_failures"
#   resource = aws_codepipeline.terraform-codepipeline.arn
#   target {
#     address = "arn:aws:sns:us-east-2:203978866841:product-expo-stagefailure-notification:18227274-f940-4fef-a1ab-c454fad4306b"
#   }
# }
























# resource "aws_sns_topic" "terraform_notif" {  
#   name = "product-expo-stagefailure-notification"
# }

# data "aws_iam_policy_document" "notif_access" {
#    statement {
#      actions = ["sns:Publish"]

#      principals {
#        type        = "Service"
#        identifiers = ["codestar-notifications.amazonaws.com"]
#      }

#      resources = [aws_sns_topic.terraform_notif.arn]
#    }
#  }
#  resource "aws_sns_topic_policy" "default" {
#    arn    = aws_sns_topic.terraform_notif.arn
#    policy = data.aws_iam_policy_document.notif_access.json
#  }

# resource "aws_codestarnotifications_notification_rule" "terraform-codepipeline-failure-notif" {
#   detail_type    = "BASIC"
#   event_type_ids = ["codepipeline-pipeline-action-execution-failed", 
#   "codepipeline-pipeline-stage-execution-failed", 
#   "codepipeline-pipeline-pipeline-execution-failed"]

#   name     = "notifs_for_failures"
#   resource = aws_codepipeline.terraform-codepipeline.arn

#   target {
#     address = "arn:aws:sns:us-east-2:203978866841:product-expo-stagefailure-notification"
#   }
# }
# resource "aws_sns_topic_subscription" "sns-topic" {
#   #provider  = aws.sns2codepipeline
#   topic_arn = aws_sns_topic.terraform_notif.arn
#   protocol  = "email"
#   endpoint  = "pnirosha@deloitte.com"
# }
