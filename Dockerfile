FROM ubuntu:latest
MAINTAINER YI-HUNG JEN <yihungjen@gmail.com>

# install stunnel
RUN apt-get update && apt-get install -y \
    curl \
    python \
    stunnel4

RUN curl -sSL https://bootstrap.pypa.io/get-pip.py | python -

RUN pip install awscli

RUN mkdir /trusted

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD [""]
