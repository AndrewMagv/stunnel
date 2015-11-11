FROM ubuntu:latest
MAINTAINER YI-HUNG JEN <yihungjen@gmail.com>

# install stunnel
RUN apt-get update && apt-get install -y \
    curl \
    python \
    stunnel4

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | python -
RUN pip install awscli

COPY entrypoint.sh /entrypoint.sh
COPY proxy.conf /proxy.conf

ENV REF master

ENTRYPOINT ["/entrypoint.sh"]
