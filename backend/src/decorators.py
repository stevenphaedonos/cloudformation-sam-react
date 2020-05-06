import functools
import json
from base64 import b64decode

# It is assumed that the token has already been validated by the API Gateway 
# Cognito authorizer
def get_claims(event):
    auth_token = event["headers"]["Authorization"]
    claims = auth_token.split(".")[1]
    decoded_claims = b64decode(claims)
    return json.loads(decoded_claims)


def is_admin(func):
    @functools.wraps(func)
    def wrapper(event, context):
        groups = get_claims(event).get("cognito:groups", [])
        if "admin" in groups:
            return func(event, context)

        return {
            "statusCode": 403,
            "body": json.dumps({"message": "Unauthorized"}),
        }

    return wrapper
