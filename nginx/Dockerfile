FROM nginx:stable-alpine

ARG HOST_NAME=${APP_NAME}_php
ENV HOST_NAME=$HOST_NAME

COPY ./api/public /var/www/api/public
COPY ./nginx/nginx.conf /etc/nginx/templates/default.conf.template
