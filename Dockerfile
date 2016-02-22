FROM httpd:2.4
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./start /usr/local/apache2/
RUN useradd -u 1001 -r -g 0 -d /usr/local/apache2/ -s /sbin/nologin \
      -c "Default Application User" default \
    && rm -Rf /usr/local/apache2/run \
    && rm -Rf /usr/local/apache2/logs \
    && mkdir -p /usr/local/apache2/run \
    && mkdir -p /usr/local/apache2/logs \
    && chown -R 1001:0 /usr/local/apache2 \
#    && chown -R 1001:0 /var/www \
    && chmod -R a+wrx /usr/local/apache2/ \
#    && chmod -R a+wrx /var/www

#CMD ["/usr/local/apache2/start"]

EXPOSE 8080

WORKDIR /usr/local/apache2/

USER 1001