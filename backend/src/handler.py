import json
import os

from decorators import is_admin


def user(event, context):
    return {
        "statusCode": 204,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": os.environ["FRONTEND_URL"],
        },
        "body": json.dumps({}),
    }


@is_admin
def admin(event, context):
    return {
        "statusCode": 200,
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Origin": os.environ["FRONTEND_URL"],
        },
        "body": json.dumps({"message": "Top-secret admin payload!"}),
    }
