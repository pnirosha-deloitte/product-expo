///creating SQS queue...................................................................................................................

resource "aws_sqs_queue" "terraform_queue" {
  name                      = "terraform-standard-queue"
  delay_seconds             = 0
#   max_message_size          = 256
#   message_retention_seconds = 86400
  receive_wait_time_seconds = 0
  sqs_managed_sse_enabled = true
  redrive_policy = jsonencode({
        deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
        maxReceiveCount     = 1
  })
  tags = {
    Environment = "production"
  }
}

/////Dead-Letter QUEUE......................................................................................................

resource "aws_sqs_queue" "terraform_queue_deadletter" {
  name = "terraform-deadletter-queue"
}
//Adding Lambda Trigger to SQS...................................................................................................
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  batch_size        = 1
  event_source_arn  = "${aws_sqs_queue.terraform_queue.arn}"
  enabled           = true
  function_name     = "${aws_lambda_function.Terraform_order_processor.arn}"
}