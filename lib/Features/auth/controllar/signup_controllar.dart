import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/common/typedefs.dart';

Future<RegisterResponse> register(
    String phone, username, email, password) async {
  Map data = {
    'email': email,
    'phone': phone,
    'password': password,
    'username': username,
  };

  String body = json.encode(data);
  var url = 'http://mamun.click/api/register';
  http.Response response = await http.post(
    Uri.parse(url),
    body: body,
    headers: {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Access-Control-Allow-Origin": "*"
    },
  );

  //((jsonDecode(response.body) as JSON)['success'] as bool) == true

  if (response.statusCode == 200) {
    final token = (jsonDecode(response.body) as JSON)['data']['token'];
    final userId = (jsonDecode(response.body) as JSON)['data']['user']['id'];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth-token', token);
    await prefs.setInt('user-id', userId);

    // return response.statusCode.toString();
    return RegisterResponse(token: token, errorMessage: null);
  } else {
    //print('failed');
    return RegisterResponse(
      token: null,
      errorMessage:
          (jsonDecode(response.body) as Map<String, dynamic>)['message']
              .toString(),
    );
  }
}

class RegisterResponse {
  final String? token;
  final String? errorMessage;

  RegisterResponse({required this.token, required this.errorMessage});
}
