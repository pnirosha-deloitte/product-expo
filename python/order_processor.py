import boto3
import os
import random
import json

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('Terraform_DYNAMODB_ORDERS_TABLE')

def lambda_handler(event, context):

    try:
        for record in event['Records']:
            body = json.loads(record["body"])
            print(body)

            order_number = body['order_number']
            num_items = body['num_items']
            price_per_item = body['price_per_item']
            item_description = body['item_description']

            if not type(price_per_item) is float:
                raise TypeError("Only floating point values are allowed")

            response = table.put_item(
                Item={
                    "id": order_number,
                    "order_details": json.dumps({
                        "num_items": num_items,
                        "price_per_item": price_per_item,
                        "item_description": item_description
                    })
                }
            )
            print(response)

    except Exception as e:
        # Send to Lambda Logs in CloudWatch
        print(e)
        # Throw exception, so that message becomes visible again in the orders-queue.
        raise e