import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/market_place/controller/category_controller.dart';
import 'package:sv_craft/Features/market_place/controller/city_controller.dart';
import 'package:sv_craft/Features/market_place/model/market_category.dart';
import 'package:sv_craft/Features/market_place/view/market_filter.dart';
import 'package:sv_craft/constant/color.dart';

class FilterBoxScreen extends StatefulWidget {
  const FilterBoxScreen({Key? key}) : super(key: key);

  @override
  State<FilterBoxScreen> createState() => _FilterBoxScreenState();
}

class _FilterBoxScreenState extends State<FilterBoxScreen> {
  final MarketCategoryController _marketCategoryController =
      Get.put(MarketCategoryController());
  final MarketCityController _cityController = Get.put(MarketCityController());
  HomeController _homeController = Get.put(HomeController());

  final TextEditingController _cityNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final List<mCategory> _categoryList = [];
  final List<String> _city = [];
  final _formKey = GlobalKey<FormState>();
  String? selectedCategory;
  String? selectedCity;
  String? selectedPrice;
  var _categoryData;

  final List<mCategory> _priceRan = [
    mCategory(icon: Icons.file_upload_sharp, categoryName: "Highest"),
    mCategory(icon: Icons.file_download, categoryName: "Lowest"),
    mCategory(icon: Icons.plus_one, categoryName: "Newest"),
    mCategory(
        icon: Icons.remove_circle_outline_rounded, categoryName: "Oldest"),
  ];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      await setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    //market city
    final city =
        await _cityController.getmarketCity(_homeController.tokenGlobal);

    _city.clear();
    if (city != null) {
      for (var task in city) {
        _city.add(task.name);
      }
    }

    //market category

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

