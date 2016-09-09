FROM armbuild/dockerfile-java
MAINTAINER Srounet <srounet@gmail.com>

ENV ELASTICSEARCH_VERSION=2.4.0
ENV ES_OPTIONS="-Des.network.host=0.0.0.0"

# Upgrade packages
RUN apt-get -q update && apt-get --force-yes -y -qq upgrade

# System essentials
RUN apt-get -qq -y install build-essential wget

# Install ES
RUN cd /tmp \
  && wget -q https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/deb/elasticsearch/${ELASTICSEARCH_VERSION}/elasticsearch-${ELASTICSEARCH_VERSION}.deb \
  && dpkg -i elasticsearch-${ELASTICSEARCH_VERSION}.deb

# Prepare folders
WORKDIR /usr/share/elasticsearch
RUN mkdir -p /var/run/elasticsearch && chown -R elasticsearch:elasticsearch /var/run/elasticsearch
RUN set -ex && for path in data logs config config/scripts; do \
        mkdir -p "$path"; \
    done
RUN chown -R elasticsearch:elasticsearch /usr/share/elasticsearch

EXPOSE 9200
EXPOSE 9300

USER elasticsearch

CMD /usr/share/elasticsearch/bin/elasticsearch -p /var/run/elasticsearch/elasticsearch.pid $ES_OPTIONS --default.path.home=/usr/share/elasticsearch --default.path.logs=/var/log/elasticsearch --default.path.data=/var/lib/elasticsearch --default.path.conf=/etc/elasticsearch
