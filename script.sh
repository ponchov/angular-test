#! /bin/bash

check=$(pgrep apache2| head -n1)

if ["$check" == ""]; then
        apt install apache2 -y
        /etc/init.d/apache2 start 2>1&
fi

sed -i "s/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/instant-search/g" /etc/apache2/sites-enabled/000-default.conf
/etc/init.d/apache2 restart 2>1&
