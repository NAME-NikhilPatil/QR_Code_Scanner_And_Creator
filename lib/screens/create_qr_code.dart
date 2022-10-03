import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scan/qr_code_create_code.dart/website.dart';

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
                        CreateBox(
                          text: 'Clipboard',
                          image: 'clipboard',
                          // image: 'assets/clipboard.png',
                        ),
                        SizedBox(
                          width: 44.w,
                        ),
                        CreateBox(
                          text: 'Website',
                          image: 'website',
                          // image: 'assets/website.png',
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
                        CreateBox(
                          text: 'Text',
                          // image: 'assets/text.png',
                          image: 'text',
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
                        CreateBox(
                          text: 'SMS',
                          // image: 'assets/sms.png',
                          image: 'sms',
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

class CreateBox extends StatelessWidget {
  CreateBox({
    super.key,
    required this.text,
    required this.image,
  });

  String text;
  String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            // builder: (context) => const BookingQRGenerate(
            //   abid: "Hello NIkhil ",
            //   txnid: "How are you?",
            //   uid: "I am fine",
            builder: (context) => const Website(),
          ),
        );
      }),
      child: Column(
        children: [
          Container(
            height: 74.h,
            width: 74.w,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/$image.svg",
                  fit: BoxFit.cover,
                  height: 40.h,
                  width: 40.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.black,
              // fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
