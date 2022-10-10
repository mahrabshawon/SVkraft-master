import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';

class AllProductController extends GetxController {
  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth-token');
    print(token);
    return token;
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user-id');

    return userId;
  }

  String? tokenGlobal;
  Future<List<Datum>?> getCategoryProduct(String textToken, int id) async {
    try {
      var url = "http://mamun.click/api/product/$id";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = allProductFromJson(response.body);

        //print('proooooooooooooooooooo ${allProduct.data.toString()}');

        return allProduct.data;
      } else {
        print('Product not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
