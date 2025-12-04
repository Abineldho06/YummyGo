import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yummygo/models/category_model.dart';

class ApiService {
  final String url = "https://faheemkodi.github.io/mock-menu-api/menu.json";

  Future<List<CategoryModel>> fetchMenu() async {
    Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        return (json['categories'] as List)
            .map((item) => CategoryModel.fromJson(item))
            .toList();
      } else {
        throw Exception("Failed to fetch menu data");
      }
    } catch (e) {
      print("API ERROR: $e");
      return [];
    }
  }
}
