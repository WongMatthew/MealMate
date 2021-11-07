import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foodhealth/food.dart';

class RecommendedResult extends StatefulWidget {

  String rawData;
  RecommendedResult({ Key? key , required this.rawData}) : super(key: key);

  late List<FoodResult> result;

  @override
  _RecommendedResultState createState() => _RecommendedResultState();
}

class _RecommendedResultState extends State<RecommendedResult> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.result = convertJsonToList();
    debugPrint(widget.result.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
                child: Row(
                children: <Widget>[
                  Text("Recipes", style: Theme.of(context).textTheme.bodyText2),
                    Image.asset("png/bowl_of_rice.png")
                  ],),),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.result.length,
                    itemBuilder: (context, index) {
                      return RecommendationCard(
                        image: "png/bowl_of_rice.png",
                        nameOfFood: widget.result[index].nameOfFood,
                        ingredients: widget.result[index].ingredient.toString(),
                        url: widget.result[index].url
                        );
                    })
            ],
        ),
      )
    );
  }
  List<FoodResult> convertJsonToList() {
    List<FoodResult> foodlist = [];
    Map<String, dynamic> rawData = jsonDecode(widget.rawData);
    for(var i = 0; i < rawData.length; i++)
    {
      debugPrint("dishes: ${rawData['dishes'][i]}");
      debugPrint("ingredient: ${rawData['ingredientList'][i].toString()}");
      foodlist.add(FoodResult(
        nameOfFood: rawData['dishes'][i],
        ingredient: rawData['ingredientList'][i].toString(),
        url: rawData['urls'][i]));
    }
    return foodlist;
  }
}

class RecommendationCard extends StatelessWidget {

  late String image;
  late String nameOfFood;
  late String ingredients;
  late String url;
  
  RecommendationCard(
    { Key? key, required this.url, required this.image,
     required this.nameOfFood, required this.ingredients}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: size.width * 0.7,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50.0),
      ),
      child: RecommendationCardRow(
        url: url,
        image: image, 
        nameOfFood: nameOfFood,
        ingredients: ingredients,
      ),
    );
  }
}

class RecommendationCardRow extends StatelessWidget {
  late String image;
  late String nameOfFood;
  late String ingredients;
  late String url;

  RecommendationCardRow(
    { Key? key,required this.url, required this.image, required this.nameOfFood, required this.ingredients}
    ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: AssetImage(image),
          radius: 40.0,),
        Flexible(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(nameOfFood, style: Theme.of(context).textTheme.subtitle1, maxLines: 1,
            overflow: TextOverflow.ellipsis,),
            // Divider(thickness: 2, color: Colors.black,),
            Text(ingredients, style: Theme.of(context).textTheme.subtitle1, maxLines: 1,
            overflow: TextOverflow.ellipsis,),
          ]
        )
        )
      ],
    );
  }
}