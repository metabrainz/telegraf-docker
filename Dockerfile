FROM metabrainz/consul-template-base:ct_0.33.0-jammy-1.0.1-v0.4-1

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN rm -f /core

ENV TELEGRAF_DEB=telegraf_1.32.3-1_amd64.deb
RUN wget https://dl.influxdata.com/telegraf/releases/${TELEGRAF_DEB} && dpkg -i ${TELEGRAF_DEB} && rm -f ${TELEGRAF_DEB}

ENV INFLUX_SERVER="http://localhost:8086"
ENV INFLUX_DB="telegraf-docker"
ENV DC="testing"
ENV HOST="telegraf-docker"

RUN mkdir -p /etc/telegraf/telegraf.d
COPY files/telegraf/telegraf.conf /etc/telegraf/
COPY files/telegraf/telegraf.d /etc/telegraf/telegraf.d
COPY files/run_telegraf.sh /etc/service/telegraf/run

VOLUME [ "/etc/telegraf" ]

ENTRYPOINT ["/sbin/my_init"]
