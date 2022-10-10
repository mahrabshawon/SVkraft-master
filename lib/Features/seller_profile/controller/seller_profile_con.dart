import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/seller_profile/models/seller_profile_model.dart';

class ShowSellerProfileController extends GetxController {
  Future<SellerProfile?> getSellerProfileProduct(
    String textToken,
    int sellerId,
  ) async {
    try {
      var url = "http://mamun.click/api/product/user/$sellerId";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final sellerProfile = sellerProfileFromJson(response.body);

        //print('proooooooooooooooooooo ${sellerProfile.data.toString()}');

        return sellerProfile;
      } else {
        print('Seller not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
