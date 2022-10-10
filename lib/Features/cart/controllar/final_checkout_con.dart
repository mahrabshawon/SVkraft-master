import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FinalCheckoutController extends GetxController {
  finalCheckout(String textToken) async {
    try {
      print(textToken);
      http.Response response = await http.post(
          Uri.parse('http://mamun.click/api/order/create'),
          body: {},
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $textToken',
          });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
