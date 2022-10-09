import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../components/box.dart';
import '../../sava_qr_code.dart';

class Website extends StatefulWidget {
  const Website({super.key});

  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  GlobalKey globalKey = GlobalKey();
  String? _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;

  Future<void> deviceInfo() async {
    _dataString = '''
    ${controller.text}
  ''';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  Box(text: "Website", image: "website"),
                  SizedBox(
                    height: 60.h,
                  ),
                  TextField(
                    onChanged: (val) {
                      setState(() {
                        primaryColor =
                            val.isNotEmpty ? Colors.blue : Colors.grey;
                      });
                    },
                    keyboardType: TextInputType.multiline,
                    // maxLines: null,
                    minLines: 1,
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Please enter something",
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.w, vertical: 15.h),
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
                              controller.text = controller.text + "WWW.";
                              controller.selection = TextSelection.fromPosition(
                                  TextPosition(offset: controller.text.length));
                            });
                          },
                          child: const Text("WWW.")),
                    ],
                  ),
            
                  ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          // : MaterialStateProperty.all<Color>(Colors.grey),
                          enableFeedback: true,
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.symmetric(
                                      horizontal: 50.w, vertical: 10.h))),
                      onPressed: () {
                        deviceInfo();
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
      ),
    );
  }
}
