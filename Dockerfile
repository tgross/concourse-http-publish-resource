FROM debian:buster

RUN apt-get update \
    && apt-get install -y curl jq gettext \
    && rm -rf /var/lib/apt/lists/*

COPY check /opt/resource/check
COPY in /opt/resource/in
COPY out /opt/resource/out
COPY test /opt/resource/test

# execute the tests as part of the build
RUN cd /opt/resource/test && ./test
