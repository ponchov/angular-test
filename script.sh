#! /bin/bash

check="$(pgrep apache2| head -n1)"
apacheconf="/etc/apache2/sites-enabled/000-default.conf"
if ["$check" == ""]; then
        apt-get install apache2 -y
fi

sed -i '/DocumentRoot \/var\/www\/html/d' $apacheconf || sed -i '/DocumentRoot \/var\/www\/html\/instant-search/d' $apacheconf
sed -i '12 a DocumentRoot \/var\/www\/html\/instant-search' /etc/apache2/sites-enabled/000-default.conf

/etc/init.d/apache2 restart 2>1&
