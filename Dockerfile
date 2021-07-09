FROM ubuntu
RUN apt-get -y update
RUN apt-get -y install nodejs
COPY . /src
RUN cd /src && npm install
EXPOSE ${PORT:-4000}
CMD ["node", "/src/server.js"]
