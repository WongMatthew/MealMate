from flask import Flask, redirect, url_for, render_template, request, session, flash
from datetime import timedelta
from dotenv import dotenv_values
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from os import path

db = SQLAlchemy()
DB_NAME = "database.db"

#config = dotenv_values(".env")


def create_app():
    app = Flask(__name__)
    app.config["SECRET_KEY"] = "spdfspdfjiwekd"
    app.config["SQLALCHEMY_DATABASE_URI"] = f'sqlite:///{DB_NAME}'
    db.init_app(app)


    from .pages import pages
    from .auth import auth

    app.register_blueprint(pages, url_prefix='/')
    app.register_blueprint(auth, url_prefix='/')

    from .models import User

    print("SHDF")
    create_database(app)

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(id):
        return User.query.get(int(id))

    return app


def create_database(app):
    if not path.exists('website/' + DB_NAME):
        db.create_all(app=app)
        print("Created Database")
