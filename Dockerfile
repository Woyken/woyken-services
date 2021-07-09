FROM node:10
COPY . /src
RUN cd /src && npm install
EXPOSE ${PORT:-4000}
CMD ["node", "/src/server.js"]
