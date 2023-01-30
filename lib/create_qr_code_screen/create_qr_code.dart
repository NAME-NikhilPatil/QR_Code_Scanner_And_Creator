import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/clipboard.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/email.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/text.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/contacts.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/facebook.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/instagram.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/mycard.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/sms.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/spotify.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/telephone.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/twitter.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/whatsapp.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/wifi.dart';
import 'package:qr_code_scan/create_qr_code_screen/create_qr_code/youtube.dart';

import '../components/bottom_navigation.dart';
import 'create_qr_code/website.dart';
import '../components/create_box.dart';
import '../constants.dart';

class CreateQrCode extends StatefulWidget {
  const CreateQrCode({Key? key}) : super(key: key);

  @override
  State<CreateQrCode> createState() => _CreateQrCodeState();
}

class _CreateQrCodeState extends State<CreateQrCode> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MyNavigationBar()))
          as dynamic,
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "QR Code Creator",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 21.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            child: const CreateBox(
                              text: 'Text',
                              // image: 'assets/text.png',
                              image: 'text',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Telephone(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Telephone',
                              // image: 'assets/telephone.png',
                              image: 'telephone',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Website(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Website',
                              image: 'website',
                              // image: 'assets/website.png',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Wifi(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Wi-Fi',
                              image: 'wifi',
                              // image: 'assets/wifi.png',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Whatsapp(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Whatsapp',
                              // image: 'assets/whatsapp.png',
                              image: 'whatsapp',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Instagram(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Instagram',
                              image: 'instagram',
                              // image: 'assets/mycard.png',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Youtube(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Youtube',
                              image: 'youtube',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Facebook(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Facebook',
                              image: 'facebook',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Clipboar(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Clipboard',
                              image: 'clipboard',
                              // image: 'assets/clipboard.png',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Twitter(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Twitter',
                              // image: 'assets/email.png',
                              image: 'twitter',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Email(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'E-mail',
                              // image: 'assets/email.png',
                              image: 'email',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Contacts(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Contacts',
                              // image: 'assets/contacts.png',
                              image: 'contacts',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Spotify(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'Spotify',
                              // image: 'assets/sms.png',
                              image: 'spotify',
                            ),
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
                            child: const CreateBox(
                              text: 'SMS',
                              // image: 'assets/sms.png',
                              image: 'sms',
                            ),
                          ),
                          GestureDetector(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyCard(),
                                ),
                              );
                            }),
                            child: const CreateBox(
                              text: 'My Card',
                              image: 'mycard',
                              // image: 'assets/mycard.png',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                    ],
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
