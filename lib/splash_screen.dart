import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sv_craft/Features/auth/view/signin_screen.dart';
import 'package:sv_craft/common/bottom_button.dart';

import 'package:sv_craft/constant/color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              top: size.height * 0.04,
              left: size.width * 0.70,
              //bottom: 447,
              child: Container(
                height: 305,
                width: 305,
                decoration: const BoxDecoration(
                  color: Appcolor.circleColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.35,
              left: size.width * -0.3,
              //bottom: 447,
              child: Container(
                height: 205,
                width: 205,
                decoration: const BoxDecoration(
                  color: Appcolor.circleColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              // top: size.height * 0.35,
              left: size.width * 0.22,
              bottom: size.height * 0.16,
              child: Column(
                children: [
                  const Text(
                    "Welcome to Sv kraft !",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "With long experience in the industry,\nwe create the best option for you.",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey.withOpacity(0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 48),
                ],
              ),
            ),
            BottomButton(
              onTap: () {
                Get.toNamed("/signin");
              },
              buttonText: "GET STARTED",
              buttonIcon: Icons.arrow_right_alt_rounded,
              top: size.height * 0.83,
              left: 35,
              right: 35,
              bottom: size.height * 0.08,
            )
          ],
        ),
      ),
    );
  }
}
