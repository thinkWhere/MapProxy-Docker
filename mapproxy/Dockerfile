FROM python:3.7-slim-buster

RUN apt-get update && apt-get install --no-install-recommends -y \
  python-yaml \
  libgeos-dev \
  python-lxml \
  libgdal-dev \
  build-essential \
  python-dev \
  libjpeg-dev \
  zlib1g-dev \
  libfreetype6-dev \
  python-virtualenv \
  && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install Shapely Pillow MapProxy==1.11.0 uwsgi requests geojson
RUN pip install --pre schematics

ADD uwsgi.ini /uwsgi.ini
RUN chmod 0755 /uwsgi.ini
ADD start.sh /start.sh
RUN chmod 0755 /start.sh
# Temp fix for coverages until next version of MapProxy available
COPY geom.py /usr/local/lib/python3.4/site-packages/mapproxy/util/geom.py

#USER www-data
# Now launch mappproxy in the foreground
# The script will create a simple config in /mapproxy
# if one does not exist. Typically you should mount
# /mapproxy as a volume
CMD /start.sh