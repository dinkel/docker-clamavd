FROM alpine:latest

MAINTAINER Ruggero <infiniteproject@gmail.com>

ENV MAX_SIZE 256M 

RUN apk add --update clamav && \
    rm -fr /var/cache/apk/* && \
    freshclam

RUN mv /etc/clamav/clamav.conf.sample /etc/clamav/clamav.conf
    mv /etc/clamav/freshclam.conf.sample /etc/clamav/freshclam.conf
    echo "StreamMaxLength $MAX_SIZE" >> /etc/clamav/clamd.conf
    echo "TCPSocket 3310" >> /etc/clamav/clamd.conf
    echo "Foreground true" >> /etc/clamav/clamd.conf
    echo "Foreground true" >> /etc/clamav/freshclam.conf

EXPOSE 3310
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
