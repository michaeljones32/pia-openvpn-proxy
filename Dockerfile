FROM docker.io/alpine:latest

RUN apk --no-cache add ca-certificates \
    && apk --no-cache add privoxy \
    && apk --no-cache add openvpn \
    && apk --no-cache add runit \
    && apk --no-cache add curl \
    && apk --no-cache add unzip \
    && apk --no-cache add wireguard-tools \
    && apk --no-cache add jq \
    && apk --no-cache add sudo \
    && apk --no-cache add coreutils

COPY app /app
COPY etc /etc

RUN find /app -name "run" -exec chmod u+x {} \;

ENV VPN_PROTOCOL="openvpn" \
    REGION="" \
    USERNAME="" \
    PASSWORD="" \
    UID="" \
    GID="" \
    LOCAL_NETWORK=192.168.1.0/24

EXPOSE 8118
VOLUME /config

CMD ["runsvdir", "/app"]