import 'package:flutter/material.dart';
import 'package:yummygo/models/category_model.dart';
import 'package:yummygo/services/api_service.dart';

class MenuControllerprovider extends ChangeNotifier {
  List<CategoryModel> categories = [];
  bool isLoading = false;
  String? error;

  /// Load menu from API
  Future<void> fetchMenu() async {
    isLoading = true;
    notifyListeners();

    try {
      categories = await ApiService().fetchMenu();
      error = null;
    } catch (e) {
      error = "Failed to load menu";
    }

    isLoading = false;
    notifyListeners();
  }

  /// Get dishes for selected category
  List getDishesByCategory(int index) {
    if (index < categories.length) {
      return categories[index].dishes;
    }
    return [];
  }
}
