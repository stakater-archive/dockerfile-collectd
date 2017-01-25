FROM stakater/base-alpine

MAINTAINER Ahmad Iqbal <ahmad@aurorasolutions.io>

RUN apk update && apk upgrade && \
    apk add collectd collectd-curl collectd-python \
    collectd-write_http py-pip

COPY docker-plugin/* /usr/lib/collectd/

RUN pip install --upgrade pip

RUN pip install -r /usr/lib/collectd/requirements.txt

COPY kairosdb-plugin/* /usr/lib/collectd/

ADD collectd.conf /etc/collectd/collectd.conf

RUN rm -f /etc/init/collectd.conf
RUN rm -f /etc/init.d/collectd

CMD exec collectd -f
