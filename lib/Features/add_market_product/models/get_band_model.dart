// To parse this JSON data, do
//
//     final brandName = brandNameFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BrandName brandNameFromJson(String str) => BrandName.fromJson(json.decode(str));

String brandNameToJson(BrandName data) => json.encode(data.toJson());

class BrandName {
  BrandName({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<String> data;

  factory BrandName.fromJson(Map<String, dynamic> json) => BrandName(
        success: json["success"],
        message: json["message"],
        data: List<String>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };

  @override
  String toString() {
    return 'BrandName{success: $success, message: $message, data: $data}';
  }
}
