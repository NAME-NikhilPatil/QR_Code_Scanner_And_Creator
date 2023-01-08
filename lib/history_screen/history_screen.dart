import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/providers/scan_data.dart';
import 'package:qr_code_scan/constants.dart';
import 'package:qr_code_scan/model/create.dart';
import 'package:qr_code_scan/create_qr_code_screen/sava_qr_code.dart';
import 'package:qr_code_scan/history_screen/detail_history_screen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vibration/vibration.dart';

import '../model/history.dart';

// ignore: camel_case_types
class History_screen extends StatefulWidget {
  const History_screen({super.key});

  @override
  State<History_screen> createState() => _History_screenState();
}

// ignore: camel_case_types
class _History_screenState extends State<History_screen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _controller = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  TabController? _controller;

  @override
  Widget build(BuildContext context) {
    context.watch<ScanData>().getItem();
    int? data =
        Provider.of<ScanData>(context, listen: false).historyList?.length;
    context.watch<ScanData>().getItemC();
    int tata = Provider.of<ScanData>(context, listen: false).createList.length;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Constants.primaryColor,
          indicatorWeight: 3.h,
          labelColor: Constants.primaryColor,
          unselectedLabelColor: Colors.grey,
          enableFeedback: true,
          labelStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
          automaticIndicatorColorAdjustment: true,
          tabs: const [
            Tab(
              text: "SCAN",
            ),
            Tab(
              text: "CREATE",
            ),
          ],
        ),
        title: Text(
          'History',
          style: TextStyle(
            fontSize: 22.sp,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (_controller?.index == 0) {
                setState(() {
                  if (data != 0) {
                    Vibration.vibrate(duration: 100);

                    Alert(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 20.w),
                      closeIcon: const SizedBox(),
                      context: context,
                      type: AlertType.none,
                      title: "Clear history",
                      style: AlertStyle(
                        backgroundColor: Constants.creamColor,
                        titleStyle: TextStyle(
                          fontSize: 20.sp,
                        ),
                      ),
                      content: Column(
                        children: [
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                              child: Text(
                            "Are you sure you want to delete?",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15.sp,
                            ),
                          )),
                        ],
                      ),
                      buttons: [
                        DialogButton(
                          onPressed: () => Navigator.pop(context),
                          color: Constants.creamColor,
                          child: Text(
                            "No",
                            style: TextStyle(
                              color: Constants.primaryColor,
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                        DialogButton(
                          onPressed: () {
                            Provider.of<ScanData>(context, listen: false)
                                .deleteItem();

                            Navigator.pop(context);
                          },
                          color: Constants.primaryColor,
                          child: Text(
                            "Yes",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                        )
                      ],
                    ).show();
                  }
                });
              }
              if (_controller?.index == 1) {
                setState(
                  () {
                    if (tata != 0) {
                      Vibration.vibrate(duration: 100);

                      Alert(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.h,
                          horizontal: 20.w,
                        ),
                        closeIcon: const SizedBox(),
                        context: context,
                        type: AlertType.none,
                        title: "Clear history",
                        style: AlertStyle(
                          backgroundColor: Constants.creamColor,
                          titleStyle: TextStyle(
                            fontSize: 20.sp,
                          ),
                        ),
                        content: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                child: Text(
                              "Are you sure you want to delete?",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15.sp,
                              ),
                            )),
                          ],
                        ),
                        buttons: [
                          DialogButton(
                            onPressed: () => Navigator.pop(context),
                            color: Constants.creamColor,
                            child: Text(
                              "No",
                              style: TextStyle(
                                color: Constants.primaryColor,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          DialogButton(
                            onPressed: () {
                              Provider.of<ScanData>(context, listen: false)
                                  .deleteItemC();

                              Navigator.pop(context);
                            },
                            color: Constants.primaryColor,
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                          ),
                        ],
                      ).show();
                    }
                  },
                );
              }
            },
            icon: const Icon(
              Icons.delete_sweep,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          data != 0
              ? listviewHistory(context)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.r)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/boxy.svg",
                              fit: BoxFit.cover,
                              color: Colors.grey,
                              height: 100.h,
                              width: 100.h,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "No history",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
          tata != 0
              ? listviewCreateHistory(context)
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 100.h,
                        width: 100.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/boxy.svg",
                              fit: BoxFit.cover,
                              color: Colors.grey,
                              height: 100.h,
                              width: 100.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "No history",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }

  Widget listviewHistory(context) {
    TextStyle style = TextStyle(
      color: Colors.black,
      fontSize: 21.sp,
    );
    return ListView.builder(
      itemCount:
          Provider.of<ScanData>(context, listen: false).historyList?.length,
      itemBuilder: (context, index) {
        History his =
            Provider.of<ScanData>(context, listen: false).historyList![index];
        return Container(
          margin: EdgeInsets.only(bottom: 5.h),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreenDetails(
                        barcode: his.qrCodeValue,
                        formate: his.formate,
                      ),
                    ),
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5.r,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 10.w, top: 15.h, right: 10.w),
                    padding:
                        EdgeInsets.only(left: 5.w, top: 10.h, bottom: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryScreenDetails(
                                  formate: his.formate,
                                  barcode: his.qrCodeValue,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 40.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(5.r),
                                    ),
                                  ),
                                  his.formate == "url"
                                      ? SvgPicture.asset(
                                          "assets/website.svg",
                                          height: 20.h,
                                          width: 35.h,
                                          fit: BoxFit.contain,
                                        )
                                      : his.formate == "wifi"
                                          ? SvgPicture.asset(
                                              "assets/wifi.svg",
                                              height: 20.h,
                                              width: 35.h,
                                              fit: BoxFit.contain,
                                            )
                                          : his.formate == "phone"
                                              ? SvgPicture.asset(
                                                  "assets/telephone.svg",
                                                  height: 20.h,
                                                  width: 35.h,
                                                  fit: BoxFit.contain,
                                                )
                                              : his.formate == "email"
                                                  ? SvgPicture.asset(
                                                      "assets/email.svg",
                                                      height: 20.h,
                                                      width: 35.h,
                                                      fit: BoxFit.contain,
                                                    )
                                                  : his.formate == "contactInfo"
                                                      ? SvgPicture.asset(
                                                          "assets/contacts.svg",
                                                          height: 20.h,
                                                          width: 35.h,
                                                          fit: BoxFit.contain,
                                                        )
                                                      : SvgPicture.asset(
                                                          "assets/text1.svg",
                                                          height: 20.h,
                                                          width: 35.h,
                                                          color: Colors.grey,
                                                          fit: BoxFit.contain,
                                                        ),
                                ],
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          HistoryScreenDetails(
                                        barcode: his.qrCodeValue,
                                        formate: his.formate,
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 190.w,
                                  child: RichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    // his.qrCodeValue!.toString()
                                    text: his.formate == 'url'
                                        ? TextSpan(
                                            style: style,
                                            text: his.qrCodeValue['url'],
                                          )
                                        : his.formate == 'phone'
                                            ? TextSpan(
                                                style: style,
                                                text: his.qrCodeValue['number'],
                                              )
                                            : his.formate == 'email'
                                                ? TextSpan(
                                                    style: style,
                                                    text: his
                                                        .qrCodeValue['address'],
                                                  )
                                                : his.formate == 'sms'
                                                    ? TextSpan(
                                                        style: style,
                                                        text: his.qrCodeValue[
                                                            'message'],
                                                      )
                                                    : his.formate == 'wifi'
                                                        ? TextSpan(
                                                            style: style,
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    "Network name(ssid): ${his.qrCodeValue['ssid']}\n",
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "EncryptionType: ${his.qrCodeValue['encryptionType']}\n",
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    "Password: ${his.qrCodeValue['password']}",
                                                              ),
                                                            ],
                                                          )
                                                        : his.formate ==
                                                                'calendarEvent'
                                                            ? TextSpan(
                                                                style: style,
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        "Start: ${his.qrCodeValue['start']}\n",
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        "End: ${his.qrCodeValue['end']}\n",
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        "Location: ${his.qrCodeValue['location'] ?? "No location"}",
                                                                  ),
                                                                  TextSpan(
                                                                    text:
                                                                        "Description: ${his.qrCodeValue['description'] ?? "No description"}",
                                                                  ),
                                                                ],
                                                              )
                                                            : his.formate ==
                                                                    'geoPoint'
                                                                ? TextSpan(
                                                                    style:
                                                                        style,
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            "Latitude: ${his.qrCodeValue['latitude']}\n",
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            "Longitude: ${his.qrCodeValue['longitude']}\n",
                                                                      ),
                                                                    ],
                                                                  )
                                                                : TextSpan(
                                                                    style:
                                                                        style,
                                                                    text: his
                                                                            .qrCodeValue[
                                                                        'text'],
                                                                  ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 45.w,
                                child: IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            HistoryScreenDetails(
                                          formate: his.formate,
                                          barcode: his.qrCodeValue,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Constants.primaryColor,
                                    size: 40.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 45.w,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              his.delete();
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                              color: Constants.primaryColor,
                              size: 25.h,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget listviewCreateHistory(context) {
    return ListView.builder(
      itemCount:
          Provider.of<ScanData>(context, listen: false).createList.length,
      itemBuilder: (context, index) {
        CreateQr his =
            Provider.of<ScanData>(context, listen: false).createList[index];
        return Container(
          margin: EdgeInsets.only(bottom: 5.h),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaveQrCode(
                        dataString: his.qrCodeValue,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 5.r,
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(left: 10.w, top: 15.h, right: 10.w),
                  padding: EdgeInsets.only(left: 5.w, top: 10.h, bottom: 10.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SaveQrCode(
                                dataString: his.qrCodeValue,
                                formate: his.formate,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: <Widget>[
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: 40.h,
                                  width: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                SvgPicture.asset(
                                  "assets/${his.formate}.svg",
                                  height: 20.h,
                                  width: 35.h,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            SizedBox(
                              width: 190.w,
                              child: Text(
                                his.qrCodeValue,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 20.0.sp,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 45.w,
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SaveQrCode(
                                        dataString: his.qrCodeValue,
                                        formate: his.formate,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Constants.primaryColor,
                                  size: 40.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 45.w,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            his.delete();
                          },
                          icon: Icon(
                            Icons.delete_rounded,
                            color: Constants.primaryColor,
                            size: 25.h,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
