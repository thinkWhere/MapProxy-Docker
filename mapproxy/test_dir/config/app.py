import logging
import os
import socket
from logging.config import fileConfig
#from mapproxy.wsgiapp import make_wsgi_app
from mapproxy.multiapp import make_wsgi_app


class MapCloudMiddleware(object):
    def __init__(self, app):  # global_conf
        self.app = app

    def __call__(self, environ, start_response):
        environ['SCRIPT_NAME'] = ''
        return self.app(environ, start_response)


def initialise_mapproxy_logging():
    """
    Initialise the MapProxy logger. Sharing this logger makes for easier debugging.
    :return: Log instance
    """
    # Create logs dir
    if not os.path.exists('logs'):
        os.makedirs('logs')

    fileConfig('log.ini', {"host": socket.gethostname()})
    logger = logging.getLogger()
    logger.info('MAPCLOUD: Logging initialised successfully')

# Init logging
initialise_mapproxy_logging()

logger = logging.getLogger()

#application = make_wsgi_app("mapproxy-ros.yaml", reloader=True)
application = make_wsgi_app("/mapproxy/config/", allow_listing=True)
application = MapCloudMiddleware(application)
