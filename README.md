# Elasticsearch 2.4 on docker for armhf
This docker image is build on top of **[armbuild/dockerfile-java](https://hub.docker.com/r/armbuild/dockerfile-java/)** from Online.net/scaleway. Is has been used and tested over scaleway EC1 instances so it may not work on other arm services such as raspberry or other devices, anyway give it a try and let met know.

```sh
Elasticsearch version: 2.4
Configuration file: /etc/elasticsearch/elasticsearch.yml
Pid: /var/run/elasticsearch/elasticsearch.pid 
default.path.home=/usr/share/elasticsearch
default.path.logs=/var/log/elasticsearch
default.path.data=/var/lib/elasticsearch
default.path.conf=/etc/elasticsearch
```

If you want to use a custom config file (you probabply would) use docker's **-v** options and point your custom **elasticsearch.yml** to **/etc/elasticsearch/elasticsearch.yml**.

### Build 

From source (git clone...)
```sh
docker build -t armhf/elasticsearch .
```

From docker hub
```sh
docker build -t armhf/elasticsearch nopz/armhf-elasticsearch
```

### Run

With default options (binds 0.0.0.0)
```sh
docker run -d -p 9300:9300 -p 9200:9200 --name es_1 armhf/elasticsearch
```

With custom options
```sh
docker run -d -p 9300:9300 -p 9200:9200 -e ES_OPTIONS="-Des.network.host=127.0.0.1" --name es_1 armhf/elasticsearch
```

