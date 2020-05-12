FROM amazonlinux:2.0.20190228

RUN yum install -y gcc python3-devel.x86_64 jq
RUN pip3 install awscli==1.18.57

RUN curl --silent --location https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y nodejs
COPY package.json package-lock.json ./
RUN npm install

ADD ./ /frontend
WORKDIR /frontend
ENV PATH /node_modules/.bin:$PATH

EXPOSE 3000
