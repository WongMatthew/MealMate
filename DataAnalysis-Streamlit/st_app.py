import streamlit as st
import pandas as pd
from sklearn.neighbors import NearestNeighbors
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.neighbors import NearestNeighbors
import pickle

st.write("## Dataset Analysis")
st.write("### Queried result")
def read_ingredients():
    ingredients = []
    with open('ingredients.txt') as f:
        while True:
            line = f.readline().replace('\n', '')
            ingredients.append(line)
            if line == '':
                break
    return ingredients

def GetUserInput():
    with st.form(key='UserForm'):
        with st.sidebar:
            st.header("User Input")
            min_calories = st.slider("Give the minimum calories", 300, 800, value=500)
            min_health_scale = st.slider("Give the minimum healthy scale", 0, 10, value=5)
            ingredients = st.multiselect("Select the ingredients", options=read_ingredients())
            submit = st.form_submit_button("Submit")

    return min_calories, min_health_scale, ingredients, submit

user_input = GetUserInput()

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


try:
    st.write(pd.DataFrame(recommendation(user_input[2], user_input[0], user_input[1])))
    # recommendation = pickle.load(file='tf_model.pkl')
    # st.write(recommendation(user_input[2], user_input[0], user_input[1]))
except ValueError:
    st.write("# Select food to start!")