import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/cart/model/delete_item.dart';
import 'package:sv_craft/Features/grocery/model/search_product_model.dart';

class CartItemDeleteController extends GetxController {
  Future<DeleteCartItem?> cartItemDelete(
      String textToken, int userId, int productId, String type) async {
    try {
      var url = "http://mamun.click/api/cart/delete/$userId/$productId/$type";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final marketSearch = deleteCartItemFromJson(response.body);

        // print('proooooooooooooooooooo ${marketSearch.data}');
        // print(marketCategory.data[1].categoryName);s
        return marketSearch;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
