import 'package:yummygo/models/addon_model.dart';

class DishModel {
  final int id;
  final String name;
  final double price;
  final String currency;
  final int calories;
  final String description;
  final List<AddonModel> addons;
  final String imageUrl;
  final bool customizationsAvailable;
  final bool isVeg;

  int quantity; // Used for cart count

  DishModel({
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.calories,
    required this.description,
    required this.addons,
    required this.imageUrl,
    required this.customizationsAvailable,
    required this.isVeg,
    this.quantity = 0,
  });

  factory DishModel.fromJson(Map<String, dynamic> json) {
    return DishModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
      currency: json['currency'],
      calories: json['calories'],
      description: json['description'],
      addons: (json['addons'] as List)
          .map((item) => AddonModel.fromJson(item))
          .toList(),
      imageUrl: json['image_url'],
      customizationsAvailable: json['customizations_available'],
      isVeg: json['is_veg'],
    );
  }
}
