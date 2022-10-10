import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/model/market_search.dart';

class MarketSearchController extends GetxController {
  Future<List<mSearch>?> getmarketSearchProduct(String textToken, name) async {
    try {
      var url = "http://mamun.click/api/search/product/$name";

      http.Response response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $textToken',
      });

      if (response.statusCode == 200) {
        final marketSearch = marketSearchFromJson(response.body);

        return marketSearch.data;
      } else {
        print('Search not found');
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
