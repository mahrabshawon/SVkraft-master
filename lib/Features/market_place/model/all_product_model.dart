// To parse this JSON data, do
//
//     final allProduct = allProductFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AllProduct allProductFromJson(String str) =>
    AllProduct.fromJson(json.decode(str));

String allProductToJson(AllProduct data) => json.encode(data.toJson());

class AllProduct {
  AllProduct({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'AllProduct{success: $success, message: $message, data: $data}';
  }
}

class Datum {
  Datum({
    required this.id,
    required this.location,
    required this.productName,
    required this.price,
    required this.bookmark,
    required this.image,
    required this.category,
  });

  int id;
  String location;
  String productName;
  int price;
  bool bookmark;
  List<ProductImage> image;
  Category category;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        location: json["location"],
        productName: json["product_name"],
        price: json["price"],
        bookmark: json["bookmark"],
        image: List<ProductImage>.from(
            json["image"].map((x) => ProductImage.fromJson(x))),
        category: Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "product_name": productName,
        "price": price,
        "bookmark": bookmark,
        "image": List<dynamic>.from(image.map((x) => x.toJson())),
        "category": category.toJson(),
      };

  @override
  String toString() {
    return 'Datum{id: $id, location: $location, productName: $productName, price: $price, bookmark: $bookmark, image: $image, category: $category}';
  }
}

class Category {
  Category({
    required this.id,
    required this.categoryName,
    required this.image,
    required this.brands,
  });

  int id;
  String categoryName;
  String image;
  String brands;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        categoryName: json["category_name"],
        image: json["image"],
        brands: json["brands"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_name": categoryName,
        "image": image,
        "brands": brands,
      };

  @override
  String toString() {
    return 'Category{id: $id, categoryName: $categoryName, image: $image, brands: $brands}';
  }
}

class ProductImage {
  ProductImage({
    required this.filePath,
  });

  String filePath;

  factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "file_path": filePath,
      };
}




// import 'package:meta/meta.dart';
// import 'dart:convert';

// AllProduct allProductFromJson(String str) =>
//     AllProduct.fromJson(json.decode(str));

// String allProductToJson(AllProduct data) => json.encode(data.toJson());

// class AllProduct {
//   AllProduct({
//  required this.success,
//  required this.message,
//  required this.data,
//   });

//   bool success;
//   String message;
//   List<Datum> data;

//   factory AllProduct.fromJson(Map<String, dynamic> json) => AllProduct(
//         success: json["success"],
//         message: json["message"],
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   Datum({
//  required this.id,
//  required this.location,
//  required this.productName,
//  required this.price,
//  required this.image,
//  required this.category,
//   });

//   int id;
//   String location;
//   String productName;
//   int price;
//   List<ProductImage> image;
//   Category category;

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         location: json["location"],
//         productName: json["product_name"],
//         price: json["price"],
//         image: List<ProductImage>.from(
//             json["image"].map((x) => ProductImage.fromJson(x))),
//         category: Category.fromJson(json["category"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "location": location,
//         "product_name": productName,
//         "price": price,
//         "image": List<dynamic>.from(image.map((x) => x.toJson())),
//         "category": category.toJson(),
//       };

//   @override
//   String toString() {
//     return 'Datum{id: $id, location: $location, productName: $productName, price: $price, image: $image, category: $category}';
//   }
// }

// class Category {
//   Category({
//  required this.categoryName,
//   });

//   String categoryName;

//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         categoryName: json["category_name"],
//       );

//   Map<String, dynamic> toJson() => {
//         "category_name": categoryName,
//       };
// }

// class ProductImage {
//   ProductImage({
//  required this.filePath,
//   });

//   String filePath;

//   factory ProductImage.fromJson(Map<String, dynamic> json) => ProductImage(
//         filePath: json["file_path"],
//       );

//   Map<String, dynamic> toJson() => {
//         "file_path": filePath,
//       };
// }









