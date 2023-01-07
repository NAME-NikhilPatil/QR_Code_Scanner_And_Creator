import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/constants.dart';

import '../../providers/scan_data.dart';
import '../../components/box.dart';
import '../../model/create.dart';
import '../sava_qr_code.dart';

class Facebook extends StatefulWidget {
  const Facebook({super.key});

  @override
  State<Facebook> createState() => _FacebookState();
}

class _FacebookState extends State<Facebook> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;

  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey.shade500;
  late List<bool> isSelected;
  int? defaultChoiceIndex;
  late String controller1;

  String hinttext = "Please enter facebook ID";
  final List<String> _choicesList = ['Facebook Id', 'URL'];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  bool ispress = true;

  Future<void> deviceInfo() async {
    if (ispress == true) {
      _dataString = "fb://profile/${controller.text}";
    } else {
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Boxy(text: "Facebook", image: "facebook"),
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
                            label: Text(
                              _choicesList[index],
                              style: TextStyle(
                                color: defaultChoiceIndex == index
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            selected: defaultChoiceIndex == index,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.r),
                                    topRight: Radius.circular(5.r),
                                    bottomLeft: Radius.circular(5.r),
                                    bottomRight: Radius.circular(5.r))),
                            selectedColor: Constants.primaryColor,

                            onSelected: (value) {
                              setState(() {
                                defaultChoiceIndex =
                                    value ? index : defaultChoiceIndex;
                                controller1 = _choicesList[index];
                                if (_choicesList[index] == "URL") {
                                  hinttext = "Please enter URL";
                                  ispress = false;
                                }

                                if (_choicesList[index] == "Facebook Id") {
                                  hinttext = "Please enter Facebook Id";
                                  ispress = true;
                                }
                              });
                            },
                            // backgroundColor: color,
                            pressElevation: 0,
                            side: BorderSide(
                              color: Colors.grey.shade200,
                              width: 0.9.h,
                            ),

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
                  TextFormField(
                    onChanged: (val) {
                      _formKey.currentState!.validate();
                      setState(() {
                        primaryColor = val.isNotEmpty
                            ? Constants.primaryColor
                            : Colors.grey.shade500;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the value first';
                      }
                      return null;
                    },
                    minLines: 1,
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintStyle: Constants.hintStyle,
                      hintText: hinttext,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
                      errorBorder: Constants.border,
                      focusedBorder: Constants.border,
                      border: Constants.border,
                      focusedErrorBorder: Constants.border,
                      errorStyle: Constants.errroStyle,
                      enabledBorder: Constants.border,
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
                        createDb.addItemC(CreateQr(_dataString, "facebook"));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SaveQrCode(
                              dataString: _dataString,
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
