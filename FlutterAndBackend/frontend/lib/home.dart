import 'package:flutter/material.dart';
import 'package:foodhealth/pick_calories.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SvgPicture.asset("svg/MealMate.svg"),
            Text("MealMate", style: Theme.of(context).textTheme.headline1,),
            Image.asset("png/bowl_of_rice.png"),
            SizedBox(height: size.height * 0.1,),
            const NextBtn(),
          ],
        )
        ),
    );
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
                MaterialPageRoute(builder: (context) => const CaloriesPicker())
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