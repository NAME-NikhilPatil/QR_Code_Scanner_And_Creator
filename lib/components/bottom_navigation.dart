import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scan/screens/history_screen.dart';
import 'package:qr_code_scan/screens/qr_code_scan..dart';
import 'package:qr_code_scan/screens/settings.dart';
import 'package:rate_my_app/rate_my_app.dart';

import '../screens/create_qr_code.dart';

class MyNavigationBar extends StatefulWidget {
  MyNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      QrScanScreen(),
      History_screen(),
      CreateQrCode(),
      Settings(),
    ];
    RateMyApp rateMyApp;
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
      builder: (context) =>
          //  rateMyApp == null
          //     ? Center(
          //         child: Settings(),
          //       )
          //     :

          Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.qr_code_scanner,
              ),
              label: 'Scan',
            ),
            BottomNavigationBarItem(
              icon: Icon(MdiIcons.clockTimeFiveOutline),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined),
              label: 'Create',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Setting',
            ),
          ],
          enableFeedback: true,
          currentIndex: selectedIndex,
          unselectedItemColor: Colors.grey[500],
          selectedItemColor: Colors.blue,
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
