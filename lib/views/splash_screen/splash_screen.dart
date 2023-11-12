import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner_project/custom_widgets/custom_text.dart';
import 'package:qr_scanner_project/views/language_screen/language_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _processingData(context),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SafeArea(
            child: Scaffold(
              body: Container(
                  padding: EdgeInsets.all(16.w),
                  width: 1.sw,
                  height: 1.sh,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Medicine Prescriber',
                        color: Colors.black,
                        fontSize: 32.sp,
                        fontW: FontWeight.bold,
                      ),
                      SizedBox(height: 8.w),
                      Image.asset(
                        "assets/images/logo.jpg",
                      )
                    ],
                  )),
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Future<void> _processingData(context) {
    return Future.delayed(const Duration(seconds: 3))
        .whenComplete(() => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LanguageScreen()),
              (route) => false,
            ));
  }
}
