FROM rhel7.2

MAINTAINER andrei_filimonov@optum.com 

ENV HTTP_PORT=8080 \
    HTTPS_PORT=8443


RUN rpm -Uvh http://satcapctc01.uhc.com/pub/katello-ca-consumer-latest.noarch.rpm \
    && subscription-manager register --org="Optum" --activationkey="RHEL 7 x86_64 MS DEV" \
    && yum -y install httpd \
    && yum install -y --setopt=tsflags=nodocs \
        autoconf \
        automake \
        bsdtar \
        epel-release \
        findutils \
        gcc-c++ \
        gdb \
        gettext \
        git \
        libcurl-devel \
        libxml2-devel \
        libxslt-devel \
        lsof \
        make \
        mariadb-devel \
        mariadb-libs \
        openssl-devel \
        patch \
        postgresql-devel \
        procps-ng \
        scl-utils \
        sqlite-devel \
        tar \
        unzip \
        wget \
        which \
        yum-utils \
        zlib-devel \
    && yum clean all -y

ADD httpd.conf /etc/httpd/conf/
ADD start /etc/httpd/

RUN useradd -u 1001 -r -g 0 -d /etc/httpd -s /sbin/nologin \
      -c "Default Application User" default \
    && rm -Rf /etc/httpd/run \
    && rm -Rf /etc/httpd/logs \
    && mkdir -p /etc/httpd/run \
    && mkdir -p /etc/httpd/logs \
    && chown -R 1001:0 /etc/httpd \
    && chown -R 1001:0 /var/www \
    && chmod -R a+wrx /etc/httpd \
    && chmod -R a+wrx /var/www

CMD ["/etc/httpd/start"]

EXPOSE $HTTP_PORT

WORKDIR /etc/httpd

USER 1001