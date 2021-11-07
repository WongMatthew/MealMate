# MealMate

![mealmateicon](https://user-images.githubusercontent.com/49925170/140648740-e88314be-755d-4f20-812f-f37e90ac0728.png)

Meals for you and your mates

## 💡 Inspiration 💡

As university students, we’re very busy, and we’re often so focused on our work that we end up skipping meals. When we do eat, not only do we waste a lot of time deciding what to eat, but we also don’t know many recipes, and as a result, we usually opt for something quick, cheap, and unhealthy, such as fast food or instant ramen. As this is a common issue within the team, we want to create an app that addresses it. The goal of this app is to organize and decide our meals for us, so we don’t waste time contemplating what to eat. This not only saves time, but it also stops us from resorting to unhealthy foods for the sake of convenience. 


## ⚙️ What it does ⚙️

MealMate lets you choose recipes to make at home. Based on the ingredients you have on hand, MealMate will recommend recipes tailored to your diet. If you want to have a low-calorie, super healthy breakfast, no problem!


## 🛠️ How we built it 🛠️

We found a database of recipes and their respective ingredients on Kaggle. The dataset was approximately 2.2 million rows. We had to take a very small portion of it so that our computers could handle running the recommender systems. We also feature engineered calories and an arbitrary health scale. For calories, each recipe was assigned a random value between 300 and 800 because a person's average homemade meal/snack falls within this boundary. Each recipe was also given a random value between 1 and 10 for the health scale. 

MealMate uses a TF-IDF recommendation system. The recommendation system is measured in cosine similarity and gives recommendations with a score of at least 0.6. The recommender system has two parts. The first part goes through the database and removes any recipes that don't fall within the parameters the user sets (calories and health scale). The TF-IDF system takes into account the different 
ingredients the user inputs and returns a recommendation of 10 recipes that the user could make. 

Figma was used to create a general UI design template. This helped the project move faster through the next phases because the programmers knew exactly what they were trying to create.
Now that the project had a solid foundation in the cosine algorithm and the both the general UI design, we decided to split up and develop multiple deployments in order to run on all major operating systems. 

Flask + Heroku Web app: The Flask app consists of an HTML/Jinja frontend and Python backend. We separated the pages into four main routes: the home page, login, signup, and recommendation page that were built with the help of Flask blueprints which greatly sped up development. The main feature of the web app is in the recommendation algorithm which the user can interact with upon landing on the website. As an aside we also implemented a rudimentary login and signup page which is linked to a SQLite database that was setup using SQLAlchemy. Afterwards, the [webpage](https://mealmate-flask.herokuapp.com/) was deployed on Heroku.

Flutter: How was it coded and then incorporated with Flask and such


## 😣  Challenges we ran into 😣

We ran into a lot of challenges with our deployment. One major problem was installing and learning flutter. No one on the team knew how to use flutter, so it was an uphill battle trying to learn it and make a useable UI for iOS/android. We also ran into some troubles with streamlit when we were trying to design a web app. It was a huge hassle trying to understand how to combine the frontend and backend because we needed to grab user input for the recommender system. This was especially the case because we also encountered issues installing scikit-learn which made testing our webpages all the more time consuming. Another major problem came with the deployment of the website and an API that could be used to bridge the user input and recommender output. It was extremely challenging to understand the long-winded and esoteric message thrown up by Heroku. Furthermore, because each deployment consumed plenty of time, the process of debugging became very time consuming. Overall, it was extremely hard to design a UI that focused on usability while getting the user input we needed. In the end, figuring out deployment took up a big chunk of our time. 

With the recommender system, we ran into memory allocation problems early on. The database we found was amazing, except it had way too much data for us. Our computers were unable to allocate enough memory when running the recommender system. The recommender system also had accuracy problems. The cosine similarity scores were around 0.4 which were quite low. Eventually, after tweaking the hyperparameters, we were achieving scores of 0.6-0.8 consistently. 


## 🎉 Accomplishments that we're proud of 🎉

- Our time management was impeccable, we are all very proud of ourselves since we were able to build and deploy an entire app with a recommender system within 24 hours
- Organization within the team was perfect, we were all able to contribute and help each other when needed; ex. the figma design helped our webdevs design the UI
- How our app is able to work on almost all major operating systems
- Learning the basics of flutter and streamlit within a short period of time to deploy our app
- We are happy to empower people while cooking and make their experience so much more enjoyable
- Able to provide a solution for everyone that will increase productivity and promote healthy living 
- This was a SUPER amazing project! We're all proud to have done it in such a short period of time, everyone is new to the hackathon scene and are still eager to learn new technologies  


## 📚 What we learned 📚

- Many useful technical skills such as Flutter, Streamlit, Flask and working with API's. A large part of this project was learning how to integrate Flask and Heroku with a Flutter application to allow it upload and retrieve data from an API
- Design and UI skills such as working with Figma
- How to work together under pressure and manage tasks effectively within a team
- Using cosine similarities to compare items within a dataset
- How to manipulate Github branches via the command window and upload large files using Git LFS
- How to set up and use a virtual machine using Android Studio


## ⏭️What's next for MealMate ⏭️

MealMate has a lot of work to be done before it is ready to be deployed as a genuine app. It will only be successful if the customer is satisfied and benefits from using it; if it is ugly, slow, or tedious to use, it will be a failure. Our next steps are primarily to increase the usability of the app and fix any shortcomings that were not addressed during this hackathon.

For starters, we ran into local memory allocation and speed issues due to the size of the database. As a short time solution, we cut down the size of the database, but to counteract these issues in the future, we aim to move the database, as well as the processing, to the cloud, namely AWS.

The recommender system is also very basic as it is now. We hope to create a more intuitive and complex system that generates more relevant recommendations. For example, recommendations can be based on recipes that were clicked on in the past, or the user will be able to indicate taste preferences (spicy, pasta, vegetables, Indian, Italian, etc...). Dietary restrictions will also be taken into account to ensure the apps widespread usability.

An important aspect of this app is to allow people to quickly decide on meals; pictures play a big role in this, just look at how advertisements affect consumers. To help the user decide quicker and to increase the attractiveness of the app (so that it's not just a wall of text), we plan to add pictures alongside the recommendations.

The current UI is not perfect, and we definitely plan to upgrade it. For now, we plan to add customizable presets so the user does not have to tediously type in the information each time they use the app. On the web app, a more modern multiform input for the ingredients would also be a great addition to the current UI. 

## 🎁 About the team 🎁

All 4 of us are 1st or 2nd year university students new to the hackathon scene! Everyone has only 1 or 2 hackathons worth of experience but that hasn't held us back! 

Dae is a 2nd year student at Simon Fraser University studying computer science. He's interested in everything computer science related and deeply passionate about data science and cross-platform. You can reach out to him at his LinkedIn ~ https://www.linkedin.com/in/daehyung-kwak-136194223/

Matthew is a 2nd year student at Simon Fraser University studying computer science. He has formal training in data science. He's interested in learning new and honing his current frontend skills/technologies. Moreover, he's deeply passionate about machine learning, AI and neural networks. You can reach out to him at his LinkedIn ~ https://www.linkedin.com/in/matthew-wong-240837124/

David is a 1st year student at University of Toronto studying computer science and mathematics. You can reach out to him at his LinkedIn ~ https://www.linkedin.com/in/daniel-s-851b1521a/

Connor is a 1st year Track One Undeclared engineering student at University of Toronto. He loves both hardware and software and is planning to pursue some sort of mechatronics education in the future. He is especially passionate about computer science and robotics. You can reach out to him at his LinkedIn ~ https://www.linkedin.com/in/connor-sheahan-6a3933223/

## 🥳🎉 THANK YOU UOT FOR HOSTING NEWHACKS 🥳🎉
