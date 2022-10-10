import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddtocartController extends GetxController {
  addTocart(int userId, int productId, String type, int quantity, int price,
      String textToken) async {
    try {
      http.Response response =
          await http.post(Uri.parse('http://mamun.click/api/cart/add'), body: {
        'user_id': userId.toString(),
        'product_id': productId.toString(),
        'type': type.toString(),
        'quantity': quantity.toString(),
        'price': price.toString(),
      }, headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        return data['message'];
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
