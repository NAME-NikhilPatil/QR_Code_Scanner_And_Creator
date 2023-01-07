import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';
import 'package:qr_code_scan/constants.dart';
import 'package:qr_code_scan/screens/exit.dart';
import 'package:qr_code_scan/screens/feedback_screen.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../components/bottom_navigation.dart';
import '../Provider/saved_setting.dart';

class HistoryScreenDetails extends StatefulWidget {
  HistoryScreenDetails({Key? key, required this.barcode, this.formate})
      : super(key: key);
  Map<dynamic, dynamic> barcode;
  String? formate;
  @override
  State<HistoryScreenDetails> createState() => _HistoryScreenDetailsState();
}

class _HistoryScreenDetailsState extends State<HistoryScreenDetails> {
  bool click = false;

  @override
  void initState() {
    super.initState();
    // click = Provider.of<ScanData>(context, listen: false).click;
    click = SaveSetting.getSwitch() ??
        Provider.of<ScanData>(context, listen: false).click;

    click == true ? updateButton() : null;
  }

  TextStyle _style = TextStyle(
    // decoration: TextDecoration.underline,
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 21.sp,
  );
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

  String playStoreId = "com.example.qr_code_scanner";

  @override
  Widget build(BuildContext context) {
    String search = Provider.of<ScanData>(context, listen: false).search;
    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
        googlePlayIdentifier: playStoreId,
        minDays: 0,
        minLaunches: 3,
        remindLaunches: 2,
        remindDays: 1,
      ),
      onInitialized: (context, rateMyApp) {
        setState(() {
          rateMyApp = rateMyApp;
        });
        Widget buildOkButton(double star) {
          return TextButton(
              onPressed: () async {
                const event = RateMyAppEventType.rateButtonPressed;
                await rateMyApp.callEvent(event);
                final launchAppStore = star >= 4;
                if (launchAppStore) {
                  rateMyApp.launchStore();
                }

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.white,
                  content: Text(
                    "Thanks for your feedback 😊",
                  ),
                  behavior: SnackBarBehavior.floating,
                ));

                Navigator.pop(context);
              },
              child: Text("OK"));
        }

        Widget buildCancelButton() {
          return RateMyAppNoButton(rateMyApp, text: "CANCEL");
        }

        if (rateMyApp.shouldOpenDialog) {
          // rateMyApp.showRateDialog(context);
          rateMyApp.showStarRateDialog(
            context,
            title: "Rate This App 😊",
            message:
                "Your feedback helps us to improve the app and provide a better experience for all of our users",
            starRatingOptions: StarRatingOptions(initialRating: 4),
            actionsBuilder: (BuildContext context, double? stars) {
              return stars == null
                  ? [buildCancelButton()]
                  : [buildOkButton(stars), buildCancelButton()];
            },
          );
        }
      },
      builder: (context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,

          // title: Text(
          //   "Result",
          //   style: TextStyle(
          //     color: Colors.grey.shade300,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          backgroundColor: Colors.transparent,

          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
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
                        color: Colors.grey.shade300,
                        blurRadius: 21.r,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 21.h,
                      ),
                      Text(
                        widget.formate == null
                            ? ""
                            : widget.formate.toString().replaceFirst(
                                widget.formate![0],
                                widget.formate![0].toUpperCase()),
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      RichText(
                        text: widget.formate == 'url'
                            ? TextSpan(
                                style: _style,
                                text: widget.barcode['url'],
                              )
                            : widget.formate == 'phone'
                                ? TextSpan(
                                    style: _style,
                                    text: widget.barcode['number'],
                                  )
                                : widget.formate == 'email'
                                    ? TextSpan(
                                        style: _style,
                                        text: widget.barcode['address'],
                                      )
                                    : widget.formate == 'sms'
                                        ? TextSpan(
                                            style: _style,
                                            text: widget.barcode['message'],
                                          )
                                        : widget.formate == 'wifi'
                                            ? TextSpan(
                                                style: _style,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        "Network name(ssid): ${widget.barcode['ssid']}\n",
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "EncryptionType: ${widget.barcode['encryptionType']}\n",
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        "Password: ${widget.barcode['password']}",
                                                  ),
                                                ],
                                              )
                                            :
                                            // widget.formate == 'contactInfo'
                                            //     ? TextSpan(
                                            //         style: _style,
                                            //         children: [
                                            //           TextSpan(
                                            //             text:
                                            //                 "Address: ${widget.barcode['addresses']}\n",
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 "Email: ${widget.barcode['emails']}\n",
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 "Name: ${widget.barcode['name']}\n",
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 "Organization: ${widget.barcode['organization']}\n",
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 "Phones: ${widget.barcode['phones']}\n",
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 "Title: ${widget.barcode['name']}\n",
                                            //           ),
                                            //           TextSpan(
                                            //             text:
                                            //                 "Urls: ${widget.barcode['urls']}\n",
                                            //           ),
                                            //         ],
                                            //       )
                                            widget.formate == 'calendarEvent'
                                                ? TextSpan(
                                                    style: _style,
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                            "Start: ${widget.barcode['start']}\n",
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "End: ${widget.barcode['end']}\n",
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "Location: ${widget.barcode['location'] ?? "No location"}",
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            "Description: ${widget.barcode['description'] ?? "No description"}",
                                                      ),
                                                    ],
                                                  )
                                                : widget.formate == 'geoPoint'
                                                    ? TextSpan(
                                                        style: _style,
                                                        children: [
                                                          TextSpan(
                                                            text:
                                                                "Latitude: ${widget.barcode['latitude']}\n",
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                "Longitude: ${widget.barcode['longitude']}\n",
                                                          ),
                                                        ],
                                                      )
                                                    : TextSpan(
                                                        style: _style,
                                                        text: widget
                                                            .barcode['text'],
                                                      ),
                        // widget.barcode['number'].toString():null,
                        textAlign: TextAlign.center,

                        // style: TextStyle(
                        //   // decoration: TextDecoration.underline,
                        //   fontWeight: FontWeight.w500,
                        //   color: Colors.black,
                        //   fontSize: 21.sp,
                        // ),
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            click == false
                                ? Colors.white
                                : Constants.primaryColor,
                          ),
                          enableFeedback: true,
                          elevation: MaterialStateProperty.all(1),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                      horizontal: 70.w, vertical: 10.h)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
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
                            color: click == false ? Colors.black : Colors.white,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 21.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    elevation: MaterialStateProperty.all(1),
                                    enableFeedback: true,
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 30.w, vertical: 10.h)),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (widget.formate == "text" ||
                                          widget.formate == "product") {
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
                                        Utils.lauchURl(widget.barcode['url']!);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    widget.formate == "text" ||
                                            widget.formate == "product"
                                        ? Icons.search
                                        : Icons.open_in_browser,
                                    color: Colors.black,
                                  )),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                widget.formate == "text" ||
                                        widget.formate == "product"
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
                            height: 21.h,
                          ),
                          Column(
                            children: [
                              ElevatedButton(
                                  style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    elevation: MaterialStateProperty.all(1),
                                    enableFeedback: true,
                                    padding: MaterialStateProperty.all<
                                            EdgeInsetsGeometry>(
                                        EdgeInsets.symmetric(
                                            horizontal: 30.w, vertical: 10.h)),
                                    shape: MaterialStateProperty.all<
                                        OutlinedBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                      ),
                                    ),
                                  ),
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
                        height: 21.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 21.h,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Feedback_Screen(),
                      ),
                    );
                  },
                  child: Text(
                    "Feedback or suggestion",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.grey,
                    ),
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
