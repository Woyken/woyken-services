# Messing with hosting multiple services in single heroku dyno

**Warning! This is not a "good" approach.**

[Docker documentation says](https://docs.docker.com/config/containers/multi-service_container/): "Avoid one container being responsible for multiple aspects of your overall application"

## So this is my attempt

To host multiple servers in single heroku dyno in docker container.

Running Nginx as reverse proxy to redirect requests to different servers - 2 node server instances running in separate processes.

1st server

<https://woyken-service.herokuapp.com/api1>

2nd server

<https://woyken-service.herokuapp.com/api2>
