FROM alpine

MAINTAINER i@xudong.cc

ENV VERSION 0.25.3

RUN set -ex \
  && apk add --no-cache --virtual .build-deps \
    ca-certificates \
    openssl \
  && wget https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_amd64.tar.gz \
  && tar zxf frp_${VERSION}_linux_amd64.tar.gz \
  && mkdir /config \
  && cp frp_${VERSION}_linux_amd64/frps /usr/bin/frps \
  && cp frp_${VERSION}_linux_amd64/frpc /usr/bin/frpc \
  && cp frp_${VERSION}_linux_amd64/frps.ini /config/frps.ini \
  && cp frp_${VERSION}_linux_amd64/frpc.ini /config/frpc.ini \
  && rm -rf frp_${VERSION}_linux_amd64.tar.gz frp_${VERSION}_linux_amd64 \
  && apk del .build-deps

CMD ["/usr/bin/frps", "-c", "/config/frps.ini"]
# CMD ["/usr/bin/frpc", "-c", "/config/frpc.ini"]
