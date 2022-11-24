import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/scan_data.dart';
import '../../components/box.dart';

import '../../model/create.dart';
import '../../sava_qr_code.dart';

class Instagram extends StatefulWidget {
  const Instagram({super.key});

  @override
  State<Instagram> createState() => _InstagramState();
}

class _InstagramState extends State<Instagram> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;

  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;
  late List<bool> isSelected;
  String? hinttext = "Enter Instagram Username";

  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
  }
 bool ispress=false;
  Future<void> deviceInfo() async {
    if (ispress==true) {
      _dataString = "${controller.text}";
    }else{
    _dataString = "https://www.instagram.com/${controller.text}";
    }
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
                Boxy(text: "Instagram", image: "instagram"),
                SizedBox(
                  height: 30.h,
                ),
                ToggleButtons(
                  fillColor: Colors.blue,
                  selectedColor: Colors.white,
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        isSelected[i] = i == index;
                        if (isSelected[0] == true) {
                          hinttext = "Enter Instagram Username";
                        }
                        if (isSelected[1] == true) {
                          hinttext = "URL";
                          ispress=true;
                        }
                      }
                    });
                  },
                  isSelected: isSelected,
                  borderRadius: BorderRadius.circular(15.r),
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.w),
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 10.h),
                      child: Text(
                        'Username',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 65.w, vertical: 10.h),
                      child: Text(
                        'URL',
                        style: TextStyle(fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      primaryColor = val.isNotEmpty ? Colors.blue : Colors.grey;
                    });
                  },

                  // maxLines: null,
                  minLines: 1,
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    // hintText:  "Please enter Facebook ID",
                    hintText: hinttext,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide(
                        width: 2.h,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3.h, color: Colors.grey),
                    ),
                  ),
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
                      setState(() {
                      deviceInfo();
                        
                      });
                      var createDb =
                          Provider.of<ScanData>(context, listen: false);
                      createDb.addItemC(CreateQr(_dataString, "instagram"));

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
