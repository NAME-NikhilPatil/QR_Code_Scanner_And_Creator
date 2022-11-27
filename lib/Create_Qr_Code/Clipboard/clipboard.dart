import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/scan_data.dart';
import '../../components/box.dart';
import '../../model/create.dart';
import '../../sava_qr_code.dart';

class Clipboar extends StatefulWidget {
  const Clipboar({super.key});

  @override
  State<Clipboar> createState() => _ClipboarState();
}

class _ClipboarState extends State<Clipboar> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;



  Future<void> deviceInfo() async {
    _dataString = controller.text;
  }

  void _getClipboardText() async {
    final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
    setState(() {
      controller = TextEditingController(text: clipboardData?.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getClipboardText();
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
                const Boxy(text: "Clipboard", image: "clipboard"),
                SizedBox(
                  height: 30.h,
                ),
                TextFormField(
                  maxLines: null,
                  minLines: 1,
                  controller: controller,
                  // autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Please enter something",
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
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
                        width: 2.h,
                        color: Colors.grey.shade200,
                      ),
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
                          MaterialStateProperty.all<Color>(Colors.blue),
                      // : MaterialStateProperty.all<Color>(Colors.grey),
                      enableFeedback: true,
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.symmetric(
                              horizontal: 50.w, vertical: 10.h))),
                  onPressed: () {
                    deviceInfo();
                    var createDb =
                        Provider.of<ScanData>(context, listen: false);
                    createDb.addItemC(CreateQr(_dataString, "clipboard"));
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SaveQrCode(
                                  dataString: _dataString,
                                )));
                  },
                  child: const Text('Create'),
                ),
              ],
              // children: [_contentWidget()],
            ),
          ),
        ),
      ),
    );
  }
}
