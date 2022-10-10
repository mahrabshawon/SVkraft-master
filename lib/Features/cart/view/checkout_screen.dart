import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/add_market_product/view/widgets/custom_textfield.dart';
import 'package:sv_craft/Features/cart/controllar/cart_summary_con.dart';
import 'package:sv_craft/Features/cart/controllar/final_checkout_con.dart';
import 'package:sv_craft/Features/home/controller/home_controller.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/Features/profile/controller/get_address_con.dart';
import 'package:sv_craft/Features/profile/view/address_page.dart';
import 'package:sv_craft/constant/color.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final GetAddressController _getAddressController =
      Get.put(GetAddressController());
  final HomeController _homeController = Get.put(HomeController());
  final GetCartSummaryController _getCartSummaryController =
      Get.put(GetCartSummaryController());
  final FinalCheckoutController _finalCheckoutController =
      Get.put(FinalCheckoutController());
  TextEditingController _greetingsController = TextEditingController();
  var Address;
  var CartSummary;
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(microseconds: 500), () async {
      setTokenToVariable();
    });
  }

  Future<void> setTokenToVariable() async {
    var address =
        await _getAddressController.getAddress(_homeController.tokenGlobal);
    if (address != null) {
      setState(() {
        Address = address;
      });
    }

    var cartSummary = await _getCartSummaryController
        .getCartSummary(_homeController.tokenGlobal);
    if (cartSummary != null) {
      setState(() {
        CartSummary = cartSummary;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: true,
              title: const Text('SV KRAFT'),
            ),
            body: Address != null && CartSummary != null
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Container(
                        width: size.width * 0.9,
                        // color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    'CHECKOUT',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Card(
                                shadowColor: Colors.grey,
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            '${Address.name}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Appcolor.primaryColor),
                                          ),
                                          const Spacer(),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AddressScreen(
                                                              from: "checkout",
                                                            )));
                                              },
                                              child: Text(
                                                'Edit',
                                                style: TextStyle(
                                                    color:
                                                        Appcolor.primaryColor,
                                                    fontSize: 16),
                                              ))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.08,
                                          ),
                                          Container(
                                            width: size.width * 0.7,
                                            child: Text(
                                              '${Address!.house}, ${Address!.colony}, ${Address!.city}, ${Address!.area}, ${Address!.address}',
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.phone,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            '${Address!.phone}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Appcolor.primaryColor),
                                          ),
                                        ],
                                      ),
                                      // const SizedBox(
                                      //   height: 15,
                                      // ),
                                      // Row(
                                      //   children: [
                                      //     const Icon(
                                      //       Icons.email_outlined,
                                      //       color: Colors.blue,
                                      //     ),
                                      //     SizedBox(
                                      //       width: 10,
                                      //     ),
                                      //     const Text(
                                      //       'user@gmail.com',
                                      //       style: TextStyle(
                                      //           fontSize: 18,
                                      //           fontWeight: FontWeight.normal,
                                      //           color: Appcolor.primaryColor),
                                      //     ),
                                      //   ],
                                      // ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                shadowColor: Colors.grey,
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Order Summary',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Appcolor.primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${CartSummary.totalItem} Items',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Appcolor.primaryColor),
                                          ),
                                          Spacer(),
                                          Text(
                                            '${CartSummary.totalPrice} kr',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Appcolor.primaryColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Delivery Fee',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Appcolor.primaryColor),
                                          ),
                                          Spacer(),
                                          Text(
                                            '${CartSummary.shippingCharge} kr',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Appcolor.primaryColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            'Total',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Appcolor.primaryColor),
                                          ),
                                          Spacer(),
                                          // var finalPrice = CartSummary.totalPrice + CartSummary.shippingCharge;
                                          Text(
                                            '${CartSummary.totalPrice + CartSummary.shippingCharge} kr',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: Appcolor.primaryColor),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Card(
                                shadowColor: Colors.grey,
                                elevation: 2,
                                child: TextFormField(
                                  controller: _greetingsController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: "Greetings",
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.grey,
                                    )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.grey,
                                    )),
                                  ),
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Enter your greetings';
                                    }
                                    return null;
                                  },
                                  maxLines: 6,
                                ),
                              ),
                              // Card(
                              //   shadowColor: Colors.grey,
                              //   elevation: 2,
                              //   child: CustomTextField(
                              //     controller: _greetingsController,
                              //     hintText: 'Greetings',
                              //     maxLines: 6,
                              //   ),
                              // ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: size.width * .6,
                                    height: size.height / 18,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextButton(
                                      onPressed: () async {
                                        var status =
                                            await _finalCheckoutController
                                                .finalCheckout(_homeController
                                                    .tokenGlobal);

                                        if (status == 200) {
                                          Get.snackbar("Order Placed", "",
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor: Colors.black38,
                                              colorText: Colors.white);
                                          Get.offAll(() => HomeScreen());
                                        } else {
                                          Get.snackbar("Order Failed", "",
                                              snackPosition: SnackPosition.TOP,
                                              backgroundColor: Colors.black38,
                                              colorText: Colors.white);
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Text(
                                            "PLACE ORDER",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Colors.black),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
