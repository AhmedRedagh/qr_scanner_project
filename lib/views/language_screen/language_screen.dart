import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_scanner_project/custom_widgets/custom_button.dart';
import 'package:qr_scanner_project/custom_widgets/custom_text.dart';
import 'package:qr_scanner_project/views/qr_Scanner_screen/qr_scanner_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Widget? flag;
  String? country = 'Kuwait';

  final codePicker = const FlCountryCodePicker();
  String dropDownValue = 'Arabic';
  final List<String> list = [
    'Arabic',
    'English',
  ];

  void languageNavigator(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QrScannerScreen(language: dropDownValue),
      ),
    );
  }

  @override
  void initState() {
    flag = Image.asset(
      width: 20,
      fit: BoxFit.contain,
      'assets/flags/kw.png',
      package: 'fl_country_code_picker',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: EdgeInsets.all(16.w),
          width: 1.sw,
          height: 1.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: 'Choose Your Country',
                fontSize: 20.sp,
                color: Colors.black,
                fontW: FontWeight.w700,
              ),
              InkWell(
                onTap: () async {
                  final code = await codePicker.showPicker(
                    fullScreen: true,
                    context: context,
                  );
                  setState(() {
                    flag = code!.flagImage();
                    country = code.name;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black, width: 2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 32, width: 32, child: flag),
                      SizedBox(width: 16.w),
                      Center(
                          child: CustomText(
                        text: country,
                        fontSize: 20.sp,
                        fontW: FontWeight.bold,
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18.w),
              CustomText(
                text: 'Choose Your Language',
                fontSize: 20.sp,
                color: Colors.black,
                fontW: FontWeight.w700,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 2)),
                child: Center(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    padding: EdgeInsets.symmetric(horizontal: 100.w),
                    underline: const SizedBox(),
                    value: dropDownValue,
                    iconSize: 24,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.black,
                      size: 35,
                    ),
                    alignment: Alignment.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                    onChanged: (String? value) {
                      debugPrint(value);
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                    items: list.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Confirm',
                bgColor: Colors.black,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            QrScannerScreen(language: dropDownValue),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
