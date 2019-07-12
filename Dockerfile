FROM debian:buster

RUN apt-get update \
    && apt-get install -y curl jq \
    && rm -rf /var/lib/apt/lists/*

COPY check /opt/resource/check
COPY in /opt/resource/in
COPY out /opt/resource/out

# execute the tests as part of the build
RUN cd ./test && ./test
