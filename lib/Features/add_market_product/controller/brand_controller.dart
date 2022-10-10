import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/add_market_product/models/get_band_model.dart';

class BradController extends GetxController {
  Future<List<String>?> getBrandName(String textToken, int id) async {
    try {
      var url = "http://mamun.click/api/product/brand/$id";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        final brandName = brandNameFromJson(response.body);
        return brandName.data;
      } else {
        print('City not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
