import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/model/auth_user.dart';

class SigninController extends GetxController {
  final _formKey = GlobalKey<FormState>();

  final _formKeyP = GlobalKey<FormState>();

  String initialCountry = 'BD';

  PhoneNumber number = PhoneNumber(isoCode: 'BD');

  var phone;

  Future<LoginResponse> login(String phone, password) async {
    var tokenid;
    var userid;
    Map data = {
      'phone': phone,
      'password': password,
    };
    print(data);

    String body = json.encode(data);
    var url = 'http://mamun.click/api/login';

    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*"
      },
    );
    // print("#############################");
    // print(response.body);

    if (response.statusCode == 200) {
      final token = authUserFromJson(response.body);

      tokenid = token.data.token;
      userid = token.data.user.id;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth-token', tokenid);
      await prefs.setInt('user-id', userid);

      return LoginResponse(token: tokenid, errorMessage: null);
    } else {
      //print('failed');
      return LoginResponse(
        token: null,
        errorMessage:
            (jsonDecode(response.body) as Map<String, dynamic>)['message']
                .toString(),
      );
    }

//    return tokenid;
  }
}

class LoginResponse {
  final String? token;
  final String? errorMessage;

  LoginResponse({required this.token, required this.errorMessage});
}
