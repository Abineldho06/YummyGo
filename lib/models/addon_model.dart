class AddonModel {
  final int id;
  final String name;
  final double price;

  AddonModel({required this.id, required this.name, required this.price});

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['id'],
      name: json['name'],
      price: double.parse(json['price']),
    );
  }
}
