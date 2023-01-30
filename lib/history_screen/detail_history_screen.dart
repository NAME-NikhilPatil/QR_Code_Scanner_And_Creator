import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/constants.dart';
import 'package:qr_code_scan/providers/scan_data.dart';
import 'package:qr_code_scan/setting_screen/feedback_screen.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../providers/saved_setting.dart';

// ignore: must_be_immutable
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
    try {
      click = SaveSetting.getSwitch() ??
          Provider.of<ScanData>(context, listen: false).click;

      click == true ? updateButton() : null;
    } catch (e) {
      print(e);
    }
  }

  final TextStyle _style = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black,
    fontSize: 23.sp,
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
          text: widget.formate == 'url'
              ? widget.barcode['url']
              : widget.formate == 'phone'
                  ? widget.barcode['number']
                  : widget.formate == 'email'
                      ? widget.barcode['address']
                      : widget.formate == 'wifi'
                          ? "Network name(ssid): ${widget.barcode['ssid']}\n"
                              "EncryptionType: ${widget.barcode['encryptionType']}\n"
                              "Password: ${widget.barcode['password']}"
                          : widget.formate == 'calendarEvent'
                              ? "Start: ${widget.barcode['start']}\n"
                                  "End: ${widget.barcode['end']}\n"
                                  "Location: ${widget.barcode['location'] ?? "No location"}"
                                  "Description: ${widget.barcode['description'] ?? "No description"}"
                              : widget.formate == 'geoPoint'
                                  ? "Latitude: ${widget.barcode['latitude']}\n"
                                      "Longitude: ${widget.barcode['longitude']}\n"
                                  : widget.barcode['text'],
        ),
      );
      click = true;
      done();
    });
  }

  String playStoreId = "com.qr.qr_code_scanner";

  @override
  Widget build(BuildContext context) {
    String search = Provider.of<ScanData>(context, listen: false).search;
    String? barcode = widget.formate == 'url'
        ? widget.barcode['url']
        : widget.formate == 'phone'
            ? widget.barcode['number']
            : widget.formate == 'email'
                ? widget.barcode['address']
                : widget.formate == 'wifi'
                    ? "Network name(ssid): ${widget.barcode['ssid']}\n"
                        "EncryptionType: ${widget.barcode['encryptionType']}\n"
                        "Password: ${widget.barcode['password']}"
                    : widget.formate == 'calendarEvent'
                        ? "Start: ${widget.barcode['start']}\n"
                            "End: ${widget.barcode['end']}\n"
                            "Location: ${widget.barcode['location'] ?? "No location"}"
                            "Description: ${widget.barcode['description'] ?? "No description"}"
                        : widget.formate == 'geoPoint'
                            ? "Latitude: ${widget.barcode['latitude']}\n"
                                "Longitude: ${widget.barcode['longitude']}\n"
                            : widget.barcode['text'].toString();
    return RateMyAppBuilder(
      rateMyApp: RateMyApp(
        googlePlayIdentifier: playStoreId,
        minDays: 0,
        minLaunches: 4,
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
                try {
                  const event = RateMyAppEventType.rateButtonPressed;
                  await rateMyApp.callEvent(event);
                  final launchAppStore = star >= 4;
                  if (launchAppStore) {
                    rateMyApp.launchStore();
                  }

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Constants.primaryColor,
                    content: const Text(
                      "Thanks for your feedback 😊",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ));
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (e) {
                  print(e);
                }
              },
              child: const Text("OK"));
        }

        Widget buildCancelButton() {
          return RateMyAppNoButton(rateMyApp, text: "CANCEL");
        }

        if (rateMyApp.shouldOpenDialog) {
          rateMyApp.showStarRateDialog(
            context,
            title: "Rate This App 😊",
            message:
                "Your feedback helps us to improve the app and provide a better experience for all of our users",
            starRatingOptions: const StarRatingOptions(initialRating: 4),
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
          centerTitle: true,
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
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 30.r,
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
                                        : widget.formate == 'calendarEvent'
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
                                                    text:
                                                        widget.barcode['text'],
                                                  ),
                        textAlign: TextAlign.center,
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
                          try {
                            setState(() {
                              Clipboard.setData(
                                ClipboardData(
                                  text: barcode,
                                ),
                              );
                            });
                            click = true;
                            done();
                          } catch (e) {
                            print(e);
                          }
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
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  try {
                                    setState(
                                      () {
                                        if (widget.formate == "text" ||
                                            widget.formate == "geoPoint" ||
                                            widget.formate == "product" ||
                                            widget.formate == "phone" ||
                                            widget.formate == "email" ||
                                            widget.formate == "wifi" ||
                                            widget.formate == "calendarEvent" ||
                                            widget.formate == 'ean8' ||
                                            widget.formate == 'code128' ||
                                            widget.formate == 'code39' ||
                                            widget.formate == 'code93' ||
                                            widget.formate == 'codebar' ||
                                            widget.formate == 'ean13' ||
                                            widget.formate == 'dataMatrix' ||
                                            widget.formate == 'itf' ||
                                            widget.formate == 'upcA' ||
                                            widget.formate == 'upcE' ||
                                            widget.formate == 'pdf417' ||
                                            widget.formate == 'aztec' ||
                                            widget.formate == 'isbn') {
                                          if (search == 'Google') {
                                            Utils.lauchURl(
                                              "https://www.google.com/search?q=$barcode",
                                            );
                                          }
                                          if (search == 'Bing') {
                                            Utils.lauchURl(
                                              "https://www.bing.com/search?q=$barcode",
                                            );
                                          }
                                          if (search == 'Yahoo') {
                                            Utils.lauchURl(
                                              "https://search.yahoo.com/search;_ylt=A0oG7l7PeB5P3G0AKASl87UF?p=$barcode&b=1",
                                            );
                                          }
                                          if (search == 'DuckDuckGo') {
                                            Utils.lauchURl(
                                              "https://duckduckgo.com/?q=$barcode&t=h_&ia=definition",
                                            );
                                          }
                                          if (search == 'Yandex') {
                                            Utils.lauchURl(
                                              "https://yandex.com/search/?text=$barcode&lr=10558",
                                            );
                                          }
                                        }
                                        if (widget.formate == "url") {
                                          Utils.lauchURl(
                                              widget.barcode['url']!);
                                        }
                                      },
                                    );
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Icon(
                                  widget.formate == "text" ||
                                          widget.formate == 'isbn' ||
                                          widget.formate == "geoPoint" ||
                                          widget.formate == "product" ||
                                          widget.formate == "phone" ||
                                          widget.formate == "email" ||
                                          widget.formate == "wifi" ||
                                          widget.formate == "calendarEvent" ||
                                          widget.formate == 'ean8' ||
                                          widget.formate == 'code128' ||
                                          widget.formate == 'code39' ||
                                          widget.formate == 'code93' ||
                                          widget.formate == 'codebar' ||
                                          widget.formate == 'ean13' ||
                                          widget.formate == 'dataMatrix' ||
                                          widget.formate == 'itf' ||
                                          widget.formate == 'upcA' ||
                                          widget.formate == 'upcE' ||
                                          widget.formate == 'pdf417' ||
                                          widget.formate == 'aztec'
                                      ? Icons.search
                                      : Icons.open_in_browser,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                widget.formate == "text" ||
                                        widget.formate == 'isbn' ||
                                        widget.formate == "geoPoint" ||
                                        widget.formate == "product" ||
                                        widget.formate == "phone" ||
                                        widget.formate == "email" ||
                                        widget.formate == "wifi" ||
                                        widget.formate == "calendarEvent" ||
                                        widget.formate == 'ean8' ||
                                        widget.formate == 'code128' ||
                                        widget.formate == 'code39' ||
                                        widget.formate == 'code93' ||
                                        widget.formate == 'codebar' ||
                                        widget.formate == 'ean13' ||
                                        widget.formate == 'dataMatrix' ||
                                        widget.formate == 'itf' ||
                                        widget.formate == 'upcA' ||
                                        widget.formate == 'upcE' ||
                                        widget.formate == 'pdf417' ||
                                        widget.formate == 'aztec'
                                    ? "Search"
                                    : "Open browser",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
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
                                  shape:
                                      MaterialStateProperty.all<OutlinedBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  try {
                                    setState(
                                      () {
                                        Share.share(barcode!);
                                      },
                                    );
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                "Share",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15.sp,
                                ),
                              ),
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
                        builder: (context) => const FeedbackScreen(),
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
