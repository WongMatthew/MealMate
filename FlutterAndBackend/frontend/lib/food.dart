class FoodRecommendation {
  int calories;
  int health;
  List<String> ingredient;

  FoodRecommendation({required this.calories, required this.health, required this.ingredient});

  Map<String, dynamic> toJson() => {
    "calories": calories,
    "health": health,
    "ingredient_list": ingredient
  };
}
class FoodResult {
  String nameOfFood;
  String url;
  String ingredient;

  FoodResult({required this.nameOfFood, required this.url, required this.ingredient});
}