FROM golang:alpine

RUN apk add --update git bash openssl
RUN go get github.com/mitchellh/gox
RUN go get github.com/hashicorp/packer

WORKDIR $GOPATH/src/github.com/hashicorp/packer

RUN /bin/bash scripts/build.sh

WORKDIR $GOPATH

RUN apk update
RUN apk add python3 py-pip jq gcc python3-dev musl-dev libffi-dev build-base make openssl-dev
RUN pip3 install --upgrade awscli
RUN pip3 install --upgrade pip
RUN pip3 install --upgrade ansible
RUN pip3 install cryptography==2.4.2