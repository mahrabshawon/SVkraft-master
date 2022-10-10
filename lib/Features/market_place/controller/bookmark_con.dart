import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/model/get_bookamrk_model.dart';

class BookmarkController extends GetxController {
  addBookmarkProduct(String textToken, productId) async {
    try {
      print('productId = $productId');
      http.Response response = await http.post(
          Uri.parse('http://mamun.click/api/marketplace/add-to-bookmark'),
          body: {
            'product_id': productId.toString(),
          },
          headers: {
            // 'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $textToken',
          });

      if (response.statusCode == 200) {
        print('Bookmark Product Added');
        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<GetMarketBoomarkData>?> getBookmarkProduct(
      String textToken) async {
    try {
      const url = "http://mamun.click/api/marketplace/bookmark-item/show";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        final marketBookmark = getMarketBoomarkFromJson(response.body);
        return marketBookmark.data;
      } else {
        print('Bookmark is Empty');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
