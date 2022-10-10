import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/special_day/model/category_1.dart';

class SpecialCategoryController extends GetxController {
  Future<List<SpecialCategory1Datum>?> getCategory1Product(
      String textToken) async {
    try {
      var url = "http://mamun.click/api/special-day/category/all";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = specialCategory1FromJson(response.body);

        //print('proooooooooooooooooooo ${allProduct.data.toString()}');

        return allProduct.data;
      } else {
        print('Category not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
