import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';
import 'package:qr_code_scan/model/saved_setting.dart';
import 'package:qr_code_scan/screens/feedback_screen.dart';
import 'package:qr_code_scan/screens/privacy_policy.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool isSwitched;
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
    isVibrate = SaveSetting.getVibrate() ?? true;
    search = SaveSetting.getSearch() ?? "Google";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Settings",
            style: TextStyle(
              color: Colors.blueGrey,
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
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 7.h,
              ),
              Center(
                child: Container(
                  width: 350.w,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12.r),
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
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                            child: Icon(
                              Icons.copy,
                              size: 18.h,
                              color: Colors.white,
                            )),
                        title: Text("Auto copied to clipboard"),
                        trailing: Switch(
                          onChanged: (value) {
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
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(
                              Icons.vibration,
                              size: 18.h,
                              color: Colors.white,
                            )),
                        title: Text("Vibration"),
                        trailing: Switch(
                          onChanged: (value) {
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
                              setState(() {
                                isVibrate = false;
                                SaveSetting.setVibrate(false);
                              });
                            }
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
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(
                              Icons.search,
                              size: 18.h,
                              color: Colors.white,
                            )),
                        title: Text("Search engine"),
                        trailing: PopupMenuButton(
                          color: Colors.blue[50],
                          onSelected: (value) {
                            setState(() {
                              Provider.of<ScanData>(context, listen: false)
                                  .search = value as String;
                              SaveSetting.setSearch(value);
                              search = value;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: Text(
                              // Provider.of<ScanData>(context, listen: false)
                              //     .search,
                              search,
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem(
                                child: Text(searchEngine[0]),
                                value: searchEngine[0],
                              ),
                              PopupMenuItem(
                                child: Text(searchEngine[1]),
                                value: searchEngine[1],
                              ),
                              PopupMenuItem(
                                child: Text(searchEngine[2]),
                                value: searchEngine[2],
                              ),
                              PopupMenuItem(
                                child: Text(searchEngine[3]),
                                value: searchEngine[3],
                              ),
                              PopupMenuItem(
                                child: Text(searchEngine[4]),
                                value: searchEngine[4],
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
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
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
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  Feedback_Screen(),
                            ),
                          );
                        },
                        enableFeedback: true,
                        leading: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(
                              Icons.chat_bubble,
                              color: Colors.white,
                              size: 18.h,
                            )),
                        title: Text("Feedback"),
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
                                  PrivacyPolicy(),
                            ),
                          );
                        },
                        enableFeedback: true,
                        leading: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                              size: 18.h,
                            )),
                        title: Text("Privacy policy"),
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
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 18.h,
                            )),
                        title: Text("Version 1.0"),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
