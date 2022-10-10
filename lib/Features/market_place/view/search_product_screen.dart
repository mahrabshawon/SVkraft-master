import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/market_search_controller.dart';
import 'package:sv_craft/Features/market_place/view/market_place.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';

class SearchProductScreen extends StatefulWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  State<SearchProductScreen> createState() => _SearchProductScreenState();
}

class _SearchProductScreenState extends State<SearchProductScreen> {
  final MarketSearchController _maeketSearchController =
      Get.put(MarketSearchController());
  HomeController _homeController = Get.put(HomeController());
  final TextEditingController _searchController = TextEditingController();

  var searchedData;

  Widget _searchTextField() {
    return TextFormField(
      controller: _searchController,
      onChanged: (_) async {
        final searchProduct =
            await _maeketSearchController.getmarketSearchProduct(
                _homeController.tokenGlobal, _searchController.text);

        if (searchProduct != null) {
          setState(() {
            searchedData = searchProduct;
          });
        }
      },
      autofocus: true,
      cursorColor: Colors.black,
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      textInputAction: TextInputAction.search,
      decoration: const InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
        enabledBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Appcolor.uperTextColor,
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    print("Search page build");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.off(MarketPlace());
            },
            icon: Icon(Icons.arrow_back)),
        title: _searchTextField(),
        // actions: [
        //   CircleAvatar(
        //     radius: 18,
        //     backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
        //     child: IconButton(
        //       icon: const Icon(
        //         Icons.clear,
        //         color: Appcolor.iconColor,
        //         size: 20,
        //       ),
        //       onPressed: () {
        //         setState(() {
        //           // Future.delayed(
        //           //     Duration(microseconds: 200), () async {});
        //           //searchedData = null;
        //           // _searchBoolean = false;
        //           //       _isSearched = false;
        //           _searchController.text = "";
        //           // _searchController.clear();
        //         });
        //       },
        //     ),
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            searchedData != null
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 20, bottom: 10),
                    itemCount: searchedData.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: .79,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                    ),
                    itemBuilder: (BuildContext context, int index) => Container(
                      // color: Colors.red,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38, //color of shadow
                            spreadRadius: 1, //spread radius
                            blurRadius: 1, // blur radius
                            offset: Offset(1, 1), // changes position of shadow
                          )
                        ],
                      ),

                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MarketProductDetails(
                                      id: searchedData[index].id,
                                      token: _homeController.tokenGlobal,
                                    )),
                          );
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Image.network(
                                '${Appurl.baseURL}${searchedData[index].image[0].filePath}',
                                fit: BoxFit.contain,
                                height: 180,
                                width: 170,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('${searchedData[index].price} Kr',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  SizedBox(
                                    width: _size.width * .2,
                                    child: Text(
                                      searchedData[index].productName,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Column(
                    children: [
                      SizedBox(
                        height: _size.height * .4,
                      ),
                      Center(child: Text('Search your product')),
                    ],
                  )
          ],
        ),
      ),
    ));
  }
}
