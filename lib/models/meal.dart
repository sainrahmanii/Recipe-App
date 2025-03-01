class Meal {
  final String strMeal;
  final String strMealThumb;
  final String idMeal;
  final String? strCategory;
  final String? strInstructions;

  Meal({
    required this.strMeal,
    required this.strMealThumb,
    required this.idMeal,
    required this.strCategory,
    required this.strInstructions,
  });

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"],
        idMeal: json["idMeal"],
        strCategory: json["strCategory"],
        strInstructions: json["strInstructions"],
      );

  Map<String, dynamic> toJson() => {
        "strMeal": strMeal,
        "strMealThumb": strMealThumb,
        "idMeal": idMeal,
        "strCategory": strCategory,
        "strInstructions": strInstructions,
      };
}
