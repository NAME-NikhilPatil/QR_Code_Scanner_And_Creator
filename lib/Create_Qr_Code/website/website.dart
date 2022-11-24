import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/scan_data.dart';
import '../../components/box.dart';
import '../../model/create.dart';
import '../../sava_qr_code.dart';

class Website extends StatefulWidget {
  const Website({super.key});

  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;

  Future<void> deviceInfo() async {
    _dataString ="${controller.text}";
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
                Boxy(text: "Website", image: "website"),
                SizedBox(
                  height: 30.h,
                ),
                TextField(
                  onChanged: (val) {
                    setState(() {
                      primaryColor = val.isNotEmpty ? Colors.blue : Colors.grey;
                    });
                  },
                  minLines: 1,
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Please enter url",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
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
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 5.h))),
                        onPressed: () {
                          setState(() {
                            controller.text = controller.text + "https://";
                            controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: controller.text.length));
                          });
                        },
                        child: const Text("https://")),
                        SizedBox(width: 20.w,),
                    ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 5.h))),
                        onPressed: () {
                          setState(() {
                            controller.text = controller.text + "www.";
                            controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: controller.text.length));
                          });
                        },
                        child: const Text("www.")),
                    SizedBox(
                      width: 20.w,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.grey),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                                    EdgeInsets.symmetric(
                                        horizontal: 20.w, vertical: 5.h))),
                        onPressed: () {
                          setState(() {
                            controller.text = controller.text + ".com";
                            controller.selection = TextSelection.fromPosition(
                                TextPosition(offset: controller.text.length));
                          });
                        },
                        child: const Text(".com")),
                  ],
                ),
                SizedBox(height: 30.h,),
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
                      createDb.addItemC(CreateQr(_dataString, "website"));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SaveQrCode(
                                    dataString: _dataString,
                                    formate: "website",
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
