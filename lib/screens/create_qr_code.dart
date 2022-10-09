import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:qr_code_scan/Create_Qr_Code/Clipboard/clipboard.dart';
import 'package:qr_code_scan/Create_Qr_Code/Text/text.dart';
import 'package:qr_code_scan/Create_Qr_Code/sms/sms.dart';

import '../Create_Qr_Code/website/website.dart';
import '../components/create_box.dart';

class CreateQrCode extends StatefulWidget {
  const CreateQrCode({Key? key}) : super(key: key);

  @override
  State<CreateQrCode> createState() => _CreateQrCodeState();
}

class _CreateQrCodeState extends State<CreateQrCode> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                ),
                Text(
                  "QR Code Creator",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Clipboard(),
                              ),
                            );
                          }),
                          child: CreateBox(
                            text: 'Clipboard',
                            image: 'clipboard',
                            // image: 'assets/clipboard.png',
                          ),
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>const Website(),
                              ),
                            );
                          }),
                          child: CreateBox(
                            text: 'Website',
                            image: 'website',
                            // image: 'assets/website.png',
                          ),
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        CreateBox(
                          text: 'Wi-Fi',
                          image: 'wifi',
                          // image: 'assets/wifi.png',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CreateBox(
                          text: 'Facebook',
                          image: 'facebook',
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        CreateBox(
                          text: 'Youtube',
                          image: 'youtube',
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        CreateBox(
                          text: 'Whatsapp',
                          // image: 'assets/whatsapp.png',
                          image: 'whatsapp',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Textbox(),
                              ),
                            );
                          }), 
                          child: CreateBox(
                            text: 'Text',
                            // image: 'assets/text.png',
                            image: 'text',
                          ),
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        CreateBox(
                          text: 'Contacts',
                          // image: 'assets/contacts.png',
                          image: 'contacts',
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        CreateBox(
                          text: 'Telephone',
                          // image: 'assets/telephone.png',
                          image: 'telephone',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CreateBox(
                          text: 'E-mail',
                          // image: 'assets/email.png',
                          image: 'email',
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Sms(),
                              ),
                            );
                          }), 
                          child: CreateBox(
                            text: 'SMS',
                            // image: 'assets/sms.png',
                            image: 'sms',
                          ),
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        CreateBox(
                          text: 'My Card',
                          image: 'mycard',
                          // image: 'assets/mycard.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
