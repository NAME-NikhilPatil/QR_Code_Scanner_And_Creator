import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/Provider/scan_data.dart';
import 'package:qr_code_scan/model/create.dart';
import 'package:qr_code_scan/sava_qr_code.dart';
import 'package:qr_code_scan/screens/detail_history_screen.dart';
import 'package:qr_code_scan/screens/result.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:vibration/vibration.dart';

import '../model/history.dart';

class History_screen extends StatefulWidget {
  const History_screen({super.key});

  @override
  State<History_screen> createState() => _History_screenState();
}

class _History_screenState extends State<History_screen>
    with SingleTickerProviderStateMixin {
  List<String> _choicesList = ['SCAN', 'CREATE'];
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        bottom: TabBar(
          controller: _controller,
          indicatorColor: Colors.blueAccent,
          indicatorWeight: 3.h,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          enableFeedback: true,
          labelStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.bold,
          ),
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
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        closeIcon: SizedBox(),
                        context: context,
                        type: AlertType.none,
                        title: "Clear history",
                        content: SizedBox(
                            child: Text(
                          "Are you sure you want to delete?",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.sp,
                          ),
                        )),
                        buttons: [
                          DialogButton(
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 20.sp),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.white,
                          ),
                          DialogButton(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            onPressed: () {
                              Provider.of<ScanData>(context, listen: false)
                                  .deleteItem();

                              Navigator.pop(context);
                            },
                            color: Colors.blue,
                          )
                        ],
                      ).show();
                    }
                  });
                }
                if (_controller?.index == 1) {
                  setState(() {
                    if (tata != 0) {
                      Vibration.vibrate(duration: 100);

                      Alert(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        closeIcon: const SizedBox(),
                        context: context,
                        type: AlertType.none,
                        title: "Clear history",
                        content: SizedBox(
                            child: Text(
                          "Are you sure you want to delete?",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15.sp,
                          ),
                        )),
                        buttons: [
                          DialogButton(
                            child: Text(
                              "No",
                              style: TextStyle(
                                  color: Colors.blue, fontSize: 20.sp),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Colors.white,
                          ),
                          DialogButton(
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            onPressed: () {
                              Provider.of<ScanData>(context, listen: false)
                                  .deleteItemC();

                              Navigator.pop(context);
                            },
                            color: Colors.blue,
                          )
                        ],
                      ).show();
                    }
                  });
                }
              },
              icon: Icon(
                Icons.delete_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          data != 0
              ? ListviewHistory(context)
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
                      const Text(
                        "No history",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
          tata != 0
              ? ListviewCreateHistory(context)
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

  Widget ListviewHistory(context) {
    return ListView.builder(
        itemCount:
            Provider.of<ScanData>(context, listen: false).historyList?.length,
        itemBuilder: (context, index) {
          History his =
              Provider.of<ScanData>(context, listen: false).historyList![index];
          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreenDetail(
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
                          color: Colors.grey,
                          blurRadius: 5.r,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 10.w, top: 20.h, right: 10.w),
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
                                builder: (context) => HistoryScreenDetail(
                                  formate: his.formate,
                                  barcode: his.qrCodeValue,
                                ),
                              ),
                            );
                          },
                          child: Row(
                            children: <Widget>[
                              Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: 40.h,
                                  width: 40.h,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                his.formate == "url"
                                    ? SvgPicture.asset(
                                        "assets/website.svg",
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
                              ]),
                              SizedBox(
                                width: 10.w,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HistoryScreenDetail(
                                        barcode: his.qrCodeValue,
                                        formate: his.formate,
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: 190.w,
                                  child: Text(
                                    his.qrCodeValue!,
                                    maxLines: 1,
                                    softWrap: false,
                                    overflow: TextOverflow.fade,
                                    style: TextStyle(
                                      fontSize: 20.0.sp,
                                      color: Colors.black,
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
                                            HistoryScreenDetail(
                                          formate: his.formate,
                                          barcode: his.qrCodeValue,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.blueAccent,
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
                              color: Colors.blueAccent,
                              size: 25.h,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        });
  }

  Widget ListviewCreateHistory(context) {
    return ListView.builder(
        itemCount:
            Provider.of<ScanData>(context, listen: false).createList.length,
        itemBuilder: (context, index) {
          CreateQr his =
              Provider.of<ScanData>(context, listen: false).createList[index];
          return Column(
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
                          color: Colors.grey,
                          blurRadius: 5.r,
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(left: 10.w, top: 20.h, right: 10.w),
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
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10.r),
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
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: Colors.blueAccent,
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
                              color: Colors.blueAccent,
                              size: 25.h,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          );
        });
  }
}
