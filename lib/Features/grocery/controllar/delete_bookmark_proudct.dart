import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DeleteBookmarkProductController extends GetxController {
  bookmarkProductDelete(String textToken, int categoryId) async {
    try {
      var url = "http://mamun.click/api/bookmark-item/delete/$categoryId";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        print("Deleted bookmark category");
        return response.statusCode;
      } else {
        print('Error');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
