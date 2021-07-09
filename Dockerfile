FROM ubuntu
RUN apt-get -y update
RUN apt-get -y install nodejs
RUN apt-get -y install npm
RUN apt-get -y install nginx
RUN chmod 777 /etc/nginx/nginx.conf
RUN chmod 777 /usr/sbin/nginx
COPY . /src
RUN cd /src && npm install
COPY nginx.conf.template /etc/nginx/conf.d/default.conf
CMD sed -i -e 's/NGINX_PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && /src/docker_startup.sh && nginx -g 'daemon off;'
