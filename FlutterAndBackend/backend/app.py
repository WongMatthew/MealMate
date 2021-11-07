from flask import Flask, request, jsonify
import pandas as pd
from sklearn.neighbors import NearestNeighbors
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.neighbors import NearestNeighbors

def recommendation(ingredient_list, calorie, health):
    # processed dataset
    df = pd.read_csv("recipe_data_lite_reduced_calories.csv")
    # Dae FIX = We need at least 2 ingredients to make a recommendation
    if len(ingredient_list) < 2:
        return "# Please select at least 2 ingredients!"
    # check if values are within limits
    if not 800 >= calorie >= 300:
        raise Exception("Enter a calorie value between 300 and 800")
    if not 10 >= health >= 0:
        raise Exception("Enter a health scale value between 0 and 10")
    # remove values less than input values (calorie & health)
    df.drop(df[df['calories'] <= calorie].index, inplace = True)
    df.drop(df[df['health scale'] <= health].index, inplace = True)
    df = df.reset_index(drop = True)
    # vectorize
    tf_model = TfidfVectorizer(max_features=1000,max_df=0.25,min_df=0.01,stop_words='english')
    corpus = df['NER']
    # fit + transform
    tf_matrix = tf_model.fit_transform(corpus).todense()
    tf_df = pd.DataFrame(tf_matrix)
    tf_df.columns = sorted(tf_model.vocabulary_)
    # predict and fit
    nn = NearestNeighbors(n_neighbors=10, algorithm='ball_tree')
    nn.fit(tf_matrix)
    new = tf_model.transform(ingredient_list)
    results = nn.kneighbors(new.todense(), return_distance=False)
    # print results
    prediction = []
    for i in results[1]:
        prediction.append([i, df.loc[i, ('title')], df.loc[i, ('link')], df.loc[i, ('NER')]])
    return prediction

app = Flask(__name__)

@app.route('/post', methods=["POST"])
def testpost():
    input_json = request.get_json(force=True) 
    calories = input_json["calories"]
    health = input_json["health"]
    ingredient_list = input_json['ingredient_list']
    recommendations = recommendation(ingredient_list, calories, health)
    dictToReturn = {}
    
    food_lst = []
    url_lst = []
    ingredientList = []
    for dish in recommendations:
        food_lst.append(dish[1])
        url_lst.append(dish[2])
        ingredientList.append(dish[3])

    dictToReturn['dishes'] = food_lst
    dictToReturn['urls'] = url_lst
    dictToReturn['ingredientList'] = ingredientList

    return jsonify(dictToReturn)

if __name__ == "__main__":
    app.run(debug=True)