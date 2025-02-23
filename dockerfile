FROM alpine:3.18

LABEL maintainer="by the developer"

WORKDIR /app

# update alpine

RUN apk update

# Verify if lighttpd, the web server for alpine linux system is running

RUN lighttpd --version || echo "lighttpd not found, proceed to installation"

# Install lighttpd

RUN apk add --no-cache lighttpd

# check the version of lighttpd installed and find the default location for lighttpd config file

RUN lighttpd -V && find / -name lighttpd.conf

# run system update and upgrade

RUN apk update && apk upgrade

# copy the html text file under the directory html

COPY ./html/* /var/www/html

# copy the lighttpd config file under the config directory

COPY ./config/* /etc/lighttpd

# expose container on port 80

EXPOSE 80

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]



