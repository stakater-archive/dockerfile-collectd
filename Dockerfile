FROM stakater/base:0.9.16

MAINTAINER Ahmad Iqbal <ahmad@aurorasolutions.io>

RUN apt-get update && \
      apt-get install collectd --no-install-recommends -y && \
      apt-get install -y python-pip && \
      apt-get install wget libpython2.7-dev -y

COPY docker-plugin/* /usr/lib/collectd/

RUN pip install -r /usr/lib/collectd/requirements.txt

COPY kairosdb-plugin/* /usr/lib/collectd/

ADD collectd.conf /etc/collectd/collectd.conf

RUN service collectd stop
RUN rm -f /etc/init/collectd.conf
RUN rm -f /etc/init.d/collectd

ADD run.sh /usr/local/sbin/run_collectd.sh
ENTRYPOINT ["/usr/local/sbin/run_collectd.sh"]
