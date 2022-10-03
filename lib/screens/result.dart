import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scan/screens/exit.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:share_plus/share_plus.dart';

import 'package:url_launcher/url_launcher_string.dart';

class ScanResult extends StatefulWidget {
  ScanResult({Key? key, required this.barcode}) : super(key: key);
  String? barcode;

  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Text Result",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white70,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: Text(
                  widget.barcode!.toString(),
                  style: TextStyle(
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       Clipboard.setData(
                  //           ClipboardData(text: widget.barcode.toString()));
                  //     });
                  //   },
                  //   child: SizedBox(
                  //     width: 100.w,
                  //     height: 30.h,
                  //     child: TextButton(
                  //         style: TextButton.styleFrom(
                  //           backgroundColor: Colors.blue,
                  //           foregroundColor: Colors.white,
                  //           enableFeedback: true,
                  //         ),
                  //         onPressed: () {},
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             Text("Copy"),
                  //             Icon(
                  //               Icons.copy,
                  //               size: 18.h,
                  //             ),
                  //           ],
                  //         )),
                  //   ),
                  // ),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          Clipboard.setData(
                              ClipboardData(text: widget.barcode.toString()));
                        });
                      },
                      child: Text("Copy")),
                  // GestureDetector(
                  //   onTap: () {
                  //     setState(() {
                  //       Share.share(widget.barcode.toString());
                  //     });
                  //   },
                  //   child: SizedBox(
                  //     width: 100.w,
                  //     height: 30.h,
                  //     child: TextButton(
                  //         style: TextButton.styleFrom(
                  //           backgroundColor: Colors.blue,
                  //           foregroundColor: Colors.white,
                  //           enableFeedback: true,
                  //         ),
                  //         onPressed: () {},
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             Text("Share"),
                  //             Icon(
                  //               Icons.share,
                  //               size: 18.h,
                  //             ),
                  //           ],
                  //         )),
                  //   ),
                  // ),
                  OutlinedButton(
                      onPressed: () {
                        setState(() {
                          Share.share(widget.barcode.toString());
                        });
                      },
                      child: Text("share")),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              OutlinedButton(
                  onPressed: () {
                    setState(() {
                      launchUrlString(widget.barcode.toString());
                      // Utils.lauchURl(widget.barcode.toString());
                    });
                  },
                  child: Text("Open in Browser")),
              // GestureDetector(
              //   onTap: () {
              //     Utils.lauchURl(widget.barcode.toString());
              //   },
              //   child: SizedBox(
              //     width: 150.w,
              //     height: 30.h,
              //     child: TextButton(
              //         style: TextButton.styleFrom(
              //           backgroundColor: Colors.blue,
              //           foregroundColor: Colors.white,
              //           enableFeedback: true,
              //         ),
              //         onPressed: () {},
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           children: [
              //             Text("Open in Browser"),
              //             Icon(
              //               Icons.open_in_new,
              //               size: 18.h,
              //             )
              //           ],
              //         )),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class Utils {
  static Future<bool> lauchURl(String code) async {
    if (await canLaunchUrlString(code)) {
      await launchUrlString(code, mode: LaunchMode.externalApplication);
      return true;
    } else {
      return false;
    }
  }
}
