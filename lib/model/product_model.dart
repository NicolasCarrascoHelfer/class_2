// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final String name;
  final String brand;
  final double price;
  final bool discount;
  final String image;
  final String description;
  final int stock;
  final String size;

  Product({
    required this.name,
    required this.brand,
    required this.price,
    required this.discount,
    required this.image,
    required this.description,
    required this.stock,
    required this.size,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        name: json["name"],
        brand: json["brand"],
        price: json["price"],
        discount: json["discount"],
        image: json["image"],
        description: json["description"],
        stock: json["stock"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "brand": brand,
        "price": price,
        "discount": discount,
        "image": image,
        "description": description,
        "stock": stock,
        "size": size,
      };
}
