FROM alpine:latest

MAINTAINER Ruggero <infiniteproject@gmail.com>

ENV MAX_SIZE 256M 

RUN apk add --update clamav-daemon

RUN wget -O /var/lib/clamav/main.cvd http://database.clamav.net/main.cvd && \
    wget -O /var/lib/clamav/daily.cvd http://database.clamav.net/daily.cvd && \
    wget -O /var/lib/clamav/bytecode.cvd http://database.clamav.net/bytecode.cvd && \
    chown clamav:clamav /var/lib/clamav/*.cvd

RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav

RUN sed -i "s/^Foreground .*$/Foreground true/g" /etc/clamd.conf && \
    sed -i "s/^StreamMaxLength .*$/StreamMaxLength $MAX_SIZE/g" /etc/clamd.conf && \
    sed -i "s/^Foreground .*$/Foreground true/g" /etc/freshclam.conf && \
    echo "TCPSocket 3310" >> /etc/clamd.conf

EXPOSE 3310
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
