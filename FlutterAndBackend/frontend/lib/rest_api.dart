import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:foodhealth/food.dart';
import 'package:url_launcher/url_launcher.dart';

Future<String> post_method(String TargetLink, FoodRecommendation foodinfo) async{
  var response = await post(Uri.parse(TargetLink),
   headers: {'Content-Type': 'application/json',},
    body: jsonEncode(foodinfo.toJson()));
  
  return response.body;
}

Future<void> openWebView(String targetUrl) async {
  if(await canLaunch(targetUrl)) {
    await launch(targetUrl);
  }
  else{
    throw "Unavailable to goto $targetUrl!";
  }
}