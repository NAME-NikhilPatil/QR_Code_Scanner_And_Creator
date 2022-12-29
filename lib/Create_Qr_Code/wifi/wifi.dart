

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../Provider/scan_data.dart';
import '../../components/box.dart';
import '../../constants.dart';
import '../../model/create.dart';
import '../../sava_qr_code.dart';

class Wifi extends StatefulWidget {
  const Wifi({super.key});

  @override
  State<Wifi> createState() => _WifiState();
}

class _WifiState extends State<Wifi> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;
  late String controller1;
  TextEditingController controller2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  dynamic networdName;
  dynamic securityMode;
  dynamic password;

  int? defaultChoiceIndex;
  final List<String> _choicesList = ['WPA', 'WEP', 'None'];
  final List<String> _choiceList = ['WPA', 'WEP', ''];

  bool _isHidden = true;
  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 3;
  }

  Future<void> deviceInfo() async {
    String Name = "${controller.text}";
    String mode = "$controller1" ?? "WPA";
    String password = "${controller2.text}";
    // _dataString = "$Name,$mode,$password";
    _dataString = "WIFI:S:$Name;T:$mode;P:$password;";
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
                  Boxy(text: "Wi-fi", image: "wifi"),
                  SizedBox(
                    height: 30.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const Text(
                          "Netword Name(SSID)",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          _formKey.currentState!.validate();

                          setState(() {
                            primaryColor =
                                val.isNotEmpty ? Colors.blue : Colors.grey;
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
                        height: 10.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const Text(
                          "Select security mode",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 355.w,
                            child: Wrap(
                              spacing: 8.w,
                              children:
                                  List.generate(_choicesList.length, (index) {
                                return ChoiceChip(
                                  labelPadding: EdgeInsets.all(2.0.w),
                                  backgroundColor: Colors.white,
                                  label: Text(_choicesList[index],
                                      style: TextStyle(
                                        color: defaultChoiceIndex == index
                                            ? Colors.white
                                            : Colors.grey,
                                      )),
                                  selected: defaultChoiceIndex == index,

                                  selectedColor: Colors.blue,

                                  onSelected: (value) {
                                    setState(() {
                                      defaultChoiceIndex =
                                          value ? index : defaultChoiceIndex;
                                      controller1 = _choiceList[index];
                                    });
                                  },
                                  // backgroundColor: color,

                                  elevation: 1,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 27.w),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: const Text(
                          "Password",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextFormField(
                        onChanged: (val) {
                          _formKey.currentState!.validate();

                          setState(() {
                            if (defaultChoiceIndex == 2) {
                              primaryColor =
                                  val.isEmpty ? Colors.blue : Colors.grey;
                            }
                            primaryColor =
                                val.isNotEmpty ? Colors.blue : Colors.grey;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty && defaultChoiceIndex == 0) {
                            return 'Please enter the value first';
                          } else if (value.isEmpty && defaultChoiceIndex == 1) {
                            return 'Please enter the value first';
                          } else if (value.isEmpty && defaultChoiceIndex == 2) {
                            return null;
                          }
                          return null;
                        },
                        minLines: 1,
                        controller: controller2,
                        autofocus: true,
                        obscureText: _isHidden,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                            onTap: _togglePasswordView,
                            child: Icon(
                              _isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          hintText: "Please enter something",
                          hintStyle: Constants.hintStyle,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 15.h),
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
                  // ElevatedButton(
                  //     style: ButtonStyle(
                  //         foregroundColor:
                  //             MaterialStateProperty.all<Color>(Colors.white),
                  //         backgroundColor:
                  //             MaterialStateProperty.all<Color>(primaryColor),
                  //         // : MaterialStateProperty.all<Color>(Colors.grey),
                  //         enableFeedback: true,
                  //         padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  //             EdgeInsets.symmetric(
                  //                 horizontal: 50.w, vertical: 10.h))),
                  //     onPressed: () {
                  //       deviceInfo();
                  //       var createDb =
                  //           Provider.of<ScanData>(context, listen: false);
                  //       createDb.addItemC(CreateQr(_dataString, "wifi"));
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (context) => SaveQrCode(
                  //                     dataString: _dataString,
                  //                     formate: 'wifi',
                  //                   )));
                  //     },
                  //     child: const Text("Create")),
                  ElevatedButton(
                    style: Constants.buttonStyle(primaryColor),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        deviceInfo();
                        var createDb =
                            Provider.of<ScanData>(context, listen: false);
                        createDb.addItemC(CreateQr(_dataString, "wifi"));
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SaveQrCode(
                                      dataString: _dataString,
                                      formate: 'wifi',
                                    )));
                      }
                    },
                    child: Text(
                      "Create",
                      style: Constants.buttonText,
                    ),
                  )
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
