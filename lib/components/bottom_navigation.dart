import 'package:flutter/material.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:qr_code_scan/screens/history_screen.dart';
import 'package:qr_code_scan/screens/qr_code_scan..dart';
import 'package:qr_code_scan/settings.dart';
import '../screens/create_qr_code.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    QrScanScreen(),
    History_screen(),
    CreateQrCode(),
    Settings(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        selectedItemColor:  Colors.blue,
        backgroundColor:  Colors.white ,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
