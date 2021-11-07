import 'package:flutter/material.dart';
import 'package:foodhealth/recommended_result.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:foodhealth/rest_api.dart';
import 'package:foodhealth/food.dart';

class SearchHome extends StatelessWidget {
  const SearchHome({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("png/Rectangle_2.png"))
        ),
          child: SearchBtn(),
      )
    );
  }
}

class SearchBtn extends StatefulWidget {
  SearchBtn({ Key? key }) : super(key: key);
  
  late FoodRecommendation food;
  late String result;

  @override
  _SearchBtnState createState() => _SearchBtnState();
}

class _SearchBtnState extends State<SearchBtn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_preferences().then((value) { widget.food = value;
    debugPrint("Food: ${widget.food.calories.toString()}");
    post_method("http://10.0.2.2:5000/post", widget.food)
    .then((value){widget.result = value;
    debugPrint("Result: ${widget.result}");});
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RecommendedResult(rawData: widget.result)
          )
      ),
      child: Text("Search"),
    );
  }
}

Future<FoodRecommendation> get_preferences() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  int? calories = pref.getInt('calories');
  int? health = pref.getInt('health');
  List<String>? ingredients = pref.getStringList('ingredients');
  debugPrint("calories: $calories, health: $health, ingredients: $ingredients");
  return FoodRecommendation(calories: calories!, health: health!, ingredient: ingredients!);
}