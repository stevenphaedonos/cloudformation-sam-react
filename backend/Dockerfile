FROM amazonlinux:2.0.20190228

RUN yum install -y gcc python3-devel.x86_64 jq
RUN pip3 install awscli==1.18.57 aws-sam-cli==0.48.0

COPY src/requirements.txt ./
# In order to be included in the Lambda layer, the dependencies
# must be placed in the specific folder "/python"
# Refer to https://docs.aws.amazon.com/lambda/latest/dg/configuration-layers.html#configuration-layers-path
RUN pip3 install --target=/dependencies/python -r requirements.txt

ADD ./ /backend
WORKDIR /backend

EXPOSE 5000
