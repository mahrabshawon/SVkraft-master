import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sv_craft/Features/home/home_screen.dart';
import 'package:sv_craft/common/bottom_button_column.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sv_craft/constant/color.dart';

import '../controllar/signup_controllar.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String initialCountry = 'BD';
  PhoneNumber number = PhoneNumber(isoCode: 'BD');
  var phone;
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var otpUser;
  bool _isloading = false;
  bool _poploading = false;
  bool _ischecked = true;
  bool _isbuttonactive = true;
  bool _isObscure = true;

  final _codeController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneNumberController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        Navigator.of(context).pop();

        UserCredential result = await _auth.signInWithCredential(credential);

        if (result.user != null) {
          var registerResponse = await register(
            phone.trim(),
            _userNameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );

          if (registerResponse.token != null) {
            setState(() {
              _poploading = false;
            });
            Navigator.of(context).pop();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          } else if (registerResponse.errorMessage != null) {
            setState(() {
              _isloading = false;
            });
            Navigator.of(context).pop();
            Get.snackbar(
              "Error",
              registerResponse.errorMessage!,
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.black38,
              colorText: Colors.white,
            );
          }
        }

        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (Exception exception) {
        print(exception);
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Container(
                color: Colors.white,
                child: AlertDialog(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  title: Text("Code Sent to\n ${phone}"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                        keyboardType:
                            const TextInputType.numberWithOptions(signed: true),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      !_poploading
                          ? FlatButton(
                              child: const Text("Confirm"),
                              textColor: Colors.black,
                              color: Colors.yellow,
                              onPressed: () async {
                                // setState(() {
                                //   _poploading = true;
                                // });
                                // String comingSms = (await AltSmsAutofill().listenForSms)!;
                                // String aStr =
                                //     comingSms.replaceAll(new RegExp(r'[^0-9]'), '');
                                // String otp = aStr.substring(0, 6);

                                // final code = otp;
                                // print(comingSms);

                                final code = _codeController.text.trim();
                                AuthCredential credential =
                                    PhoneAuthProvider.credential(
                                        verificationId: verificationId,
                                        smsCode: code);

                                UserCredential result = await _auth
                                    .signInWithCredential(credential);

                                if (result.user != null) {
                                  var registerResponse = await register(
                                    phone.trim(),
                                    _userNameController.text.trim(),
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );

                                  if (registerResponse.token != null) {
                                    // setState(() {
                                    //   _poploading = false;
                                    // });

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                    Navigator.of(context).pop();
                                  } else if (registerResponse.errorMessage !=
                                      null) {
                                    Navigator.of(context).pop();
                                    Get.snackbar(
                                      "Error",
                                      registerResponse.errorMessage!,
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.black38,
                                      colorText: Colors.white,
                                    );
                                  }
                                }
                              },
                            )
                          : Center(
                              child: const SpinKitThreeBounce(
                              color: Colors.black,
                              size: 24,
                            )),
                    ],
                  ),
                  // actions: <Widget>[

                  // ],
                ),
              );
            });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Time Out');
      },
    );
  }

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
                    height: size.height * 0.05,
                  ),
                  const Text(
                    "Getting Started",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Create an account to continue!",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                  ),
                  SizedBox(
                    height: 35,
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
                                      phone = number.phoneNumber;
                                      print(number.phoneNumber);
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
                                    initialValue: number,
                                    textFieldController: _phoneNumberController,
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
                          Text(
                            "Username",
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
                                controller: _userNameController,
                                decoration: const InputDecoration(
                                  //labelText: 'Username',
                                  hintText: "Username",
                                  prefixIcon: Icon(Icons.person_outline),
                                  border: InputBorder.none,
                                ),

                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (value.trim().length < 4) {
                                    return 'Username must be at least 4 characters in length';
                                  }
                                  // Return null if the entered username is valid
                                  return null;
                                },
                                //onChanged: (value) => _userName = value,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            "Email",
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
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  //labelText: 'Username',
                                  hintText: "Email",
                                  prefixIcon: Icon(Icons.email),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (!value.trim().contains("@")) {
                                    return 'Email must contain @ sign ';
                                  }
                                  // Return null if the entered username is valid
                                  return null;
                                },
                                //onChanged: (value) => _userName = value,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
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
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 20.0,
                                ),
                              ],
                            ),
                            child: Card(
                              child: TextFormField(
                                controller: _passwordController,
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
                          SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(_ischecked
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank),
                                onPressed: () {
                                  setState(() {
                                    _ischecked = !_ischecked;
                                    _isbuttonactive = !_isbuttonactive;
                                  });
                                  print(_ischecked);
                                },
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "By creating account, you are agree to our",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                  ),
                                  InkWell(
                                    child: Text("Term and Conditions"),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .05,
                  ),
                  !_isloading
                      ? Container(
                          alignment: Alignment.center,
                          width: size.width * 1,
                          height: size.height / 18,
                          decoration: BoxDecoration(
                            color: _isbuttonactive
                                ? Colors.yellow
                                : Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: _isbuttonactive
                                ? () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isloading = true;
                                      });
                                      await loginUser(phone, context);

                                      Future.delayed(Duration(seconds: 2), () {
                                        setState(() {
                                          _isloading = false;
                                        });
                                      });
                                    }
                                  }
                                : () => null,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: size.width * 0.25),
                                Text(
                                  "Sign Up",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                SizedBox(width: 30),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.black,
                                  size: 28.0,
                                  //weight: IconWeight.bold
                                ),
                              ],
                            ),
                          ),
                        )
                      // ? BottomButtonColumn(
                      //     onTap: _isbuttonactive
                      //         ? () async {
                      //             if (_formKey.currentState!.validate()) {
                      //               setState(() {
                      //                 _isloading = true;
                      //               });
                      //               await loginUser(phone, context);

                      //               Future.delayed(Duration(seconds: 2), () {
                      //                 setState(() {
                      //                   _isloading = false;
                      //                 });
                      //               });
                      //             }
                      //           }
                      //         : () => null,
                      //     buttonText: _isbuttonactive
                      //         ? "SIGN UP"
                      //         : "CHECK CONDITION BOX",
                      //     buttonIcon: Icons.login_outlined,
                      //   )
                      : Center(
                          child: const SpinKitThreeBounce(
                          color: Colors.black,
                          size: 24,
                        )),
                  SizedBox(
                    height: size.height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed('/signin');
                        },
                      ),
                    ],
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
