import 'dart:convert';
import 'package:coupown/Screanes/subscription/api_const.dart/category.dart';
import 'package:http/http.dart' as http;

Future<List<Category>> fetchCategories() async {
  final response = await http.get(Uri.parse('https://coupown.in/api/categories'));

  if (response.statusCode == 200) {
    final jsonResponse = json.decode(response.body);
    List<Category> categories = (jsonResponse['categories'] as List)
        .map((category) => Category.fromJson(category))
        .toList();
    return categories;
  } else {
    throw Exception('Failed to load categories');
  }
}
