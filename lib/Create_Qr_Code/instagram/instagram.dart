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
  int? defaultChoiceIndex;
  late String controller1;

  List<String> _choicesList = ['URL', 'Username'];

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  bool ispress = false;
  Future<void> deviceInfo() async {
    if (ispress == true) {
      // _dataString = "${controller.text}";
      _dataString = "https://www.instagram.com/${controller.text}";
    } else {
      // _dataString = "https://www.instagram.com/${controller.text}";
      _dataString = "${controller.text}";
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
                Row(
                  children: [
                    Wrap(
                      spacing: 5.w,
                      children: List.generate(_choicesList.length, (index) {
                        return ChoiceChip(
                          labelPadding: EdgeInsets.all(5.0.w),
                          backgroundColor: Colors.white,
                          label: Text(_choicesList[index],
                              style: TextStyle(
                                color: defaultChoiceIndex == index
                                    ? Colors.white
                                    : Colors.grey,
                              )),
                          selected: defaultChoiceIndex == index,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.r),
                                  topRight: Radius.circular(5.r),
                                  bottomLeft: Radius.circular(5.r),
                                  bottomRight: Radius.circular(5.r))),
                          selectedColor: Colors.blue,

                          onSelected: (value) {
                            setState(() {
                              defaultChoiceIndex =
                                  value ? index : defaultChoiceIndex;
                              controller1 = _choicesList[index];
                              if (_choicesList[index] == "URL") {
                                hinttext = "Please enter url";
                                ispress = false;
                              }

                              if (_choicesList[index] == "Username") {
                                hinttext = "Please enter Username";
                                ispress = true;
                              }
                            });
                          },
                          // backgroundColor: color,
                          pressElevation: 0,
                          side: BorderSide(
                              color: Colors.grey.shade300, width: 0.9.h),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 23.w),
                        );
                      }),
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
