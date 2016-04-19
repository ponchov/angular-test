#! /bin/bash

check="$(which apache2)"
apacheconf="/etc/apache2/sites-enabled/000-default.conf"
if [ ! -f $check ]; then
        apt-get install apache2 -y
fi


sed -i '/DocumentRoot \/var\/www\/html/d' $apacheconf || sed -i '/DocumentRoot \/var\/www\/html\/instant-search/d' $apacheconf
sed -i '12 a DocumentRoot \/var\/www\/html\/instant-search' $apacheconf

/etc/init.d/apache2 restart 2>1&
