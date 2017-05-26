FROM java:openjdk-8-jre-alpine

MAINTAINER bookkeeper community 

RUN apk add --no-cache wget bash \
&& mkdir -p /opt/dl_all \
&& wget -q https://github.com/twitter/distributedlog/releases/download/0.3.51-RC1/distributedlog-service-3ff9e33fa577f50eebb8ee971ddb265c971c3717.zip \
&& unzip distributedlog-service-3ff9e33fa577f50eebb8ee971ddb265c971c3717.zip \
&& mv distributedlog-service /opt/dl_all/

ENV BOOKIE_PORT 3181

EXPOSE $BOOKIE_PORT

# DL contains twitter version contains bookkeeper bins, after bk4.5.0 will use apache version.
WORKDIR /opt/dl_all

COPY /entrypoint.sh /opt/dl_all/entrypoint.sh
ENTRYPOINT /opt/dl_all/entrypoint.sh

