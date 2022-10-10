import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/profile/view/profile_screen.dart';

import '../../constant/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.put(HomeController());
  PageController? _pageController;
  var _selectedIndex = 0;

  late int userId;
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      setTokenToVariable();
    }); //.then((value) => _allProductController.GetAllProduct(tokenp))
  }

  Future<void> setTokenToVariable() async {
    final token = await _homeController.getToken();
    // print('token = ' + token);
    setState(() {
      _homeController.tokenGlobal = token;
    });

    final userid = await _homeController.getUserId();
    // print('token = ' + token);
    setState(() {
      _homeController.userId = userid;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                height: size.height * .09,
                width: size.width,
                color: Appcolor.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Color.fromARGB(232, 255, 217, 2),
                        highlightColor: Color.fromARGB(255, 153, 138, 3),
                        child: const Text(
                          'SV KRAFT',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "RobotoSlab",
                            fontSize: 34.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Image(
                      //   image: AssetImage('images/svkraft.png'),
                      //   height: size.height * .06,
                      //   width: size.width * .8,
                      // ),

                      // Text(
                      //   'SV Kraft',
                      //   style: TextStyle(
                      //       fontSize: 30,
                      //       fontWeight: FontWeight.w500,
                      //       color: Appcolor.uperTextColor),
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    height: size.height * .25,
                    width: size.width,
                    //color: const Color.fromARGB(255, 70, 192, 230),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 66, 163, 192),
                          Color.fromARGB(255, 253, 251, 250),
                        ],
                      ),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        const Text("Market Place",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 255, 255, 255))),
                        Spacer(),
                        Image.asset(
                          'images/market.png',
                          fit: BoxFit.cover,
                          width: 140,
                          height: size.height * .25,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('/marketplace');
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    height: size.height * .25,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 35, 117, 53),
                          Color.fromARGB(255, 253, 251, 250),
                        ],
                      ),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        const Text("Grocery",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 255, 255, 255))),
                        Spacer(),
                        Image.asset(
                          'images/grocery.png',
                          fit: BoxFit.cover,
                          width: 140,
                          height: size.height * .25,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed('/groceryproduct');
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    height: size.height * .25,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 158, 30, 105),
                          Color.fromARGB(255, 253, 251, 250),
                        ],
                      ),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text("Special Day",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 255, 255, 255))),
                        Spacer(),
                        Image.asset(
                          'images/special.png',
                          fit: BoxFit.cover,
                          width: 140,
                          height: size.height * .25,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Get.toNamed("/specialhome");
                  },
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Container(
                    height: size.height * .25,
                    width: size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(255, 145, 31, 42),
                          Color.fromARGB(255, 253, 251, 250),
                        ],
                      ),
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Restaurant",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                            const Text("(Comming soon)",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 255, 255, 255))),
                          ],
                        ),
                        Spacer(),
                        Image.asset(
                          'images/restaurant.png',
                          fit: BoxFit.cover,
                          width: 140,
                          height: size.height * .25,
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavyBar(
            backgroundColor: Appcolor.primaryColor,
            selectedIndex: _selectedIndex,
            showElevation: true,
            onItemSelected: (index) => setState(() {
              _selectedIndex = index;
              _pageController?.animateToPage(index,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);

              if (_selectedIndex == 0) {
                print("Home");
              } else if (_selectedIndex == 1) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              } else if (_selectedIndex == 2) {
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => ProfileScreen()),
                // );

              } else if (_selectedIndex == 3) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              }
            }),
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.white,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text('Cart'),
                  activeColor: Colors.white),
              BottomNavyBarItem(
                  icon: Icon(Icons.bookmark_border),
                  title: Text('Bookmarks'),
                  activeColor: Colors.white),
              BottomNavyBarItem(
                  icon: Icon(Icons.person),
                  title: Text('Profile'),
                  activeColor: Colors.white),
            ],
          )),
    );
  }
}
