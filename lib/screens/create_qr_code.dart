import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_code_scan/Create_Qr_Code/Clipboard/clipboard.dart';
import 'package:qr_code_scan/Create_Qr_Code/E-mail/email.dart';
import 'package:qr_code_scan/Create_Qr_Code/Text/text.dart';
import 'package:qr_code_scan/Create_Qr_Code/contacts/contacts.dart';
import 'package:qr_code_scan/Create_Qr_Code/facebook/facebook.dart';
import 'package:qr_code_scan/Create_Qr_Code/instagram/instagram.dart';
import 'package:qr_code_scan/Create_Qr_Code/my_card/mycard.dart';
import 'package:qr_code_scan/Create_Qr_Code/sms/sms.dart';
import 'package:qr_code_scan/Create_Qr_Code/spotify/spotify.dart';
import 'package:qr_code_scan/Create_Qr_Code/telephone/telephone.dart';
import 'package:qr_code_scan/Create_Qr_Code/twitter/twitter.dart';
import 'package:qr_code_scan/Create_Qr_Code/whatsapp/whatsapp.dart';
import 'package:qr_code_scan/Create_Qr_Code/wifi/wifi.dart';
import 'package:qr_code_scan/Create_Qr_Code/youtube/youtube.dart';
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
    ScreenUtil.init(context, designSize: const Size(375, 667));

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                builder: (context) => const Whatsapp(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
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
                          child:const  CreateBox(
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
                                builder: (context) => const Twitter(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
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
                                builder: (context) => const Youtube(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
                            text: 'Youtube',
                            image: 'youtube',
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
                          child:const  CreateBox(
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
                                builder: (context) => const Spotify(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
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
                                builder: (context) => const Clipboar(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
                            text: 'Clipboard',
                            image: 'clipboard',
                            // image: 'assets/clipboard.png',
                          ),
                        ),
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Wifi(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
                            text: 'Wi-Fi',
                            image: 'wifi',
                            // image: 'assets/wifi.png',
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
                                builder: (context) => const Textbox(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
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
                                builder: (context) => const Contacts(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
                            text: 'Contacts',
                            // image: 'assets/contacts.png',
                            image: 'contacts',
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
                          child:const  CreateBox(
                            text: 'Telephone',
                            // image: 'assets/telephone.png',
                            image: 'telephone',
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
                                builder: (context) => const Email(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
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
                                builder: (context) => const Sms(),
                              ),
                            );
                          }),
                          child:const  CreateBox(
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
                          child:const  CreateBox(
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
    );
  }
}
