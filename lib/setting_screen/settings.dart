import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/providers/saved_setting.dart';
import 'package:qr_code_scan/providers/scan_data.dart';
import 'package:qr_code_scan/setting_screen/feedback_screen.dart';
import 'package:qr_code_scan/setting_screen/privacy_policy.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../components/bottom_navigation.dart';
import '../constants.dart';

class Settings extends StatefulWidget {
  const Settings({
    super.key,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool isSwitched;
  RateMyApp? rateMyApp;
  static const playStoreId = "com.qr.qr_code_scanner";
  late bool isVibrate;
  List<String> searchEngine = [
    "Google",
    "Bing",
    "Yahoo",
    "DuckDuckGo",
    "Yandex"
  ];

  late String search;
  @override
  void initState() {
    super.initState();

    isSwitched = SaveSetting.getSwitch() ?? false;
    isVibrate = SaveSetting.getVibrate() ?? false;
    search = SaveSetting.getSearch() ?? "Google";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyNavigationBar()))
          as dynamic,
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "General settings",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Container(
                  width: 350.w,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        enableFeedback: true,
                        enabled: true,
                        leading: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.copy,
                              size: 18.h,
                              color: Colors.white,
                            )),
                        title: Text(
                          "Auto copied to clipboard",
                          style: Constants.settingText,
                        ),
                        trailing: Switch(
                          activeColor: Constants.primaryColor,
                          // activeTrackColor: Colors.grey.shade300,
                          // inactiveTrackColor: Colors.grey.shade400,
                          onChanged: (value) {
                            try {
                              if (value == true) {
                                Provider.of<ScanData>(context, listen: false)
                                    .click = true;
                                setState(() {
                                  isSwitched = true;
                                  SaveSetting.setSwitch(true);
                                });
                              } else {
                                Provider.of<ScanData>(context, listen: false)
                                    .click = false;
                                setState(() {
                                  isSwitched = false;
                                  SaveSetting.setSwitch(false);
                                });
                              }
                            } catch (e) {
                              print(e);
                            }
                            ;
                          },
                          value: isSwitched,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        enableFeedback: true,
                        leading: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(
                              Icons.vibration,
                              size: 18.h,
                              color: Colors.white,
                            )),
                        title: Text(
                          "Vibration",
                          style: Constants.settingText,
                        ),
                        trailing: Switch(
                          activeColor: Constants.primaryColor,
                          onChanged: (value) {
                            try {
                              if (value == true) {
                                Provider.of<ScanData>(context, listen: false)
                                    .vibrate = true;
                                setState(() {
                                  isVibrate = true;
                                  SaveSetting.setVibrate(true);
                                });
                              } else {
                                Provider.of<ScanData>(context, listen: false)
                                    .vibrate = false;
                                setState(
                                  () {
                                    isVibrate = false;
                                    SaveSetting.setVibrate(false);
                                  },
                                );
                              }
                            } catch (e) {
                              print(e);
                            }
                            ;
                          },
                          value: isVibrate,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        enableFeedback: true,
                        leading: Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Icon(
                            Icons.search,
                            size: 18.h,
                            color: Colors.white,
                          ),
                        ),
                        title: Text(
                          "Search engine",
                          style: Constants.settingText,
                        ),
                        trailing: PopupMenuButton(
                          color: Colors.white,
                          enableFeedback: true,
                          enabled: true,
                          elevation: 3,
                          onSelected: (value) {
                            try {
                              setState(
                                () {
                                  Provider.of<ScanData>(context, listen: false)
                                      .search = value as String;
                                  SaveSetting.setSearch(value);
                                  search = value;
                                },
                              );
                            } catch (e) {
                              print(e);
                            }
                            ;
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Text(
                              search,
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                textStyle: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: searchEngine[0],
                                child: Text(
                                  searchEngine[0],
                                ),
                              ),
                              PopupMenuItem(
                                textStyle: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: searchEngine[1],
                                child: Text(searchEngine[1]),
                              ),
                              PopupMenuItem(
                                textStyle: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: searchEngine[2],
                                child: Text(searchEngine[2]),
                              ),
                              PopupMenuItem(
                                textStyle: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: searchEngine[3],
                                child: Text(searchEngine[3]),
                              ),
                              PopupMenuItem(
                                textStyle: TextStyle(
                                  color: Constants.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                                value: searchEngine[4],
                                child: Text(searchEngine[4]),
                              ),
                            ];
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  "Help",
                  style: TextStyle(
                    color: Constants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Center(
                child: Container(
                  width: 350.w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      RateMyAppBuilder(
                        rateMyApp: RateMyApp(
                          googlePlayIdentifier: playStoreId,
                          // minDays: 0,
                          // minLaunches: 4,
                          // remindDays: 1,
                          // remindLaunches: 4,
                        ),
                        onInitialized: (context, rateMyApp) {
                          setState(
                            () {
                              this.rateMyApp = rateMyApp;
                            },
                          );
                        },
                        builder: (context) => ListTile(
                          onTap: () {
                            try {
                              Widget buildOkButton(double star) {
                                return TextButton(
                                    onPressed: () async {
                                      const event =
                                          RateMyAppEventType.rateButtonPressed;
                                      await rateMyApp!.callEvent(event);
                                      final launchAppStore = star >= 4;
                                      if (launchAppStore) {
                                        rateMyApp!.launchStore();
                                      }
                                      // ignore: use_build_context_synchronously
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor:
                                              Constants.primaryColor,
                                          content: const Text(
                                            "Thank you for your feedback 😊",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );

                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"));
                              }

                              Widget buildCancelButton() {
                                return RateMyAppNoButton(
                                  rateMyApp!,
                                  text: "CANCEL",
                                );
                              }

                              setState(
                                () {
                                  rateMyApp!.showStarRateDialog(
                                    context,
                                    title: "Rate This App 😊",
                                    message:
                                        "Your feedback helps us to improve the app and provide a better experience for all of our users",
                                    starRatingOptions: const StarRatingOptions(
                                        initialRating: 4),
                                    actionsBuilder:
                                        (BuildContext context, double? stars) {
                                      return stars == null
                                          ? [buildCancelButton()]
                                          : [
                                              buildOkButton(stars),
                                              buildCancelButton()
                                            ];
                                    },
                                  );
                                },
                              );
                            } catch (e) {
                              print(e);
                            }
                            ;
                          },
                          // subtitle: const Text('Rate us 5 stars'),
                          enableFeedback: true,
                          leading: Container(
                              height: 30.h,
                              width: 30.h,
                              decoration: BoxDecoration(
                                  color: Constants.primaryColor,
                                  borderRadius: BorderRadius.circular(7.r)),
                              child: Icon(
                                Icons.rate_review_rounded,
                                color: Colors.white,
                                size: 18.h,
                              )),
                          title: Text(
                            "Rate us",
                            style: Constants.settingText,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        onTap: () {
                          try {
                            Utils.lauchURl(
                              "https://play.google.com/store/apps/details?id=com.qr.qr_code_scanner",
                            );
                          } catch (e) {
                            print(e);
                          }
                        },
                        subtitle: const Text(
                            "Update app for new features and improvements"),
                        enableFeedback: true,
                        leading: Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Icon(
                            Icons.system_update,
                            color: Colors.white,
                            size: 18.h,
                          ),
                        ),
                        title: Text(
                          "Update app",
                          style: Constants.settingText,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const FeedbackScreen(),
                            ),
                          );
                        },
                        enableFeedback: true,
                        subtitle: const Text(
                            "Report bugs and tell us what to improve"),
                        leading: Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Icon(
                            Icons.chat_bubble,
                            color: Colors.white,
                            size: 18.h,
                          ),
                        ),
                        title: Text(
                          "Feedback",
                          style: Constants.settingText,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const PrivacyPolicy(),
                            ),
                          );
                        },
                        enableFeedback: true,
                        leading: Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: 18.h,
                          ),
                        ),
                        title: Text(
                          "Privacy policy",
                          style: Constants.settingText,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        enableFeedback: true,
                        leading: Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                              color: Constants.primaryColor,
                              borderRadius: BorderRadius.circular(7.r)),
                          child: Icon(
                            Icons.info,
                            color: Colors.white,
                            size: 18.h,
                          ),
                        ),
                        title: Text(
                          "Version 2.0.7",
                          style: Constants.settingText,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 0.1.sh,
              ),
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
