FROM amazonlinux:2.0.20190228

RUN yum install -y gcc python3-devel.x86_64
RUN pip3 install awscli

RUN curl --silent --location https://rpm.nodesource.com/setup_12.x | bash -
RUN yum install -y nodejs
COPY package.json package-lock.json ./
RUN npm install

ADD ./ /frontend
WORKDIR /frontend
ENV PATH /node_modules/.bin:$PATH

EXPOSE 3000
