FROM alpine:3.9.5 AS core
RUN apk --update add \
    bash \
    jq \
    && rm -rf /var/cache/apk/*
RUN mkdir /opt/resource
ADD resource/* /opt/resource/

FROM core AS test
RUN apk add \
    make \
    ncurses
ADD Makefile /opt/
ADD test/* /opt/test/
WORKDIR /opt
ENV TERM=dumb
RUN make test

FROM core as release