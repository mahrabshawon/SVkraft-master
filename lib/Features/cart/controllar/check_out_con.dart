import 'dart:convert';
import 'dart:ffi';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckoutController extends GetxController {
  checkout(var bodyData, int totalPrice, String textToken) async {
    //,
    try {
      http.Response response = await http
          .post(Uri.parse('http://mamun.click/api/order/checkout'), body: {
        'orders': bodyData.toString(),
        'total_price': totalPrice.toString(),
      }, headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        //data['message'];
        return response.statusCode;
      } else {
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

// import 'dart:convert';
// import 'dart:ffi';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class CheckoutController extends GetxController {
//   addTocart(int userId, int productId, String type, int quantity, int price,
//       String textToken) async {
//     try {
//       http.Response response =
//           await http.post(Uri.parse('http://mamun.click/api/cart/add'), body: {
//         'user_id': userId.toString(),
//         'product_id': productId.toString(),
//         'type': type.toString(),
//         'quantity': quantity.toString(),
//         'price': price.toString(),
//       }, headers: {
//         // 'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer $textToken',
//       });

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body.toString());

//         return data['message'];
//       } else {
//         print('failed');
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
