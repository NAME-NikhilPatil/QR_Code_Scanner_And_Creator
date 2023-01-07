import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scan/constants.dart';
import 'package:qr_code_scan/history_screen/history_screen.dart';
import 'package:qr_code_scan/home_screen/qr_code_scan..dart';
import 'package:qr_code_scan/setting_screen/settings.dart';
import '../create_qr_code_screen/create_qr_code.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({
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
    List<Widget> widgetOptions = <Widget>[
      const QrScanScreen(),
      const History_screen(),
      const CreateQrCode(),
      const Settings(),
    ];
    

    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
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
        unselectedItemColor: Colors.grey.shade500,
        selectedItemColor: Constants.primaryColor,
      
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
