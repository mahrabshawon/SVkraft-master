import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/profile/models/get_profile_model.dart';

class GetProfileController extends GetxController {
  Future<GetProfileDetailsData?> getProfile(String textToken) async {
    try {
      print('profileeeeeeeeee $textToken');
      var url = "http://mamun.click/api/profile";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      // print(response.body);
      if (response.statusCode == 200) {
        final allProduct = getProfileDetailsFromJson(response.body);

        print('Adresssssssssss ${allProduct.data.name}');

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
