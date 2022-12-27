import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/scan_data.dart';
import '../../components/box.dart';
import '../../model/create.dart';
import '../../sava_qr_code.dart';

class Spotify extends StatefulWidget {
  const Spotify({super.key});

  @override
  State<Spotify> createState() => _SpotifyState();
}

class _SpotifyState extends State<Spotify> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;

  TextEditingController controller2 = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  Future<void> deviceInfo() async {
    String name = "${controller.text}";
    String sname = "${controller1.text}";
    _dataString = "https://open.spotify.com/search/$name;$sname";

    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Boxy(text: "Spotify", image: "spotify"),
                SizedBox(
                  height: 60.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: const Text(
                        "Artist Name",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          primaryColor =
                              val.isNotEmpty ? Colors.blue : Colors.grey;
                        });
                      },
                      minLines: 1,
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            width: 2.h,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              width: 2.h, color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: const Text(
                        "Song Name",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    TextField(
                      onChanged: (val) {
                        setState(() {
                          primaryColor =
                              val.isNotEmpty ? Colors.blue : Colors.grey;
                        });
                      },
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      minLines: 1,
                      controller: controller1,
                      autofocus: true,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 15.h),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                            width: 2.h,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.r),
                          borderSide: BorderSide(
                              width: 2.h, color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(primaryColor),
                        // : MaterialStateProperty.all<Color>(Colors.grey),
                        enableFeedback: true,
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(
                                horizontal: 50.w, vertical: 10.h))),
                    onPressed: () {
                      deviceInfo();
                      var createDb =
                          Provider.of<ScanData>(context, listen: false);
                      createDb.addItemC(CreateQr(_dataString, "spotify"));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SaveQrCode(
                                    dataString: _dataString,
                                  )));
                    },
                    child: const Text("Create")),
              ],
              // children: [_contentWidget()],
            ),
          ),
        ),
      ),
    );
  }
}
