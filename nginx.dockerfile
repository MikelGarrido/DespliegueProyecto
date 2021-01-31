FROM nginx:1.10-alpine

ADD ./nginx.conf /etc/nginx/conf.d/default.conf

COPY ./ /var/www/public