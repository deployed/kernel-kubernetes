from .settings import *
from . import env

SECRET_KEY = env.str('DJANGO_SECRET_KEY')

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': env.str('POSTGRES_DB'),
        'USER': env.str('POSTGRES_USER'),
        'HOST': env.str('POSTGRES_HOST'),
        'PASSWORD': env.str('POSTGRES_PASSWORD'),
        'PORT': env.int('POSTGRES_PORT', 5432),
    }
}

CSRF_TRUSTED_ORIGINS = env.list("CSRF_TRUSTED_ORIGINS")

ALLOWED_HOSTS = env.list('ALLOWED_HOSTS')
