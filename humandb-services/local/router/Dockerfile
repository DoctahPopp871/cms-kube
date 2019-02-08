FROM alpine:3.1

RUN apk add --update nginx && mkdir /tmp/nginx && rm -rf /var/cache/apk/* && mkdir -p /var/www

COPY ./nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]