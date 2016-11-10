# docker image with telegraf

## Env. variables

* `HOST`: host tag
* `DC`: dc tag
* `INFLUX_SERVER`: url of influxdb server
* `INFLUX_DB`: database to use


## Build

```
docker build -t telegraf-metabrainz .
```

## Run

```
docker volume create --name mytelegrafconf
```

```
docker run -d --name telegraf-metabrainz -e NAME=test -e INFLUX_SERVER=http://your.influx:8086 -e INFLUX_DB=testing -v mytelegrafconf:/etc/telegraf telegraf-metabrainz
```

## Monitoring

```
docker logs -f telegraf-metabrainz
```
