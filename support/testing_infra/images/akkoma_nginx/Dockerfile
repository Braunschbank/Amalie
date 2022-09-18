FROM nginx:stable-alpine

ENV DOMAIN_NAME="localhost"

RUN apk update && apk add openssl &&\
    mkdir /etc/nginx/ssl/ &&\
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -subj "/C=FR/O=Amalie/OU=Domain Control Validated/CN=$DOMAIN_NAME" -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt &&\
    apk del openssl

