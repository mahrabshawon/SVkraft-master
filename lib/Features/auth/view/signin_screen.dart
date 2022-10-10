import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sv_craft/Features/home/bottom_bar.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/common/bottom_button_column.dart';

import '../controllar/signin_controllar.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final SigninController _signinController = Get.put(SigninController());
  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isloading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    size: 30,
                    color: Colors.black,
                  ),
                  Text(
                    "XYZ",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.10,
                  ),
                  const Text(
                    "Let’s Sign You In",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome back, you’ve been missed!",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),

                  //fffffffffffffffffffffffffff
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Phone Number",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Container(
                                height: size.height / 15,
                                width: size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: InternationalPhoneNumberInput(
                                    onInputChanged: (PhoneNumber number) {
                                      _signinController.phone =
                                          number.phoneNumber;
                                      // print(number.phoneNumber);
                                      // setState(() {
                                      //   phone = number.phoneNumber;
                                      // });
                                    },
                                    onInputValidated: (bool value) {
                                      print(value);
                                    },
                                    selectorConfig: const SelectorConfig(
                                      selectorType:
                                          PhoneInputSelectorType.BOTTOM_SHEET,
                                    ),
                                    ignoreBlank: false,
                                    autoValidateMode: AutovalidateMode.disabled,
                                    selectorTextStyle:
                                        const TextStyle(color: Colors.black),
                                    initialValue: _signinController.number,
                                    textFieldController: phoneNumberController,
                                    formatInput: false,
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                      signed: true,
                                      decimal: true,
                                    ),
                                    // validator: (v) => v!.isEmpty
                                    //     ? "Field Can't be Empty"
                                    //     : null,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'This field is required';
                                      }
                                      if (value.trim().length < 9) {
                                        return 'Number must be at least 11 characters in length';
                                      }
                                      // Return null if the entered username is valid
                                      return null;
                                    },
                                    inputBorder: InputBorder.none,
                                    onSaved: (PhoneNumber number) {
                                      print('On Saved: $number');
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey.withOpacity(0.8),
                            ),
                            textAlign: TextAlign.left,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            child: Card(
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: '* * * * * *',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(_isObscure
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _isObscure = !_isObscure;
                                      });
                                      print(_isObscure);
                                    },
                                  ),
                                  border: InputBorder.none,
                                ),
                                obscureText: _isObscure,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (value.trim().length < 8) {
                                    return 'Password must be at least 8 characters in length';
                                  }
                                  // Return null if the entered password is valid
                                  return null;
                                },
                                //onChanged: (value) => _userName = value,
                              ),
                            ),
                          ),

                          /// Password

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .20,
                  ),

                  !_isloading
                      ? BottomButtonColumn(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isloading = true;
                              });
                              var loginResponse = await _signinController.login(
                                _signinController.phone.trim(),
                                passwordController.text.trim(),
                              );
                              if (loginResponse.token != null) {
                                setState(() {
                                  _isloading = false;
                                });
                                Get.offAll(() => const HomeScreen());
                              } else if (loginResponse.errorMessage != null) {
                                setState(() {
                                  _isloading = false;
                                });
                                Get.snackbar(
                                  "Error",
                                  loginResponse.errorMessage!,
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.black38,
                                  colorText: Colors.white,
                                );
                              }
                            }
                          },
                          buttonText: "SIGN IN",
                          buttonIcon: Icons.login_outlined,
                        )
                      : Center(
                          child: const SpinKitThreeBounce(
                          color: Colors.black,
                          size: 24,
                        )),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/signup');
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    child: Center(
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onTap: () {
                      Get.toNamed('/forgatepass');
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
