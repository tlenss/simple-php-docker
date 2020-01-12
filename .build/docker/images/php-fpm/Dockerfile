FROM php:7.4-fpm AS fpm-74-dev

ADD www.conf /usr/local/etc/php-fpm.d/www.conf

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

FROM php:7.3-fpm AS fpm-73-dev

ADD www.conf /usr/local/etc/php-fpm.d/www.conf

RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

FROM php:7.3-fpm AS fpm-73-prod

ADD www.conf /usr/local/etc/php-fpm.d/www.conf

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

# add application files