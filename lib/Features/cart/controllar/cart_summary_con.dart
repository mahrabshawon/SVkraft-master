import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/cart/model/cart_summary.dart';

class GetCartSummaryController extends GetxController {
  Future<CartSummaryData?> getCartSummary(String textToken) async {
    try {
      print('Tokennnnnnnnnnnn $textToken');
      var url = "http://mamun.click/api/cart/summary";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = getCartSummaryFromJson(response.body);
        return allProduct.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
