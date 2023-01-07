import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../constants.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  int? defaultChoiceIndex;
  TextEditingController controller = TextEditingController();

  Color primaryColor = Colors.grey;
  List<String> attachments = [];

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  List<bool> isSelected = [false, false, false];
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  bool filepicked = false;
  final _recipientController = TextEditingController(
    text: 'thankyouforyourfeedback1@gmail.com',
  );

  String subject = "Qr Code Scanner";
  final _formKey = GlobalKey<FormState>();

  final _bodyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
    if (!mounted) return;
    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      '\nversion.sdkInt': build.version.sdkInt,
      '\nversion.release': build.version.release,
      '\nversion.previewSdkInt': build.version.previewSdkInt,
      '\nversion.codename': build.version.codename,
      '\nversion.baseOS': build.version.baseOS,
      '\nbrand': build.brand,
      '\ndevice': build.device,
      '\ndisplay': build.display,
      '\nhardware': build.hardware,
      '\nid': build.id,
      '\nmanufacturer': build.manufacturer,
      '\nmodel': build.model,
      '\nproduct': build.product,
      "\nDeviceInfo":
          "Above is your device information which is require for debugging\n",
    };
  }

  Future<void> send() async {
    String emp = _deviceData.toString();
    String pemp = "${_bodyController.text}\n\n";
    String temp = pemp + emp;
    final Email email = Email(
      body: temp,
      subject: subject,
      recipients: [_recipientController.text],
      attachmentPaths: attachments,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'Thank you for your feedback';
    } catch (error) {
      platformResponse = error.toString();
    }

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Feedback",
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: buildCheckItem(
                          title: "Bug",
                          isSelected: isSelected[0],
                        ),
                        onTap: () {
                          setState(
                            () {
                              isSelected[0] = !isSelected[0];
                              isSelected[1] = false;
                              isSelected[2] = false;
                              subject = "Qr Code Scanner(BUG)";
                            },
                          );
                        },
                      ),
                      GestureDetector(
                        child: buildCheckItem(
                          title: "Feedback",
                          isSelected: isSelected[1],
                        ),
                        onTap: () {
                          setState(
                            () {
                              isSelected[1] = !isSelected[1];
                              isSelected[0] = false;
                              isSelected[2] = false;
                              subject = "Qr Code Scanner(FEEDBACK)";
                            },
                          );
                        },
                      ),
                      GestureDetector(
                        child: buildCheckItem(
                          title: "Other",
                          isSelected: isSelected[2],
                        ),
                        onTap: () {
                          setState(
                            () {
                              isSelected[2] = !isSelected[2];
                              isSelected[1] = false;
                              isSelected[0] = false;
                              subject = "Qr Code Scanner(OTHER)";
                            },
                          );
                        },
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
                        primaryColor =
                            val.isNotEmpty ? Colors.blue : Colors.grey;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the feedback first';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 10,
                    controller: _bodyController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: "Enter your feedback",
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                      ),
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
                  Text(
                    "Upload screenshot (optional)",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _openImagePicker();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFE5E5E5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.add,
                                color: Color(0xFFA5A5A5),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0.w,
                        ),
                        for (var i = 0; i < attachments.length; i++)
                          Row(
                            children: <Widget>[
                              SizedBox(
                                width: 100.w,
                                child: Text(
                                  attachments[i],
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                  ),
                                  softWrap: false,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove_circle),
                                onPressed: () => {_removeAttachment(i)},
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                    style: Constants.buttonStyle(primaryColor),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(
                          () {
                            send();
                          },
                        );
                      }
                    },
                    child: Text(
                      "Send",
                      style: Constants.buttonText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openImagePicker() async {
    final picker = ImagePicker();
    XFile? pick = await picker.pickImage(source: ImageSource.gallery);
    if (pick != null) {
      setState(
        () {
          attachments.add(pick.path);
        },
      );
    }
  }

  void _removeAttachment(int index) {
    setState(
      () {
        attachments.removeAt(index);
      },
    );
  }

  Widget buildCheckItem({String? title, bool? isSelected}) {
    return Container(
      padding: EdgeInsets.all(6.0.w),
      child: Row(
        children: [
          Icon(
            isSelected! ? Icons.check_circle : Icons.circle,
            color: isSelected ? Colors.blue : Colors.grey.shade500,
          ),
          SizedBox(width: 10.0.w),
          Text(
            title!,
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.blue : Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
