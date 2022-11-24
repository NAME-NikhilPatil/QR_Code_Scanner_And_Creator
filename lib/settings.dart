import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';

class Settings extends StatefulWidget {
   const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
    bool isSwitched = false;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[50],
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
                    color: Colors.black,
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
                    color: Colors.white,
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
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                            child: Icon(Icons.copy)),
                        title: Text("Auto copied to clipboard"),
                        trailing: Switch(
                          onChanged: (value) {
                            if (value == true) {
                              
                              Provider.of<ScanData>(context, listen: false)
                                  .click = true;
                                  setState(() {
                                    isSwitched=true;
                                  });
                            } else {
                              Provider.of<ScanData>(context, listen: false)
                                  .click = false;
                                  setState(() {
                                    isSwitched=false;
                                    
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
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(Icons.vibration)),
                        title: Text("Vibration"),
                        trailing: Switch(value: true, onChanged: null),
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
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(Icons.search)),
                        title: Text("Search engine"),
                        trailing: Switch(value: true, onChanged: null),
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
                    color: Colors.black,
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      ListTile(
                        enableFeedback: true,
                        leading: Container(
                            height: 30.h,
                            width: 30.h,
                            decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(Icons.chat_bubble)),
                        title: Text("Feedback"),
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
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(Icons.remove_red_eye)),
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
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(7.r)),
                            child: Icon(Icons.info)),
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
