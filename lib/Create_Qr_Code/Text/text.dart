import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/model/create.dart';

import '../../Provider/scan_data.dart';
import '../../components/box.dart';
import '../../constants.dart';
import '../../sava_qr_code.dart';

class Textbox extends StatefulWidget {
  const Textbox({super.key});

  @override
  State<Textbox> createState() => _TextboxState();
}

class _TextboxState extends State<Textbox> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;
  final _formKey = GlobalKey<FormState>();

  Future<void> deviceInfo() async {
    _dataString = controller.text;
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Boxy(text: "Text", image: "text"),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      _formKey.currentState!.validate();

                      setState(() {
                        primaryColor = val.isNotEmpty
                            ? Constants.primaryColor
                            : Colors.grey;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the text first';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    controller: controller,
                    autofocus: true,
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
                    style: Constants.buttonStyle(primaryColor),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        deviceInfo();
                        var createDb =
                            Provider.of<ScanData>(context, listen: false);
                        createDb.addItemC(CreateQr(_dataString, "text"));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaveQrCode(
                                      dataString: _dataString,
                                    )));
                      }
                    },
                    child: Text(
                      "Create",
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
