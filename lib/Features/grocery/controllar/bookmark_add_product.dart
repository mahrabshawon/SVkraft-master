import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BookmarkProductAddController extends GetxController {
  addBookmarkProduct(String textToken, listId, productId) async {
    try {
      print('listId = $listId' + 'productId = $productId');
      http.Response response = await http.post(
          Uri.parse('http://mamun.click/api/grocery/add-to-bookmark'),
          body: {
            'list_id': listId.toString(),
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
}