    // setState(() {
    //   _showfilter = true;
    // });
  }

  @override
  dispose() {
    _cityNameController.dispose();
    _categoryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Market filter box page build");
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Market Place"),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'Filter with',
                    style: TextStyle(
                        color: Appcolor.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('CATEGORY',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    onChanged: (value2) {
                      setState(() {
                        selectedCategory = value2!;

                        //showToast();
                      });
                    },
                    value: selectedCategory,

                    hint: Center(
                        child: Text(
                      selectedCategory ?? 'Select Category',
                      style: TextStyle(color: Colors.white),
                    )),

                    // Hide the default underline
                    underline: Container(),
                    // set the color of the dropdown menu
                    dropdownColor: Colors.white,
                    icon: Icon(
                      FontAwesome.chevron_down,
                      color: Colors.white,
                    ),
                    isExpanded: true,

                    items: _categoryList.map((item) {
                      if (item.categoryName == selectedCategory) {
                        return DropdownMenuItem(
                          value: item.categoryName,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 48.0,
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Image.network(
                                    "http://mamun.click/${item.image}",
                                    height: 20,
                                    width: 20,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(item.categoryName),
                                ),
                              )),
                        );
                      } else {
                        return DropdownMenuItem(
                          value: item.categoryName,
                          child: ListTile(
                            leading: Image.network(
                              "http://mamun.click/${item.image}",
                              height: 20,
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                            title: Text(item.categoryName),
                          ),
                        );
                      }
                    }).toList(),

                    // Customize the selected item
                    selectedItemBuilder: (BuildContext context) =>
                        _categoryList.map((e) {
                      return Center(
                        child: Text(
                          e.categoryName,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('PLATS',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    onChanged: (value2) {
                      setState(() {
                        selectedCity = value2!;

                        //showToast();
                      });
                    },
                    value: selectedCity,

                    hint: Center(
                        child: Text(
                      selectedCity ?? 'Select City',
                      style: TextStyle(color: Colors.white),
                    )),

                    // Hide the default underline
                    underline: Container(),
                    // set the color of the dropdown menu
                    dropdownColor: Colors.white,
                    focusColor: Colors.red,

                    icon: const Icon(
                      FontAwesome.chevron_down,
                      color: Colors.white,
                    ),
                    isExpanded: true,

                    items: _city.map((item) {
                      if (item == selectedCity) {
                        return DropdownMenuItem(
                          value: item,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 48.0,
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: Appcolor.primaryColor,
                                  ),
                                  title: Text(
                                    item,
                                  ),
                                ),
                              )),
                        );
                      } else {
                        return DropdownMenuItem(
                          value: item,
                          child: ListTile(
                            leading: Icon(
                              Icons.location_on,
                              color: Appcolor.primaryColor,
                            ),
                            title: Text(
                              item,
                            ),
                          ),
                        );
                      }
                    }).toList(),

                    // Customize the selected item
                    selectedItemBuilder: (BuildContext context) =>
                        _city.map((e) {
                      return Center(
                        child: Text(
                          e,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text('Price Range',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.normal)),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Appcolor.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: DropdownButton<String>(
                    onChanged: (value2) {
                      setState(() {
                        selectedPrice = value2!;

                        //showToast();
                      });
                    },
                    value: selectedPrice,

                    hint: Center(
                        child: Text(
                      selectedPrice ?? 'Select Price',
                      style: TextStyle(color: Colors.white),
                    )),

                    // Hide the default underline
                    underline: Container(),
                    // set the color of the dropdown menu
                    dropdownColor: Colors.white,
                    icon: const Icon(
                      FontAwesome.chevron_down,
                      color: Colors.white,
                    ),
                    isExpanded: true,

                    items: _priceRan.map((item) {
                      if (item.categoryName == selectedPrice) {
                        return DropdownMenuItem(
                          value: item.categoryName,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)),
                              height: 48.0,
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: ListTile(
                                  leading: Icon(item.icon),
                                  title: Text(item.categoryName),
                                ),
                              )),
                        );
                      } else {
                        return DropdownMenuItem(
                          value: item.categoryName,
                          child: ListTile(
                            leading: Icon(item.icon),
                            title: Text(item.categoryName),
                          ),
                        );
                      }
                    }).toList(),

                    // Customize the selected item
                    selectedItemBuilder: (BuildContext context) =>
                        _priceRan.map((e) {
                      return Center(
                        child: Text(e.categoryName,
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold)),
                        // child: Text(
                        //   e.categoryName,
                        //   style: const TextStyle(
                        //       fontSize: 18,
                        //       color: Colors.white,
                        //       fontStyle: FontStyle.italic,
                        //       fontWeight: FontWeight.bold),
                        // ),
                      );
                    }).toList(),
                  ),
                ),
                //const SizedBox(
                //   height: 20,
                // ),

                // RadioListTile(
                //   title: Text("Highest Price"),
                //   value: "highest",
                //   groupValue: priceRange,
                //   onChanged: (value) {
                //     setState(() {
                //       priceRange = value.toString();
                //       print(priceRange);
                //     });
                //   },
                // ),

                // RadioListTile(
                //   title: Text("Lowest Price"),
                //   value: "lowest",
                //   groupValue: priceRange,
                //   onChanged: (value) {
                //     setState(() {
                //       priceRange = value.toString();
                //       print(priceRange);
                //     });
                //   },
                // ),
                SizedBox(
                  height: 50,
                ),

                //Filter button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 1,
                    height: size.height / 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Appcolor.buttonColor),
                    child: TextButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          if (selectedCategory != null &&
                              selectedCity != null &&
                              selectedPrice != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MarketFilter(
                                      token: _homeController.tokenGlobal,
                                      selectedCategory: selectedCategory!,
                                      cityName: selectedCity!,
                                      priceRange: selectedPrice)),
                            );
                            // _category.clear();
                          } else {
                            Get.snackbar(
                              "Please select all fields",
                              "",
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          // SizedBox(width: size.width * 0.15),
                          Text(
                            'Filter',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Appcolor.textColor),
                          ),
                          // SizedBox(width: 30),
                          // const Icon(
                          //   FontAwesome.sliders,
                          //   color: Colors.white,
                          //   size: 20.0,
                          //   //weight: IconWeight.bold
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // barrierColor: Colors.white,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(0),
          //   //side: BorderSide(width: 5, color: Colors.black),
          // ),
        ],
      ),
    ));
  }
}
