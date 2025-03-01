import 'package:http/http.dart' as http;
import 'package:receipt_app/models/response_meals.dart';

class RemoteService {
  final baseUrl = 'https://www.themealdb.com/api/json/v1/1/';

  Future<ResponseMeals> getMealsByCategory(String category) async {
    final endPoint = 'filter.php?c=$category';
    final response = await http.get(Uri.parse(baseUrl + endPoint));

    if (response.statusCode == 200) {
      return responseMealsFromJson(response.body);
    } else {
      throw Exception('Failed to get meals by category');
    }
  }

  Future<ResponseMeals> getDetailsMeal(String id) async {
    final endPoint = 'lookup.php?i=$id';
    final response = await http.get(Uri.parse(baseUrl + endPoint));

    if (response.statusCode == 200) {
      return responseMealsFromJson(response.body);
    } else {
      throw Exception('Failed to get details meals');
    }
  }
}
