import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddtoBookmarksController extends GetxController {
  addToBookmarks(
      int userid, int productId, String type, String textToken) async {
    try {
      http.Response response = await http
          .post(Uri.parse('http://mamun.click/api/add-to-bookmark'), body: {
        'user_id': userid.toString(),
        'product_id': productId.toString(),
        'type': type.toString(),
      }, headers: {
        // 'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());

        return data['message'];
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
