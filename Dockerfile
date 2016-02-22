FROM httpd:2.4

COPY ./httpd.conf /etc/httpd/conf/
COPY ./start /etc/httpd/

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

EXPOSE 8080

WORKDIR /etc/httpd

USER 1001