FROM        stakater/base-alpine

MAINTAINER  Ahmad Iqbal <ahmad@aurorasolutions.io>

RUN         apk update && apk upgrade && \
            apk add collectd collectd-curl collectd-python \
            collectd-write_http py-pip

COPY        kairosdb-plugin/kairosdb_writer.py  /usr/lib/collectd/
COPY        docker-plugin/dockerplugin.py       /usr/lib/collectd/
COPY        docker-plugin/dockerplugin.db       /usr/share/collectd/
COPY        docker-plugin/requirements.txt      /usr/share/collectd/dockerplugin-requirements.txt

RUN         pip install --upgrade pip && \
            pip install -r /usr/share/collectd/dockerplugin-requirements.txt

ADD         collectd.conf /etc/collectd/collectd.conf

RUN         rm -f /etc/init/collectd.conf && \
            rm -f /etc/init.d/collectd

CMD         exec collectd -f
