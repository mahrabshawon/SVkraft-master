import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/model/market_city_model.dart';

class MarketCityController extends GetxController {
  Future<List<MarketCitiesData>?> getmarketCity(String textToken) async {
    try {
      const url = "http://mamun.click/api/get-cities";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        final marketCategory = marketCitiesFromJson(response.body);
        return marketCategory.data;
      } else {
        print('City not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
