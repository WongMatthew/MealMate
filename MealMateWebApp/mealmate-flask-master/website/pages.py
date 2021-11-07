from flask import Blueprint, request, current_app
from flask.templating import render_template
from flask_login import logout_user, current_user
from data_analysis import recommendation

lines = []
pages = Blueprint("pages", __name__)


@pages.route('/', methods=["GET", "POST"])
def home():
    if request.method == "POST":
        calories = int(request.form.get('calories'))
        health = int(request.form.get('health'))
        ingredient_choice = request.form.getlist('ingredient_choice')

        recommendations = recommendation(ingredient_choice, calories, health)
        return render_template("recommendation.html", user=current_user, data=recommendations)

    with open('website/ingredients.txt', 'r') as f:
        lines = f.readlines()
        f.close()
    return render_template("home.html", user=current_user, data=lines)
