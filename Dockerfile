FROM alpine:edge
LABEL maintainer "infiniteproject@gmail.com"

ENV MAX_SIZE 256M 

RUN apk add --update \
        bash \
        clamav \
        clamav-libunrar && \
    rm -fr /var/cache/apk/*

RUN mkdir /run/clamav && chown clamav:clamav /run/clamav && freshclam && \
    echo "StreamMaxLength $MAX_SIZE" >> /etc/clamav/clamd.conf && \
    echo "TCPSocket 3310" >> /etc/clamav/clamd.conf && \
    echo "Foreground true" >> /etc/clamav/clamd.conf && \
    echo "Foreground true" >> /etc/clamav/freshclam.conf

COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3310
CMD ["/entrypoint.sh"]
