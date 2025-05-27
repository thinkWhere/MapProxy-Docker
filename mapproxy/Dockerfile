FROM python:3.13-slim-bookworm

RUN apt-get update && apt-get install --no-install-recommends -y \
  dos2unix \
  python3-yaml \
  python3-pil \
  python3-pyproj \
  python3-lxml \
  python3-dev \
  python3-shapely \
  libgeos-dev \
  libgdal-dev \
  build-essential \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

#  
#  libjpeg-dev \
#  zlib1g-dev \
#  libfreetype6-dev \
#  python-virtualenv \

RUN pip install --upgrade pip
RUN pip install Shapely Pillow MapProxy==3.1.0 requests geojson pg8000 uwsgi werkzeug
RUN pip install --pre schematics

ADD uwsgi.ini /uwsgi.ini
RUN chmod 0755 /uwsgi.ini
ADD start.sh /start.sh
RUN dos2unix /start.sh
RUN chmod 0755 /start.sh

# Temp fix for coverages until next version of MapProxy available
#COPY geom.py /usr/local/lib/python3.7/site-packages/mapproxy/util/geom.py

#USER www-data
# Now launch mappproxy in the foreground
# The script will create a simple config in /mapproxy
# if one does not exist. Typically you should mount
# /mapproxy as a volume
CMD /start.sh
