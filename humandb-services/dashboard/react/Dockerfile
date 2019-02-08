FROM node:9-alpine as builder

# Create the working dir and copy app files
RUN mkdir -p /var/www && mkdir /cache
WORKDIR /var/www
COPY . /var/www

# Do not use cache when we change node dependencies in package.json
ADD package.json yarn.lock /cache/

# Update OS, Install packages, Prepare cache file, Build
RUN apk --no-cache add ca-certificates wget git python alpine-sdk libusb-dev yarn && update-ca-certificates \
  && cd /cache \
  && yarn config set cache-folder /usr/local/share/.cache/yarn \
  && yarn \
  && yarn global add forever jest \
  && cd /var/www && ln -s /cache/node_modules node_modules \
  && tar czf /.yarn-cache.tgz /usr/local/share/.cache/yarn \
  && NODE_PATH=src/ yarn run build

FROM alpine:3.1

RUN apk add --update nginx && mkdir /tmp/nginx && rm -rf /var/cache/apk/* && mkdir -p /var/www

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./mime.types /etc/nginx/mime.types
COPY --from=builder /var/www/build /var/www/humandb

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]