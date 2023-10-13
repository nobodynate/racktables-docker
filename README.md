# racktables-docker
a docker container to quickly build a new racktables environment. this is for development, not production.

# How To
## Download From dockerhub
```
docker run -it -p 80:80 -p 3306:3306 nobodynate/ubuntu-racktables
```

## Configure Racktables
Go to http://localhost:80/ in your browser and follow the install steps. This only needs to be completed on the first run of the container.
Change passwords, obviously...

## Done!
Congrats. Now have fun.
