from . settings import *

#Production
REST_FRAMEWORK = {
    'DEFAULT_RENDERER_CLASSES' : (
        'rest_framework.renderers.JSONRenderer',
    )
}

STATIC_ROOT="/proyecto_api/static"
STATIC_URL = '/static/'
DEBUG=False

ALLOWED_HOSTS = ['*']
USE_X_FORWARDED_HOST=True
USE_X_FORWARDED_PORT=True

CORS_ORIGIN_ALLOW_ALL = True