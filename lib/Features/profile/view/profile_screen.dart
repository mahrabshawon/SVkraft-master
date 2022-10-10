import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/Features/cart/view/cart_screen.dart';
import 'package:sv_craft/Features/grocery/view/grocery_product.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/market_place/view/market_place.dart';
import 'package:sv_craft/Features/profile/controller/get_profile_con.dart';
import 'package:sv_craft/Features/profile/view/edit_profile.dart';
import 'package:sv_craft/Features/profile/view/my_address_screen.dart';
import 'package:sv_craft/Features/profile/view/my_adds.dart';
import 'package:sv_craft/Features/special_day/model/special_all_product_model.dart';
import 'package:sv_craft/Features/special_day/view/special_home_screen.dart';
import 'package:sv_craft/constant/color.dart';
import 'package:icons_plus/icons_plus.dart';
import '../controller/logout_controller.dart';
import 'custom_shape.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, this.from}) : super(key: key);

  final String? from;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final LogoutController _logoutController = Get.put(LogoutController());
  HomeController _homeController = Get.put(HomeController());
  GetProfileController _getProfileController = Get.put(GetProfileController());
  PageController? _pageController;
  var _selectedIndex = 4;
  var Profile;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(microseconds: 00), () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    var profile =
        await _getProfileController.getProfile(_homeController.tokenGlobal);
    if (profile != null) {
      setState(() {
        Profile = profile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: size.height * 0.08,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.8),
                borderRadius: BorderRadius.circular(0),
                image: DecorationImage(
                  // colorFilter: ColorFilter.mode(
                  //     Colors.grey.withOpacity(.8), BlendMode.dstATop),
                  image: AssetImage('images/sellercover.jpeg'),
                  fit: BoxFit.cover,
                  //Add color opacity
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/child.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.circle,
                        color: Colors.white),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: () async {
                        // var message = await _logoutController.logout(tokenp);
                        // print(message);
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.remove('auth-token');
                        await prefs.remove('user-id');

                        Get.offAll(() => SigninScreen());
                      },
                      icon: const Icon(
                        FontAwesome.power_off,
                        color: Colors.white,
                        size: 30,
                      )),
                ],
              ),
            ),
            Profile != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Card(
                        child: ListTile(
                          // tileColor: Colors.grey[200],
                          leading: const Icon(
                            Icons.person,
                            size: 25,
                          ),
                          title: Text(
                            Profile.name,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                      ),
                      // Divider(
                      //   color: Colors.black,
                      // ),
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.list_alt_outlined,
                            size: 25,
                          ),
                          title: const Text(
                            'My ads',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () async {
                            Get.to(MyAdds());
                          },
                        ),
                      ),

                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            size: 25,
                          ),
                          title: const Text(
                            'My Profile',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () async {},
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.card_membership,
                            size: 25,
                          ),
                          title: const Text(
                            'My Membership',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () async {
                            // Navigator.pop(context);
                            // _logoutController.logout();
                          },
                        ),
                      ),
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.calendar_month,
                            size: 25,
                          ),
                          title: const Text(
                            'Birthday',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () async {
                            // Navigator.pop(context);
                            // _logoutController.logout();
                          },
                        ),
                      ),

                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.transgender,
                            size: 25,
                          ),
                          title: const Text(
                            'Gender',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () async {
                            // Navigator.pop(context);
                            // _logoutController.logout();
                          },
                        ),
                      ),

                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.phone_android,
                            size: 25,
                          ),
                          title: Text(
                            Profile.phone,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                      ),

                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.email_rounded,
                            size: 25,
                          ),
                          title: Text(
                            Profile.email,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            // Navigator.pop(context);
                          },
                        ),
                      ),
                      // Divider(
                      //   color: Colors.black12,
                      //   thickness: 2,
                      // ),
                      Card(
                        child: ListTile(
                          leading: const Icon(
                            Icons.location_city_sharp,
                            size: 25,
                          ),
                          title: const Text(
                            'Address',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          onTap: () {
                            print("hhhhhhhhhhhhhh");
                            Get.to(MyAddressScreen());
                            // Get.to(MyAddressScreen);
                          },
                        ),
                      ),
                      // const Divider(
                      //   color: Colors.black12,
                      //   thickness: 2,
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * .45,
                      ),
                      Center(
                          child: Text("No User Found",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                    ],
                  ),
            SizedBox(
              height: size.height * .08,
            ),
          ],
        )),
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Appcolor.primaryColor,
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
            _pageController?.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);

            if (_selectedIndex == 0) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (_selectedIndex == 1) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            } else if (_selectedIndex == 2) {
              if (widget.from == "market") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MarketPlace()),
                );
              } else if (widget.from == "grocery") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GroceryProduct()),
                );
              } else if (widget.from == "special") {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SpecialHomeScreen()),
                );
              }
            } else if (_selectedIndex == 3) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );

            } else if (_selectedIndex == 4) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileScreen()),
              // );
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
                icon: Icon(Icons.shopping_bag),
                title: Text(''),
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
        ),
      ),
    );
  }
}
