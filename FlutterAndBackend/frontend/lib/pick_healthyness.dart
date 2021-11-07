import 'package:flutter/material.dart';
import 'package:foodhealth/pick_ingredients.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HealthyPicker extends StatelessWidget {
  const HealthyPicker({ Key? key }) : super(key: key);

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
            Text("How Healthy?", style: Theme.of(context).textTheme.bodyText2),
            SizedBox(height: size.height * 0.1),
            HealthSlider(),
            SizedBox(height: size.height * 0.2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const <Widget>[BackBtn(), NextBtn()],
              )
          ],
        )
      )
    );
  }
}

class HealthSlider extends StatefulWidget {
  double sliderVal = 5.0;

  HealthSlider({ Key? key }) : super(key: key);
  @override
  _HealthSliderState createState() => _HealthSliderState();
}

class _HealthSliderState extends State<HealthSlider> {
  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Colors.redAccent,
      inactiveColor: Colors.blueAccent,
      label: widget.sliderVal.round().toString(),
      min: 0.0,
      max: 10.0,
      value: widget.sliderVal,
      divisions: 10,
      onChanged: (double value) {
        setState(() {
          widget.sliderVal = value;
          saveInSharedPreference(value.round());
        });
      },
    );
  }
  saveInSharedPreference(int userInput) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("health", userInput);
    debugPrint("health saved: $userInput");
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
                MaterialPageRoute(builder: (context) => const IngredientPicker())
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
