FROM ubuntu 
EXPOSE 80

RUN apt-get update -y && apt-get install -y net-tools supervisor apache2

RUN mkdir -p /var/www/html/order-form
ADD  order-form /var/www/html/order-form
RUN chown -R www-data:www-data /var/www/html

RUN sed  -i "1i ServerName $(ifconfig | grep "inet addr" | awk '{print $2}' | head -n 1 | cut -d: -f2)" /etc/apache2/apache2.conf
RUN sed -i '/DocumentRoot \/var\/www\/html/d' /etc/apache2/sites-enabled/000-default.conf || sed -i '/DocumentRoot \/var\/www\/html\/instant-search/d' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i '12 a DocumentRoot \/var\/www\/html\/instant-search' /etc/apache2/sites-enabled/000-default.conf

COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]
