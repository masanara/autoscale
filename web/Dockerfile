FROM ubuntu

RUN apt-get -y install \
  nginx \
  unzip \
  curl \
  && apt-get clean

RUN curl -L -O https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip \
  && unzip 0.5.2_linux_amd64.zip \
  && mv consul /usr/local/bin/consul \
  && rm 0.5.2_linux_amd64.zip

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
COPY index.html /usr/share/nginx/html/index.html
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

EXPOSE 80 443
CMD ["/entrypoint.sh"]
