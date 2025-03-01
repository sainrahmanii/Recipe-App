// To parse this JSON data, do
//
//     final responseMeals = responseMealsFromJson(jsonString);

import 'dart:convert';

import 'package:receipt_app/models/meal.dart';

ResponseMeals responseMealsFromJson(String str) =>
    ResponseMeals.fromJson(json.decode(str));

String responseMealsToJson(ResponseMeals data) => json.encode(data.toJson());

class ResponseMeals {
  final List<Meal> meals;

  ResponseMeals({
    required this.meals,
  });

  factory ResponseMeals.fromJson(Map<String, dynamic> json) => ResponseMeals(
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}
