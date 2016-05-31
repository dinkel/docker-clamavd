FROM alpine:edge

MAINTAINER Ruggero <infiniteproject@gmail.com>

ENV MAX_SIZE 256M 

RUN apk add --update clamav clamav-libunrar && rm -fr /var/cache/apk/*

RUN mkdir /var/run/clamav && \
    mv /etc/clamav/clamd.conf.sample /etc/clamav/clamd.conf && \
    mv /etc/clamav/freshclam.conf.sample /etc/clamav/freshclam.conf && \
    echo "StreamMaxLength $MAX_SIZE" >> /etc/clamav/clamd.conf && \
    echo "TCPSocket 3310" >> /etc/clamav/clamd.conf && \
    echo "Foreground true" >> /etc/clamav/clamd.conf && \
    echo "Foreground true" >> /etc/clamav/freshclam.conf && \
    freshclam

EXPOSE 3310
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
