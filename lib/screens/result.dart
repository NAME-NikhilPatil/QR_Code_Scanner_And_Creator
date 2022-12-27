import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';
import 'package:qr_code_scan/screens/exit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../components/bottom_navigation.dart';
import '../model/saved_setting.dart';

class ScanResult extends StatefulWidget {
  ScanResult({Key? key, required this.barcode, this.formate}) : super(key: key);
  String? barcode;
  String? formate;
  @override
  State<ScanResult> createState() => _ScanResultState();
}

class _ScanResultState extends State<ScanResult> {
  bool click = false;

  @override
  void initState() {
    super.initState();
    // click = Provider.of<ScanData>(context, listen: false).click;
    click = SaveSetting.getSwitch() ??
        Provider.of<ScanData>(context, listen: false).click;

    click == true ? updateButton() : null;
  }

  done() {
    Timer.periodic(const Duration(seconds: 7), (Timer t) {
      setState(() {
        click = false;
        t.cancel();
      });
    });
  }

  updateButton() {
    setState(() {
      Clipboard.setData(
        ClipboardData(
          text: widget.barcode.toString(),
        ),
      );
      click = true;
      // Provider.of<ScanData>(context,listen: false).updateClick(true);
      done();
    });
  }

  updateButton1() {
    setState(() {
      Clipboard.setData(
        ClipboardData(
          text: widget.barcode.toString(),
        ),
      );
      click = true;
      done();
      click = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String search = Provider.of<ScanData>(context, listen: false).search;
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Result",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyNavigationBar())),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 15.r,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        widget.formate == null
                            ? ""
                            : widget.formate.toString().replaceFirst(
                                widget.formate![0],
                                widget.formate![0].toUpperCase()),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        widget.barcode.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              click == false ? Colors.white : Colors.blue,
                          enableFeedback: true,
                          padding: EdgeInsets.symmetric(
                              horizontal: 70.w, vertical: 5.w),
                          shape: const StadiumBorder(),
                        ),
                        onPressed: () {
                          setState(() {
                            Clipboard.setData(
                              ClipboardData(
                                text: widget.barcode.toString(),
                              ),
                            );
                            click = true;
                            // Provider.of<ScanData>(context,listen: false).updateClick(true);
                            done();
                          });
                        },
                        child: Text(
                          click == false ? "Copy" : "Copied to clipboard",
                          style: TextStyle(
                              color:
                                  click == false ? Colors.black : Colors.white,
                              fontSize: 15.sp),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      enableFeedback: true,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 30.w,
                                        vertical: 5.w,
                                      )),
                                  onPressed: () {
                                    setState(() {
                                      if (widget.formate == "text") {
                                        if (search == 'Google')
                                          Utils.lauchURl(
                                            "https://www.google.com/search?q=${widget.barcode}",
                                          );
                                        if (search == 'Bing')
                                          Utils.lauchURl(
                                            "https://www.bing.com/search?q=${widget.barcode}",
                                          );
                                        if (search == 'Yahoo')
                                          Utils.lauchURl(
                                            "https://search.yahoo.com/search;_ylt=A0oG7l7PeB5P3G0AKASl87UF?p=${widget.barcode}&b=1",
                                          );
                                        if (search == 'DuckDuckGo')
                                          Utils.lauchURl(
                                            "https://duckduckgo.com/?q=${widget.barcode}&t=h_&ia=definition",
                                          );
                                        if (search == 'Yandex')
                                          Utils.lauchURl(
                                            "https://yandex.com/search/?text=${widget.barcode}&lr=10558",
                                          );
                                      }

                                      if (widget.formate == "url") {
                                        // Utils.lauchURl(widget.barcode.toString());
                                        Utils.lauchURl(widget.barcode!);
                                      }
                                      // Utils.lauchURl(
                                      //   widget.formate == "url"
                                      //     ? widget.barcode.toString()
                                      //     : "https://www.google.com/search?q=${widget.barcode}");
                                    });
                                  },
                                  child: Icon(
                                    widget.formate == "text"
                                        ? Icons.search
                                        : Icons.open_in_browser,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                widget.formate == "text"
                                    ? "Search"
                                    : "Open browser",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Column(
                            children: [
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      enableFeedback: true,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 30.w)),
                                  onPressed: () {
                                    setState(() {
                                      Share.share(widget.barcode.toString());
                                    });
                                  },
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
