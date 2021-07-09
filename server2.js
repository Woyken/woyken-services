var http = require('http')

const port = 4001;

var server = http.createServer(function (request, response) {
  response.writeHead(200, {'Content-Type': 'text/plain'})
  response.end('Hello World from totally different server\n')
})

server.listen(port)

console.log('Another server running at http://localhost:' + port)
