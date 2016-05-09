#!/bin/bash
docker kill mapproxy
docker rm mapproxy
mkdir mapproxy
chmod a+wX mapproxy
docker run --name="mapproxy" -v `pwd`/mapproxy:/mapproxy:/mapproxy -p 8080:8080 -d -t thinkwhere/mapproxy
#docker run --name="mapproxy" -v `pwd`/mapproxy:/mapproxy -p 8090:8080 -i -t thinkwhere/mapproxy /bin/bash
docker logs mapproxy
