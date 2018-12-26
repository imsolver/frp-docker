FROM alpine

MAINTAINER i@xudong.cc

ENV FRP_VERSION 0.22.0

RUN set -ex \
	&& apk add --no-cache --virtual .build-deps \
		ca-certificates \
		openssl \
	&& wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && tar zxf frp_${FRP_VERSION}_linux_amd64.tar.gz \
    && mv frp_${FRP_VERSION}_linux_amd64 /var/frp \
    && cd /var/frp \
    && mkdir config \
    && cp frps.ini config/frps.ini \
    && cp frpc.ini config/frpc.ini \
    && apk del .build-deps

WORKDIR /var/frp

CMD ["./frps", "-c", "config/frps.ini"]
