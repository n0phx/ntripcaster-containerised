FROM ubuntu:18.04 as builder

COPY ntripcaster /ntripcaster

WORKDIR /ntripcaster

RUN apt-get update && apt-get install build-essential --assume-yes

RUN ./configure

RUN make install

RUN mkdir -p /usr/local/ntripcaster/conf/

RUN rm -rf /usr/local/ntripcaster/conf/*

FROM ubuntu:18.04

COPY --from=builder /usr/local/ntripcaster/ /usr/local/ntripcaster/

EXPOSE 2101

WORKDIR /usr/local/ntripcaster/logs

VOLUME /usr/local/ntripcaster/conf/

CMD /usr/local/ntripcaster/bin/ntripcaster
