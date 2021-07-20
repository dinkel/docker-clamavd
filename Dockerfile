FROM debian:buster

MAINTAINER Christian Luginbühl <dinkel@pimprecords.com>

ENV CLAMAV_VERSION 0.103

RUN echo "deb http://http.debian.net/debian/ buster main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://http.debian.net/debian/ buster-updates main contrib non-free" >> /etc/apt/sources.list && \
    echo "deb http://security.debian.org/ buster/updates main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
        clamav-daemon=${CLAMAV_VERSION}* \
        clamav-freshclam=${CLAMAV_VERSION}* \
        libclamunrar \
        ca-certificates \
        wget && \
    update-ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN freshclam && \
    chown clamav:clamav /var/lib/clamav/*.cvd

RUN mkdir /var/run/clamav && \
    chown clamav:clamav /var/run/clamav && \
    chmod 750 /var/run/clamav

ADD run.sh /

RUN sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/clamd.conf && \
    echo "TCPSocket 3310" >> /etc/clamav/clamd.conf && \
    sed -i 's/^Foreground .*$/Foreground true/g' /etc/clamav/freshclam.conf && \
    chmod +x run.sh

EXPOSE 3310

CMD ["/run.sh"]