// To parse this JSON data, do
//
//     final specialAllProduct = specialAllProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SpecialAllProduct specialAllProductFromJson(String str) =>
    SpecialAllProduct.fromJson(json.decode(str));

String specialAllProductToJson(SpecialAllProduct data) =>
    json.encode(data.toJson());

class SpecialAllProduct {
  SpecialAllProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<SpecialAllProductData> data;

  factory SpecialAllProduct.fromJson(Map<String, dynamic> json) =>
      SpecialAllProduct(
        success: json["success"],
        message: json["message"],
        data: List<SpecialAllProductData>.from(
            json["data"].map((x) => SpecialAllProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'SpecialAllProduct{success: $success, message: $message, data: $data}';
  }
}

class SpecialAllProductData {
  SpecialAllProductData({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
  });

  int id;
  String name;
  String description;
  String image;
  int price;
  Category category;

  factory SpecialAllProductData.fromJson(Map<String, dynamic> json) =>
      SpecialAllProductData(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        image: json["image"],
        price: json["price"],
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image": image,
        "price": price,
        "category": category.toJson(),
      };

  @override
  String toString() {
    return 'SpecialAllProductData{id: $id, name: $name, description: $description, image: $image, price: $price, category: $category}';
  }
}

class Category {
  Category({
    required this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };

  @override
  String toString() {
    return 'Category{name: $name}';
  }
}
