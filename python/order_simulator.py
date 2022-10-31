import boto3
import os
import random
import json

sqs = boto3.client('sqs')
orders_queue_url = 'https://sqs.us-east-2.amazonaws.com/203978866841/terraform-standard-queue'
orders_count = 2 # count of orders to be simulated

def lambda_handler(event, context):
    for x in range(orders_count):
        order = {
                    "order_number": event['order_number'],
                    "num_items": event['num_items'],
                    "price_per_item": event['price_per_item'],
                    "item_description": event['item_description']
                }

        # Send message to SQS queue
        response = sqs.send_message(
            QueueUrl = orders_queue_url,
            MessageBody = json.dumps(order)
        )
        print(response)
    return "SUCCESSFULLY TESTED"