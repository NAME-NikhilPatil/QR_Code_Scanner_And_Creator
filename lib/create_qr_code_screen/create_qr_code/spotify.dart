import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../providers/scan_data.dart';
import '../../components/box.dart';
import '../../constants.dart';
import '../../model/create.dart';
import '../sava_qr_code.dart';

class Spotify extends StatefulWidget {
  const Spotify({super.key});

  @override
  State<Spotify> createState() => _SpotifyState();
}

class _SpotifyState extends State<Spotify> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey;

  TextEditingController controller2 = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> deviceInfo() async {
    String name = controller.text;
    String sname = controller1.text;
    _dataString = "https://open.spotify.com/search/$name;$sname";
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
                  const Boxy(text: "Spotify", image: "spotify"),
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
                          "Artist Name",
                          style: TextStyle(
                            color: Colors.grey.shade500,
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
                            primaryColor = val.isNotEmpty
                                ? Constants.primaryColor
                                : Colors.grey;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the artist name first';
                          }
                          return null;
                        },
                        minLines: 1,
                        controller: controller,
                        autofocus: true,
                        decoration: InputDecoration(
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        child: Text(
                          "Song Name",
                          style: TextStyle(
                            color: Colors.grey.shade500,
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
                            primaryColor = val.isNotEmpty
                                ? Constants.primaryColor
                                : Colors.grey;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the song name first';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        minLines: 1,
                        controller: controller1,
                        autofocus: true,
                        decoration: InputDecoration(
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
                          createDb.addItemC(CreateQr(_dataString, "spotify"));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SaveQrCode(
                                        dataString: _dataString,
                                        formate: 'spotify',
                                      )));
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
