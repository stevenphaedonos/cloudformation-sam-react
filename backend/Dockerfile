FROM amazonlinux:2.0.20190228

RUN yum install -y gcc python3-devel.x86_64

COPY requirements.txt ./
RUN pip3 install -r requirements.txt

ADD ./ /backend
WORKDIR /backend

EXPOSE 5000
