import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/search_product_model.dart';

class GrocerySearchController extends GetxController {
  Future<List<GrocerySearchedProductData>?> getGrocerySearchProduct(
      String textToken, name) async {
    try {
      var url = "http://mamun.click/api/groceries/search/$name";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        final marketSearch = grocerySearchedProductFromJson(response.body);

        // print('proooooooooooooooooooo ${marketSearch.data}');
        // print(marketCategory.data[1].categoryName);s
        return marketSearch.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
