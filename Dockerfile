FROM nginx:alpine
RUN apk update
RUN /bin/sh -c "apk add --no-cache bash"
RUN apk add nodejs
RUN apk add npm
COPY . /src
RUN ["chmod", "+x", "/src/docker_startup.sh"]
RUN cd /src && npm install
COPY nginx.conf.template /etc/nginx/conf.d/default.conf
ENTRYPOINT []
CMD sed -i -e 's/NGINX_PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && /src/docker_startup.sh && nginx -g 'daemon off;'
