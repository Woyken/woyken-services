FROM nginx:alpine
RUN apk update
RUN /bin/sh -c "apk add --no-cache bash"
RUN apk add nodejs
RUN apk add npm
COPY . /src
COPY nginx.conf.template /etc/nginx/conf.d/default.conf
RUN ["chmod", "+x", "/src/docker_setup.sh"]
RUN /src/docker_setup.sh
RUN ["chmod", "+x", "/src/docker_startup.sh"]
ENTRYPOINT []
CMD sed -i -e 's/NGINX_PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && /src/docker_startup.sh && nginx -g 'daemon off;'
