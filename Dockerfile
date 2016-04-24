FROM ubuntu:15.10

ENV DUMB_INIT_VER=1.0.1 \
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/qnib/consul/bin/
RUN apt-get install -y wget \
 && wget -qO /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VER}/dumb-init_${DUMB_INIT_VER}_amd64 \
 && chmod +x /usr/local/bin/dumb-init \
 && wget -qO /usr/local/bin/entrypoint.sh https://raw.githubusercontent.com/qnib/init-plain/master/bin/entrypoint.sh \
 && chmod +x /usr/local/bin/entrypoint.sh \
 && wget --no-cache -qO /usr/local/bin/entrypoint.sh https://raw.githubusercontent.com/qnib/init-plain/master/bin/entrypoint.sh \
 && chmod +x /usr/local/bin/entrypoint.sh \
 && apt-get purge -y wget ca-certificates libidn11 openssl \
 && rm -rf /var/lib/apt/lists/*
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
