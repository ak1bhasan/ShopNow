import os
from dotenv import load_dotenv

load_dotenv()


def require_database_uri():
    uri = os.environ.get("DATABASE_URI")
    if not uri:
        raise RuntimeError(
            "DATABASE_URI is not set. Provide a MySQL URI "
            "(e.g. mysql+pymysql://user:password@localhost:3306/dbname)."
        )
    return uri


class Config:
    """Base configuration class."""

    SECRET_KEY = os.environ.get("SECRET_KEY") or "dev-secret-key-change-me"
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_RECORD_QUERIES = True


class DevConfig(Config):
    """Development configuration."""

    DEBUG = True
    SQLALCHEMY_DATABASE_URI = require_database_uri()


class ProdConfig(Config):
    """Production configuration."""

    DEBUG = False
    SQLALCHEMY_DATABASE_URI = require_database_uri()


config = {"development": DevConfig, "production": ProdConfig, "default": DevConfig}
