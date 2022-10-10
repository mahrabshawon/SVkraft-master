// To parse this JSON data, do
//
//     final grocerySearchedProduct = grocerySearchedProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

GrocerySearchedProduct grocerySearchedProductFromJson(String str) =>
    GrocerySearchedProduct.fromJson(json.decode(str));

String grocerySearchedProductToJson(GrocerySearchedProduct data) =>
    json.encode(data.toJson());

class GrocerySearchedProduct {
  GrocerySearchedProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<GrocerySearchedProductData> data;

  factory GrocerySearchedProduct.fromJson(Map<String, dynamic> json) =>
      GrocerySearchedProduct(
        success: json["success"],
        message: json["message"],
        data: List<GrocerySearchedProductData>.from(
            json["data"].map((x) => GrocerySearchedProductData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GrocerySearchedProductData {
  GrocerySearchedProductData({
    required this.id,
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.offPrice,
    required this.marketPrice,
  });

  int id;
  String image;
  String name;
  String description;
  double price;
  int offPrice;
  String marketPrice;

  factory GrocerySearchedProductData.fromJson(Map<String, dynamic> json) =>
      GrocerySearchedProductData(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        price: json["price"].toDouble(),
        offPrice: json["off_price"],
        marketPrice: json["market_price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "description": description,
        "price": price,
        "off_price": offPrice,
        "market_price": marketPrice,
      };
  @override
  String toString() {
    return 'GrocerySearchedProductData{id: $id, image: $image, name: $name, description: $description, price: $price, offPrice: $offPrice, marketPrice: $marketPrice}';
  }
}
