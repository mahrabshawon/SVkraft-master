import 'dart:async';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/add_market_product/view/category_city.dart';
import 'package:sv_craft/Features/chat/view/recent_chats.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/controller/all_product_controller.dart';
import 'package:sv_craft/Features/market_place/controller/bookmark_con.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/model/all_product_model.dart';
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/view/bookmarked_product.dart';
import 'package:sv_craft/Features/market_place/view/category_product.dart';
import 'package:sv_craft/Features/market_place/view/filter_box_screen.dart';
import 'package:sv_craft/Features/market_place/view/market_product_details.dart';
import 'package:sv_craft/Features/market_place/view/search_product_screen.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';
import 'package:sv_craft/constant/color.dart';

class MarketPlace extends StatefulWidget {
  const MarketPlace({Key? key}) : super(key: key);

  @override
  State<MarketPlace> createState() => _MarketPlaceState();
}

class _MarketPlaceState extends State<MarketPlace> {
  final MarketCategoryController _marketCategoryController =
      Get.put(MarketCategoryController());
  final AllProductController _allProductController =
      Get.put(AllProductController());
  final HomeController _homeController = Get.put(HomeController());
  BookmarkController _bookmarkController = Get.put(BookmarkController());

  var _selectedIndex = 2;
  PageController? _pageController;

  final List<mCategory> _categoryList = [];
  var _categoryData;

  @override
  void initState() {
    super.initState();

    // Future.delayed(Duration.zero, () async {
    setTokenToVariable();
    // });
  }

  Future<void> setTokenToVariable() async {
    final responce = await _marketCategoryController
        .getmarketCategoryProduct(_homeController.tokenGlobal);
    _categoryList.clear();
    if (responce != null) {
      setState(() {
        _categoryData = responce;
      });
      for (var task in responce) {
        // _categoryList.name.add(task.categoryName);
        _categoryList.add(
          mCategory(
            categoryName: task.categoryName,
            image: task.image,
          ),
        );
      }
    }
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Market place page build");

    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AddCategoryCity(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
        backgroundColor: const Color.fromARGB(255, 143, 211, 231),
        appBar: AppBar(
            leadingWidth: 300,
            automaticallyImplyLeading: false,
            backgroundColor: Appcolor.primaryColor,
            elevation: 1,
            title: const Text('Market Place',
                style: TextStyle(
                    color: Appcolor.uperTextColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold)),
            actions: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Appcolor.iconColor,
                    size: 20,
                  ),
                  onPressed: () {
                    Get.off(() => const SearchProductScreen());
                  },
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Appcolor.iconShadowColor, //<-- SEE HERE
                child: IconButton(
                  icon: const Icon(
                    FontAwesome.sliders,
                    color: Appcolor.iconColor,
                    size: 20,
                  ),
                  onPressed: () async {
                    Get.off(() => const FilterBoxScreen());
                  },
                ),
              ),
              SizedBox(
                width: size.width * .02,
              ),
            ]),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              color: const Color.fromARGB(255, 143, 211, 231),
              height: 50,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: const [
                    Text('Today\'s Picks',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.normal)),
                    Spacer(),
                  ],
                ),
              ),
            ),
            _categoryData != null
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _categoryData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FutureBuilder<List<Datum>?>(
                          future: _allProductController.getCategoryProduct(
                              _homeController.tokenGlobal,
                              _categoryData[index].id),
                          builder: (context, snapshot) {
                            // print(
                            //     'matchCategory ${snapshot.data![0].category.categoryName}');

                            if (!snapshot.hasData || snapshot.data == null) {
                              return Center(
                                child: Container(),
                              );
                            } else {
                              if (snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('No Product Found'));
                              } else {
                                final data = snapshot.data;

                                return Column(
                                  children: [
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                _categoryData[index]
                                                    .categoryName,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            TextButton(
                                                onPressed: () {
                                                  Get.to(() => CategoryProduct(
                                                      categoryId:
                                                          _categoryData[index]
                                                              .id,
                                                      categoryName:
                                                          _categoryData[index]
                                                              .categoryName));
                                                },
                                                child: Text(
                                                  "View All",
                                                  style: TextStyle(
                                                      color: Appcolor
                                                          .primaryColor),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 30),
                                      itemCount:
                                          data!.length < 6 ? data.length : 6,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 200,
                                        childAspectRatio: .79,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 5,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) =>
                                              Container(
                                        // color: Colors.red,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors
                                                  .black12, //color of shadow
                                              spreadRadius: 1, //spread radius
                                              blurRadius: 1, // blur radius
                                              offset: Offset(1,
                                                  1), // changes position of shadow
                                            )
                                          ],
                                        ),

                                        child: InkWell(
                                          onTap: () {
                                            print("${data[index].id}");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MarketProductDetails(
                                                        id: data[index].id,
                                                        token: _homeController
                                                            .tokenGlobal,
                                                      )),
                                            );
                                          },
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                    child: Image.network(
                                                      data[index]
                                                                  .image[0]
                                                                  .filePath !=
                                                              null
                                                          ? 'http://mamun.click/${data[index].image[0].filePath}'
                                                          : "",
                                                      fit: BoxFit.cover,
                                                      height: 180,
                                                      width: 170,
                                                    ),
                                                  ),
                                                  Positioned(
                                                      top: 5,
                                                      left: 0,
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        color: Colors.white,
                                                        child: IconButton(
                                                          onPressed: () async {
                                                            var status = await _bookmarkController
                                                                .addBookmarkProduct(
                                                                    _homeController
                                                                        .tokenGlobal,
                                                                    data[index]
                                                                        .id);

                                                            if (status == 200) {
                                                              setState(() {});
                                                              Get.snackbar(
                                                                  'Success',
                                                                  'Product Added To Bookmark');
                                                            }
                                                          },
                                                          icon: data[index]
                                                                  .bookmark
                                                              ? const Icon(
                                                                  FontAwesome
                                                                      .bookmark_solid,
                                                                  color: Colors
                                                                      .blue,
                                                                  size: 18,
                                                                )
                                                              : const Icon(
                                                                  FontAwesome
                                                                      .bookmark,
                                                                  color: Colors
                                                                      .black,
                                                                  size: 18,
                                                                ),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                        '${data[index].price} Kr',
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal)),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    SizedBox(
                                                      width: size.width * .2,
                                                      child: Text(
                                                        data[index].productName,
                                                        softWrap: false,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 16.0),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                          });
                    })
                : Column(
                    children: [
                      SizedBox(
                        height: size.height * 0.4,
                      ),
                      const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  )
          ],
        )),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Appcolor.primaryColor,
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController?.animateToPage(index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease);

            if (_selectedIndex == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RecentChats()),
              );
            } else if (_selectedIndex == 2) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );

            } else if (_selectedIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookmarkedProductScreen()),
              );
            } else if (_selectedIndex == 4) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfileScreen(
                          from: "market",
                        )),
              );
            }
          }),
          items: [
            BottomNavyBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
              activeColor: Colors.white,
            ),
            BottomNavyBarItem(
                icon: const Icon(Icons.chat),
                title: const Text('Chat'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: const Icon(Icons.favorite),
                title: const Text(
                  'M. Place',
                  overflow: TextOverflow.ellipsis,
                ),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: const Icon(Icons.bookmark_border),
                title: const Text('Bookmarks'),
                activeColor: Colors.white),
            BottomNavyBarItem(
                icon: const Icon(Icons.person),
                title: const Text('Profile'),
                activeColor: Colors.white),
          ],
        ),
      ),
    );
  }
}
