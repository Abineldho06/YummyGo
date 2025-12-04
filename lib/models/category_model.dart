import 'package:yummygo/models/dish_model.dart';

class CategoryModel {
  final int id;
  final String name;
  final List<DishModel> dishes;

  CategoryModel({required this.id, required this.name, required this.dishes});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      dishes: (json['dishes'] as List)
          .map((item) => DishModel.fromJson(item))
          .toList(),
    );
  }
}
