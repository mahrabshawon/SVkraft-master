import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/grocery/model/category_model.dart';

class GroceryCategoryController extends GetxController {
  Future<List<GroceryCategoryData>?> getGroceryCategory(
      String textToken) async {
    try {
      const url = "http://mamun.click/api/groceries/category/all";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        final marketCategory = groceryCategoryFromJson(response.body);
        print('groceryCategory: ${marketCategory.data}');
        return marketCategory.data;
      } else {
        print('Category not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
