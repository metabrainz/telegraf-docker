FROM metabrainz/consul-template-base

MAINTAINER Laurent Monin <zas@metabrainz.org>
RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://dl.influxdata.com/telegraf/releases/telegraf-1.0.1_linux_amd64.tar.gz -O telegraf.tar.gz && tar xvzf telegraf.tar.gz --strip-components=2 -C / && mkdir -p /etc/telegraf/telegraf.d
RUN rm -f /core /telegraf.tar.gz

ENV INFLUX_SERVER "http://localhost:8086"
ENV INFLUX_DB "telegraf-docker"
ENV DC "testing"
ENV HOST "telegraf-docker"

COPY files/telegraf/telegraf.conf /etc/telegraf/
COPY files/telegraf/telegraf.d /etc/telegraf/telegraf.d
COPY files/run_telegraf.sh /etc/service/telegraf/run

VOLUME [ "/etc/telegraf" ]

ENTRYPOINT ["/sbin/my_init"]
