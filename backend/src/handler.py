import json
import os

from decorators import is_admin


def user(event, context):
    return {
        "statusCode": 204,
        "body": {},
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": os.environ["FRONTEND_URL"],
        },
    }


@is_admin
def admin(event, context):
    return {
        "statusCode": 200,
        "body": json.dumps({"data": "Top-secret admin payload!"}),
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": os.environ["FRONTEND_URL"],
        },
    }
