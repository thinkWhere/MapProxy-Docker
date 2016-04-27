# Mapproxy Dockerfile

This will build a [docker](http://www.docker/) image that runs [mapproxy
](http://mapproxy.org).  

This recipe is adapted from the one provided by Tim Sutton  https://github.com/kartoza/docker-mapproxy

## Versions

Python 3.4
Mapproxy 1.8.2

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

The repository also includes a ``utils`` folder containing a sample nginx.conf file, and a docker-compose.yml file (not completed)

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

# Reverse proxy

The mapproxy container 'speaks' ``uwsgi`` so you need to put nginx in front of it
(try the ``nginx docker container``). The utils directory in this repo contains a sample nginx configuration 
that will forward traffic into the uwsgi container, adding the appropriate headers as needed.

The nginx container can then be started up using a docker command similar to the following:

```
docker run \
	--name=nginxproxy \
	-p 80:80 \
	-p 443:443 \
	-d \
	--link=mapproxy \
	nginx
```

In the above example I have a linked container to my nginx container called 'mapproxy'
which is the dns name used in the mapproxy run command.

Once the service is up and running you can connect to the default demo
mapproxy page by pointing your browser at the URL below.

```
http://localhost:8080/demo
```
