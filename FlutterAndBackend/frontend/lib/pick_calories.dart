import 'package:flutter/material.dart';
import 'package:foodhealth/pick_healthyness.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CaloriesPicker extends StatelessWidget {
  const CaloriesPicker({ Key? key }) : super(key: key);

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
            Text("How Many Calories?", style: Theme.of(context).textTheme.bodyText2,),
            SizedBox(height: size.height * 0.05,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(11.0),
              ),
              child: DropDownCaloriesPicker()
            ),
            SizedBox(height: size.height * 0.2,),
            const NextBtn(),
          ],
        )
      )
    );
  }
}

class DropDownCaloriesPicker extends StatefulWidget {
  DropDownCaloriesPicker({ Key? key }) : super(key: key);

  final calorieOptions = <String>{
    "Very High Calories: 900 kcal",
    "High Calories: 750 kcal",
    "Medium Calories: 600 kcal",
    "Low Calories: 450 kcal",
    "Very Low Calories: 300 kcal"
  };

  var userChoice = "Medium Calories: 600 kcal";

  @override
  _DropDownCaloriesPickerState createState() => _DropDownCaloriesPickerState();
}

class _DropDownCaloriesPickerState extends State<DropDownCaloriesPicker> {

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(11.0),
      value: widget.userChoice,
      icon: const Icon(Icons.arrow_downward, color: Colors.black),
      onChanged: (String? newValue) {
        setState(() {
          saveInSharedPreference(newValue);
          widget.userChoice = newValue!;
        });
      },
      items: widget.calorieOptions
      .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(child: Text(value), value: value);
      }).toList(),
      );
  }
  saveInSharedPreference(String? userInput) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    late int value;
    switch (userInput) {
      case "Very High Calories: 900 kcal":
        value = 900;
        break;
      case "High Calories: 750 kcal":
        value = 750;
        break;
      case "Medium Calories: 600 kcal":
        value = 600;
        break;
      case "Low Calories: 450 kcal":
        value = 450;
        break;
      case "Very Low Calories: 300 kcal":
        value = 300;
        break;
      
      default:
        value = 0;
        break;
    }

    await pref.setInt("calories", value);
    debugPrint("calories saved: $value");
  }
}

class NextBtn extends StatelessWidget {
  const NextBtn({ Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HealthyPicker())
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