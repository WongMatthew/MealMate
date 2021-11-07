import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodhealth/food.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:foodhealth/readfile.dart';
import 'package:foodhealth/search.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngredientPicker extends StatelessWidget {
  const IngredientPicker({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("png/bowl_of_rice.png"),
            Text("Available Ingredients?", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: size.height * 0.1),
            DropDownSearchIngredient(),
            SizedBox(height: size.height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[BackBtn(), NextBtn()],
              )
          ],
        ),
      ),
    );
  }
}

class DropDownSearchIngredient extends StatefulWidget {
  DropDownSearchIngredient({ Key? key }) : super(key: key);
  @override
  _DropDownSearchIngredientState createState() => _DropDownSearchIngredientState();
}

class _DropDownSearchIngredientState extends State<DropDownSearchIngredient> {
  List<String> ingredients = [];

  late String selectedIngredients;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTxt().then((value) {
      for (String str in LineSplitter().convert(value)){
        ingredients.add(str);
      }
    ingredients.sort();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>.multiSelection(
      mode: Mode.MENU,
      showSelectedItems: true,
      items: ingredients,
      onChanged: ((value) {
      saveInSharedPreference(value);
      }),
    );
  }
  saveInSharedPreference(List<String> userInput) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setStringList("ingredients", userInput);
    debugPrint("ingredients saved: $userInput");
  }
}
//////////////////////////////////////////////////////////////////////////////////////////
///
///
///
///
class NextBtn extends StatelessWidget {
  const NextBtn({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchHome())
              );
            },
            child: Container(
              alignment: Alignment.center,  
              width: size.width * 0.4,
              height: size.width * 0.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("png/Rectangle_2.png"),
                )
              ),
        child: Text("Next", style: Theme.of(context).textTheme.bodyText1)
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  const BackBtn({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,  
              width: size.width * 0.4,
              height: size.width * 0.2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("png/Rectangle_2.png"),
                )
              ),
        child: Text("Back", style: Theme.of(context).textTheme.bodyText1)
      ),
    );
  }
}
