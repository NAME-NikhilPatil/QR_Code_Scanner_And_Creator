import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/constants.dart';

import '../../providers/scan_data.dart';
import '../../components/box.dart';
import '../../model/create.dart';
import '../sava_qr_code.dart';

class Whatsapp extends StatefulWidget {
  const Whatsapp({super.key});

  @override
  State<Whatsapp> createState() => _WhatsappState();
}

class _WhatsappState extends State<Whatsapp> {
  GlobalKey globalKey = GlobalKey();
  late String _dataString;
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  Color primaryColor = Colors.grey.shade500;
  late FlCountryCodePicker countryCodePicker;

  @override
  void initState() {
    try {
      final favoriteCountries = ['IN', 'US', 'AU', 'JP'];
      countryCodePicker = FlCountryCodePicker(
        favorites: favoriteCountries,
        favoritesIcon: const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      );
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  Future<void> deviceInfo() async {
    _dataString =
        "https://api.whatsapp.com/send/?phone=${countryCode?.dialCode}${controller.text}";
  }

  final _formKey = GlobalKey<FormState>();

  // final countryPicker = const FlCountryCodePicker();
  CountryCode? countryCode;

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
                  const Boxy(text: "Whatsapp", image: "whatsapp"),
                  SizedBox(
                    height: 30.h,
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
                        return 'Please enter the number first';
                      } else if (int.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    controller: controller,
                    autofocus: true,
                    decoration: InputDecoration(
                      prefixIcon: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.w, vertical: 5.h),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                final code = await countryCodePicker.showPicker(
                                    context: context);
                                setState(() {
                                  countryCode = code;
                                });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    child: countryCode != null
                                        ? countryCode!.flagImage
                                        : null,
                                  ),
                                  SizedBox(
                                    width: 7.w,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                        color: Constants.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Text(
                                      countryCode?.dialCode ?? "+1",
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      hintText: "Please enter number",
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
                  SizedBox(
                    height: 30.h,
                  ),
                  ElevatedButton(
                    style: Constants.buttonStyle(primaryColor),
                    onPressed: () {
                      try {
                        if (countryCode != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SaveQrCode(
                                dataString: _dataString,
                                formate: "whatsapp",
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                "Please select the country code",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: Constants.primaryColor,
                            ),
                          );
                        }
                        if (_formKey.currentState!.validate()) {
                          deviceInfo();
                          var createDb =
                              Provider.of<ScanData>(context, listen: false);
                          createDb.addItemC(CreateQr(_dataString, "whatsapp"));
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
