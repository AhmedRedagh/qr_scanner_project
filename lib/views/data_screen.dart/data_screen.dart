import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:qr_scanner_project/custom_widgets/custom_text.dart';
import 'package:qr_scanner_project/views/qr_Scanner_screen/qr_scanner_screen.dart';

class DataScreen extends StatefulWidget {
  final String dataFromQr, language;
  const DataScreen(
      {super.key, required this.dataFromQr, required this.language});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String? medicine;
  final FlutterTts flutterTts = FlutterTts();

  arabicInit() async {
    await flutterTts.setLanguage('ar');
    setState(() {});
  }

  readDataFromExcel() async {
    ByteData data = await rootBundle.load('assets/medicine.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table]!.maxColumns);
      print(excel.tables[table]!.maxRows);
      debugPrint(widget.language);
      for (var row in excel.tables[table]!.rows) {
        if (widget.dataFromQr == row[0]!.value.toString()) {
          setState(() {
            medicine = widget.language == 'English'
                ? row[1]!.value.toString()
                : row[2]!.value.toString();
          });
        }
      }
    }
  }

  @override
  void initState() {
    readDataFromExcel();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (medicine != null) {
      flutterTts.speak(
          '${widget.language == 'English' ? 'Your Medicine is' : 'دوائك  يكون'} $medicine!');
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => QrScannerScreen(
                      language: widget.language,
                    )),
            (route) => false);
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text(
        //     'Data Screen ',
        //   ),
        //   centerTitle: true,
        // ),
        body: Container(
          padding: EdgeInsets.all(16.w),
          width: 1.sw,
          height: 1.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 1.sw,
                    height: 200.w,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20.r)),
                    child: Column(
                      children: [
                        CustomText(
                          text: widget.language == 'English'
                              ? '( Your Medicine is )'
                              : '( دوائك  يكون )',
                          color: Colors.white,
                          fontSize: 25,
                          fontW: FontWeight.bold,
                        ),
                        SizedBox(height: 20.w),
                        CustomText(
                          text: medicine,
                          maxLine: 5,
                          textAlign: TextAlign.center,
                          fontSize: 16.sp,
                          fontW: FontWeight.w300,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 140.w),
                    width: 1.sw,
                    height: 200.w,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Image.asset('assets/images/medicine.png')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
