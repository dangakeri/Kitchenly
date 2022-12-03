import 'dart:convert';
import 'package:kitchenly/model/model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<List<RecipeModel>> getData() async {
    try {
      var response = await http.get(Uri.parse(
          "https://forkify-api.herokuapp.com/api/v2/recipes?search=pizza"));
      print(response.body);

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body)["data"]["recipes"];
        print(jsonResponse);
        return jsonResponse.map((data) => RecipeModel.fromJson(data)).toList();
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<RecipesModel> getRecipeData(String id) async {
    try {
      var response = await http.get(
          Uri.parse("https://forkify-api.herokuapp.com/api/v2/recipes/$id"));
      print(response.body);

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)["data"]["recipe"];
        return RecipesModel.fromJson(jsonResponse);
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
