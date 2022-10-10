import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/model/product_details.dart';

class ProductDetailsController extends GetxController {
  Future<ProductDetailsData?> getProductDetails(
      String textToken, int id) async {
    try {
      const url = "http://mamun.click/api/product/find/";

      http.Response response = await http.get(Uri.parse('$url$id'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        final productDetails = productDetailsFromJson(response.body);

        return productDetails.data;
      } else {
        print('Product details Not Found');
        return null;
      }
    } catch (e) {
      print('Try exception ${e.toString()}');
      return null;
    }
  }
}
