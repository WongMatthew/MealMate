import 'package:flutter/services.dart' show rootBundle;
import 'dart:async' show Future;

Future<String> loadTxt() async {
  return await rootBundle.loadString("ingredients/ingredients.txt");
}