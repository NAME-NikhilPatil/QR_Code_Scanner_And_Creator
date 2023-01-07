import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/scan_data.dart';
import '../../components/box.dart';
import '../../constants.dart';
import '../../model/create.dart';
import '../sava_qr_code.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;

  TextEditingController controller2 = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> deviceInfo() async {
    _dataString =
        "Name:${controller.text}\nPhone no:${controller1.text}\nE-mail:${controller2.text}";
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
                  const Boxy(text: "Contacts", image: "contacts"),
                  SizedBox(
                    height: 30.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          "Name",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
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
                            return 'Please enter the name first';
                          }
                          return null;
                        },
                        minLines: 1,
                        controller: controller,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Please enter your name",
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
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          "Phone number",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
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
                            return 'Please enter the phone number';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        minLines: 1,
                        controller: controller1,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Please enter phone number",
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
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          "E-mail",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
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
                            return 'Please enter the email id';
                          }
                          return null;
                        },
                        minLines: 1,
                        controller: controller2,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: "Please enter email id",
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
                    ],
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
                        createDb.addItemC(CreateQr(_dataString, "contacts"));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaveQrCode(
                              dataString: _dataString,
                              formate: "ContactInfo",
                            ),
                          ),
                        );
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
