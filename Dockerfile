FROM php:5.6-apache

MAINTAINER Katherine Lynch <katherly@upenn.edu>

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
        build-essential \
        ca-certificates \
        git-core \
        imagemagick \
        unzip \
        vim \
        zlib1g \
        zlib1g-dev && \
        docker-php-ext-install exif mbstring mysqli pdo pdo_mysql zip && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY files/php.ini.example /etc/php5/apache2/conf.d/php.ini

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

WORKDIR /var/www/html

RUN git clone --branch develop-2.3 --recursive https://github.com/tulibraries/Omeka_a11y.git .

RUN mkdir -p /var/www/html/plugins

RUN mkdir -p /var/www/html/files

ADD files/.htaccess.example /var/www/html/.htaccess

ADD files/db.ini.example /var/www/html/db.ini

ADD files/config.ini.example /var/www/html/application/config/config.ini

ADD files/info.php /var/www/html/info.php

COPY plugins/CSV-Import-2.0.3.zip /var/www/html/plugins/

COPY plugins/Dublin-Core-Extended-2.0.1.zip /var/www/html/plugins/

COPY plugins/OAI-PMH-Repository-2.0.zip /var/www/html/plugins/

WORKDIR /var/www/html/plugins

RUN unzip -q CSV-Import-2.0.3.zip

RUN unzip -q Dublin-Core-Extended-2.0.1.zip

RUN unzip -q OAI-PMH-Repository-2.0.zip

WORKDIR /var/www/html

RUN chmod -R 755 files

RUN chmod -R 640 db.ini

RUN chown www-data:www-data files

RUN chown www-data:www-data db.ini

RUN chown www-data:www-data application/config/config.ini

RUN a2enmod rewrite && service apache2 restart
