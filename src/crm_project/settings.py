"""
Django settings for crm_project.
"""

import os
from pathlib import Path


# Ścieżka bazowa projektu
BASE_DIR = Path(__file__).resolve().parent.parent


# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "django-insecure-ZMIEN-TEN-KLUCZ-PRZED-PRODUKCJA-1234567890"


# Development
DEBUG = True

ALLOWED_HOSTS = ["*"]


# --- APLIKACJE ---

INSTALLED_APPS = [
    "django.contrib.admin",
    "django.contrib.auth",
    "django.contrib.contenttypes",
    "django.contrib.sessions",
    "django.contrib.messages",
    "django.contrib.staticfiles",

    # CRM
    "crm",
]


# --- MIDDLEWARE ---

MIDDLEWARE = [
    "django.middleware.security.SecurityMiddleware",
    "django.contrib.sessions.middleware.SessionMiddleware",
    "django.middleware.common.CommonMiddleware",
    "django.middleware.csrf.CsrfViewMiddleware",
    "django.contrib.auth.middleware.AuthenticationMiddleware",
    "django.contrib.messages.middleware.MessageMiddleware",
    "django.middleware.clickjacking.XFrameOptionsMiddleware",
]


ROOT_URLCONF = "crm_project.urls"


# --- SZABLONY ---

TEMPLATES = [
    {
        "BACKEND": "django.template.backends.django.DjangoTemplates",
        "DIRS": [
            BASE_DIR / "templates"
        ],
        "APP_DIRS": True,
        "OPTIONS": {
            "context_processors": [
                "django.template.context_processors.debug",
                "django.template.context_processors.request",
                "django.contrib.auth.context_processors.auth",
                "django.contrib.messages.context_processors.messages",
            ],
        },
    },
]


WSGI_APPLICATION = "crm_project.wsgi.application"


# --- DATABASE CLOUDLFARE D1 ---

# Podczas budowania Cloudflare Workers
# Django nie próbuje ładować sqlite3

if os.getenv("WORKERS_CI") == "1":

    DATABASES = {}

else:

    DATABASES = {
        "default": {
            "ENGINE": "django_cf.db.backends.d1",

            # Musi być identyczne jak binding w wrangler.toml
            "CLOUDFLARE_BINDING": "DB",
        }
    }


# --- WALIDACJA HASEŁ ---

AUTH_PASSWORD_VALIDATORS = [
    {
        "NAME": "django.contrib.auth.password_validation.UserAttributeSimilarityValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.MinimumLengthValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.CommonPasswordValidator",
    },
    {
        "NAME": "django.contrib.auth.password_validation.NumericPasswordValidator",
    },
]


# --- LOKALIZACJA ---

LANGUAGE_CODE = "pl"

TIME_ZONE = "Europe/Warsaw"

USE_I18N = True

USE_TZ = True



# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/5.1/howto/static-files/

STATIC_URL = 'static/'
STATIC_ROOT = BASE_DIR.parent.joinpath('staticfiles').joinpath('static')



# --- MEDIA / CLOUDFLARE R2 ---

MEDIA_URL = "/media/"


STORAGES = {

    "default": {

        "BACKEND": "django_cf.storage.R2Storage",

        "OPTIONS": {
            # musi odpowiadać bindingowi R2 w wrangler.toml
            "binding": "BUCKET",

            "location": "media",
        },
    },


    "staticfiles": {

        "BACKEND": "django.contrib.staticfiles.storage.StaticFilesStorage",

    },
}



# --- LOGOWANIE ---

LOGIN_URL = "login"

LOGIN_REDIRECT_URL = "pipeline"

LOGOUT_REDIRECT_URL = "login"



# --- DEFAULT FIELD ---

DEFAULT_AUTO_FIELD = "django.db.models.BigAutoField"