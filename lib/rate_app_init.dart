import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scan/screens/history_screen.dart';
import 'package:qr_code_scan/screens/qr_code_scan..dart';
import 'package:qr_code_scan/screens/settings.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../screens/create_qr_code.dart';

class RateMyAppInit extends StatefulWidget {
  RateMyAppInit({Key? key, required this.builder}) : super(key: key);
  final Widget Function(RateMyApp) builder;
  @override
  State<RateMyAppInit> createState() => _RateMyAppInitState();
}

class _RateMyAppInitState extends State<RateMyAppInit> {
  @override
  RateMyApp? rateMyApp;

  Widget build(BuildContext context) {
    const playStoreId = "com.example.qr_code_scanner";
    return RateMyAppBuilder(
        rateMyApp: RateMyApp(
          googlePlayIdentifier: playStoreId,
          minDays: 0,
          minLaunches: 3,
          remindDays: 1,
          remindLaunches: 2,
        ),
        onInitialized: (context, rateMyApp) {
          setState(() {
            rateMyApp = rateMyApp;
          });
          Widget buildOkButton(double star) {
            return TextButton(
                onPressed: () async {
                  final event = RateMyAppEventType.rateButtonPressed;
                  await rateMyApp.callEvent(event);
                  final launchAppStore = star >= 4;
                  if (launchAppStore) {
                    rateMyApp.launchStore();
                  }

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.white,
                    content: Text(
                      "Thanks for your feedback",
                    ),
                    behavior: SnackBarBehavior.floating,
                  ));

                  Navigator.pop(context);
                },
                child: Text("OK"));
          }

          Widget buildCancelButton() {
            return RateMyAppNoButton(rateMyApp, text: "CANCEL");
          }

          if (rateMyApp.shouldOpenDialog) {
            // rateMyApp.showRateDialog(context);
            rateMyApp.showStarRateDialog(
              context,
              title: "Rate This App",
              message: "Do you like this app?Please leave a rating",
              starRatingOptions: StarRatingOptions(initialRating: 4),
              actionsBuilder: (BuildContext context, double? stars) {
                return stars == null
                    ? [buildCancelButton()]
                    : [buildOkButton(stars), buildCancelButton()];
              },
            );
          }
        },
        builder: (context) => widget.builder(rateMyApp!)

        //  rateMyApp == null
        //     ? Center(
        //         child: Settings(),
        //       )
        //     :

        );
  }
}
