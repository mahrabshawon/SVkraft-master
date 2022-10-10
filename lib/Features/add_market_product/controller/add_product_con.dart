import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddProductController extends GetxController {
  String? selectedCategory;
  int? selectedCardId;
  String? selectedCity;
  String? selectedBrand;
  String? condition;
  List<File> images = [];

  //pick images in add product page
  Future<List<File>> pickImages() async {
    try {
      var files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return images;
  }

  uploadProduct({name, description, price, quantity, token}) async {
    if (images.isNotEmpty) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('http://mamun.click/api/product/create'));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
      });
      request.fields['category_id'] = '$selectedCardId';
      request.fields['location'] = "$selectedCity";
      request.fields['brand'] = "$selectedBrand";
      request.fields['condition'] = "$condition";
      request.fields['product_name'] = '$name';
      request.fields['price'] = '$price';
      request.fields['description'] = '$description';
      request.fields['quantity'] = '$quantity';
      for (int i = 0; i < images.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath('image[]', images[i].path),
        );
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        Get.snackbar('Success', response.statusCode.toString());
        return response.statusCode;
      } else {
        Get.snackbar('failed', response.statusCode.toString());
      }
    }
  }
}
