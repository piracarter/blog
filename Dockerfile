FROM registry.access.redhat.com/rhel7 

MAINTAINER Jesus Arriola <piracarter@gmail.com>
ENV HEXO_SERVER_PORT=4000

ENV PATH="$PATH:/opt/rh/rh-nodejs6/root/usr/bin"

WORKDIR /app/
ADD blog /app

RUN yum -y update && yum clean all && rm -rf /var/cache/yum && yum repolist --disablerepo=* && yum-config-manager --enable rhel-7-server-rpms && yum-config-manager --enable rhel-server-rhscl-7-rpms && yum -y install rh-nodejs6 rh-nodejs6-npm; yum clean all
RUN chgrp -R 0 /app && chmod -R g=u /app && ldconfig /opt/rh/rh-nodejs6/root/usr/lib64/ && npm install -g hexo hexo-cli

USER 1001

EXPOSE ${HEXO_SERVER_PORT}
CMD hexo server -i 0.0.0.0
