FROM java:openjdk-8-jre-alpine
#FROM openjdk:8-jdk

MAINTAINER bookkeeper community 

ARG BK_VERSION=4.4.0
ARG DISTRO_NAME=bookkeeper-server-${BK_VERSION}-bin
ARG ZK_VERSION=3.5.2-alpha

RUN set -x \
&& apk add --no-cache  \
        gnupg \
        wget  \
        bash  \
        python python-dev \
&& mkdir -pv /opt \
&& cd /opt \
&& wget -q "https://archive.apache.org/dist/bookkeeper/bookkeeper-${BK_VERSION}/${DISTRO_NAME}.tar.gz" \
&& tar -xzf "$DISTRO_NAME.tar.gz" \
&& rm -rf "$DISTRO_NAME.tar.gz" \
&& mv bookkeeper-server-${BK_VERSION}/ /opt/bookkeeper/ \
&& wget -q http://www.apache.org/dist/zookeeper/zookeeper-${ZK_VERSION}/zookeeper-${ZK_VERSION}.tar.gz \
&& tar -xzf  zookeeper-${ZK_VERSION}.tar.gz \
&& mv zookeeper-${ZK_VERSION}/ /opt/zk/

ENV BOOKIE_PORT 3181

EXPOSE $BOOKIE_PORT

WORKDIR /opt/bookkeeper

COPY apply-config-from-env.py /opt/bookkeeper
COPY entrypoint.sh /opt/bookkeeper/entrypoint.sh
ENTRYPOINT ["/opt/bookkeeper/entrypoint.sh"]
