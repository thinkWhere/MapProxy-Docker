# Mapproxy Dockerfile

This will build a [docker](http://www.docker/) image that runs [mapproxy
](http://mapproxy.org).  

This recipe is adapted from the one provided by Tim Sutton  https://github.com/kartoza/docker-mapproxy

## Versions

Python 3.4
Mapproxy 1.9.0

## Getting the image

To build this image yourself you need to
clone this repo locally first. Then build using a local url instead of directly from
github.

```
git clone git://github.com/thinkwhere/mapproxy-docker
```
Then build using the command:

```
docker build -t thinkwhere/mapproxy .
```
or simply:
```
./build.sh
```

# Run

To run the mapproxy container do:

```
./run.sh
```

This will create and mount a "mapproxy" folder in your current working directory as a volume
in the container.  This is used to hold the config .yaml files.  Mounting this volume
allows you to create the config files without having to rebuild the image.

```
mkdir mapproxy
docker run --name "mapproxy" -p 8080:8080 -d -t -v \
   `pwd`/mapproxy:/mapproxy thinkwhere/mapproxy-docker
```

The first time your run the container, mapproxy basic default configuration
files will be written into ``./mapproxy``. You should read the mapproxy documentation
on how to configure these files and create appropriate service definitions for
your WMS services. Then restart the container to activate your changes.

The cached wms tiles will be written to ``./mapproxy/cache_data``.

**Note** that the mapproxy containerised application will run as the user that
owns the /mapproxy folder.

# Deployment using Reverse Proxy

The mapproxy container 'speaks' ``uwsgi`` so you need to put NGINX in front of it.
This can be achived using Docker Compose, a tool for defining and running multi-container
Docker applications.
A docker-compose file is included, which will start both the MapProxy container and
and an NGINX container together, with the appropriate ports exposed and links between
the two containers.

**Note** docker-compose ships with the Docker Toolbox for Win/Mac users. Linux users will
need to install [seperately](https://docs.docker.com/compose/install/).

To start the containers with Compose:

```
docker-compose up
```

In your browser navigate to:
```
http://localhost/demo
```
