FROM ubuntu
RUN apt-get -y update
RUN apt-get -y install nodejs
RUN apt-get -y install npm
RUN apt-get -y install nginx
RUN chmod 777 /etc/nginx/nginx.conf
COPY . /src
RUN cd /src && npm install
CMD ["/src/docker_startup.sh"]
