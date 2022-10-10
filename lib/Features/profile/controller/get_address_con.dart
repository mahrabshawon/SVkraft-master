import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/profile/models/get_address_model.dart';

class GetAddressController extends GetxController {
  Future<Address?> getAddress(String textToken) async {
    try {
      print('product id $textToken');
      var url = "http://mamun.click/api/shipping-address/get";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = getAddressFromJson(response.body);
        return allProduct.data;
      } else {
        print('User not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
