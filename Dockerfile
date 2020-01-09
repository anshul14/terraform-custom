FROM alpine:latest
MAINTAINER "The Packer Team <packer@hashicorp.com>"

ARG JENKINS_USER="10011"
ARG JENKINS_USERNAME="cicduser"

ENV PACKER_VERSION=1.5.0
ENV PACKER_SHA256SUM=6cffd17ee02767fe6533c1fde61b59437bb1e2f5c922d977f739be20dae6bf4a

RUN apk add --update git bash wget openssl

ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip ./
ADD https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_SHA256SUMS ./

RUN sed -i '/.*linux_amd64.zip/!d' packer_${PACKER_VERSION}_SHA256SUMS
RUN sha256sum -cs packer_${PACKER_VERSION}_SHA256SUMS
RUN unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /bin
RUN rm -f packer_${PACKER_VERSION}_linux_amd64.zip

ENV http_proxy=http://nonprod.inetgw.aa.com:9093/ \
  https_proxy=http://nonprod.inetgw.aa.com:9093/ \
  no_proxy="artifacts.aa.com, nexusread.aa.com"


ENTRYPOINT ["/bin/packer"]