import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/scan_data.dart';
import '../../components/box.dart';
import '../../constants.dart';
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
  final _formKey = GlobalKey<FormState>();

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
            child: Form(
              key: _formKey,
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
                    decoration: InputDecoration(
                      hintText: "Please enter something",
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      hintStyle: Constants.hintStyle,
                      focusedBorder: Constants.border,
                      enabledBorder: Constants.border,
                      focusedErrorBorder: Constants.border,
                      border: Constants.border,
                      errorBorder: Constants.border,
                      errorStyle: Constants.errroStyle,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                    style: Constants.buttonStyle(Colors.blue),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
                      }
                    },
                    child: Text(
                      'Create',
                      style: Constants.buttonText,
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                ],
                // children: [_contentWidget()],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
