FROM ubuntu

# Install requirements
RUN apt-get -yq install \
  unzip \
  curl \
  haproxy \
  && apt-get clean

# Enable haproxy
RUN sed -i -e 's/ENABLED=0/ENABLED=1/' /etc/default/haproxy

# Install consul and consul-template
RUN curl -L -O https://dl.bintray.com/mitchellh/consul/0.5.2_linux_amd64.zip \
  && unzip 0.5.2_linux_amd64.zip \
  && mv consul /usr/local/bin/consul \
  && rm 0.5.2_linux_amd64.zip

RUN curl -L -O https://dl.bintray.com/mitchellh/consul/0.5.2_web_ui.zip \
  && unzip 0.5.2_web_ui.zip \
  && rm 0.5.2_web_ui.zip

RUN curl -L -O https://releases.hashicorp.com/consul-template/0.11.1/consul-template_0.11.1_linux_amd64.zip \
  && unzip consul-template_0.11.1_linux_amd64.zip \
  && mv consul-template /usr/local/bin/consul-template \
  && rm consul-template_0.11.1_linux_amd64.zip

# Add entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

# Enable remote syslog
RUN sed -i -e 's/#$ModLoad imudp/$ModLoad imudp/' /etc/rsyslog.conf
RUN sed -i -e 's/#$UDPServerRun 514/$UDPServerRun 514/' /etc/rsyslog.conf

# Add haproxy config template
COPY haproxy.ctmpl /etc/haproxy/haproxy.ctmpl

EXPOSE 8300 8500 
CMD ["/entrypoint.sh"]

