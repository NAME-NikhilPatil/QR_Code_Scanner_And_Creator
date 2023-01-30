import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/scan_data.dart';
import '../../components/box.dart';
import '../../constants.dart';
import '../../model/create.dart';
import '../sava_qr_code.dart';

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
                  const Boxy(text: "Website", image: "website"),
                  SizedBox(
                    height: 30.h,
                  ),
                  TextFormField(
                    onChanged: (val) {
                      _formKey.currentState!.validate();

                      setState(
                        () {
                          primaryColor = val.isNotEmpty
                              ? Constants.primaryColor
                              : Colors.grey;
                        },
                      );
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the url first';
                      }
                      return null;
                    },
                    minLines: 1,
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Please enter website url",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 15.h,
                      ),
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
                          setState(
                            () {
                              controller.text = "${controller.text}https://";
                              controller.selection = TextSelection.fromPosition(
                                  TextPosition(offset: controller.text.length));
                            },
                          );
                        },
                        child: Text(
                          "https://",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
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
                          setState(
                            () {
                              controller.text = "${controller.text}www.";
                              controller.selection = TextSelection.fromPosition(
                                  TextPosition(offset: controller.text.length));
                            },
                          );
                        },
                        child: Text(
                          "www.",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
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
                                  horizontal: 20.w, vertical: 5.h),
                            )),
                        onPressed: () {
                          setState(
                            () {
                              controller.text = "${controller.text}.com";
                              controller.selection = TextSelection.fromPosition(
                                  TextPosition(offset: controller.text.length));
                            },
                          );
                        },
                        child: Text(
                          ".com",
                          style: TextStyle(
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                    style: Constants.buttonStyle(primaryColor),
                    onPressed: () {
                      try {
                        if (_formKey.currentState!.validate()) {
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
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        print(e);
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
