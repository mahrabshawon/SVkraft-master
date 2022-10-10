import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/market_place/controller/dproduct_details_controller.dart';
import 'package:sv_craft/Features/market_place/model/product_details.dart';
import 'package:sv_craft/Features/seller_profile/view/profile.dart';
import 'package:sv_craft/constant/api_link.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:url_launcher/url_launcher.dart';

class MarketProductDetails extends StatefulWidget {
  const MarketProductDetails({
    Key? key,
    required this.id,
    required this.token,
    this.from,
  }) : super(key: key);
  final int id;
  final String token;
  final String? from;

  @override
  State<MarketProductDetails> createState() => _MarketProductDetailsState();
}

class _MarketProductDetailsState extends State<MarketProductDetails> {
  final ProductDetailsController _productDetailsController =
      Get.put(ProductDetailsController());

  final List<String> imagesList = [];
  var userId = 0.obs;
  var phone = ''.obs;
  var _selectedIndex = 0;
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Market derails page build");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: FutureBuilder<ProductDetailsData?>(
              future: _productDetailsController.getProductDetails(
                  widget.token, widget.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: size.height * .4,
                      ),
                      const Center(
                          child: SpinKitFadingCircle(
                        color: Colors.black,
                      )),
                    ],
                  );
                } else {
                  if (snapshot.data == null) {
                    return const Center(
                        child: Center(
                            child: SpinKitFadingCircle(
                      color: Colors.black,
                    )));
                  } else {
                    final data = snapshot.data;
                    print("userId ${data!.userId}");
                    userId.value = data.userId;
                    phone.value = data.phone;

                    for (int i = 0; i < data.image.length; i++) {
                      imagesList
                          .add("${Appurl.baseURL}${data.image[i].filePath}");
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: size.width * 0.05,
                              ),
                              Container(
                                width: size.width * 0.9,
                                child: Text(
                                  data.productName,
                                  style: const TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          Image.network(
                            '${Appurl.baseURL}${data.image[0].filePath}',
                            fit: BoxFit.cover,
                            height: size.height * 0.4,
                            width: size.width * 0.8,
                          ),
                          SizedBox(
                            height: size.height * 0.05,
                          ),

                          //CarouselSlider
                          CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              height: size.width * .2,
                              aspectRatio: 16 / 15,
                              viewportFraction: .3,
                              enlargeCenterPage: true,
                            ),
                            items: imagesList
                                .map(
                                  (item) => Center(
                                    child: Image.network(
                                      item,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),

                          Container(
                            padding: const EdgeInsets.all(20),
                            //height: size.height * 0.5,
                            width: size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Description',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.normal)),
                                Html(
                                  data: data.description,
                                  style: {
                                    "html": Style(
                                      color: Colors.black,
                                    ),
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text('Price : ${data.price} kr',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Qunatity : ${data.quantity}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Condition : ${data.condition}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('Brand : ${data.brand}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  }
                }
              }),
        ),
        bottomNavigationBar: widget.from == null
            ? BottomAppBar(
                elevation: 0,
                child: Container(
                  height: 60,
                  width: double.maxFinite, //set your width here
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(0.0))),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          var url = Uri.parse("tel:$phone");
                          await launchUrl(url);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Appcolor.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12, //color of shadow
                                spreadRadius: 2, //spread radius
                                blurRadius: 5, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ],
                          ),
                          width: 180,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Call Seller',
                                style: TextStyle(
                                    color: Appcolor.uperTextColor,
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SellerProfile(
                                sellerId: (userId.toInt()),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Appcolor.buttonColor,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12, //color of shadow
                                spreadRadius: 2, //spread radius
                                blurRadius: 5, // blur radius
                                offset:
                                    Offset(0, 2), // changes position of shadow
                              )
                            ],
                          ),
                          width: 180,
                          height: 45,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Show Profile',
                                style: TextStyle(
                                    color: Appcolor.textColor, fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //add as many tabs as you want here
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: 0,
              ),
      ),
    );
  }
}
