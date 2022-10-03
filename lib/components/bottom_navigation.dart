import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qr_code_scan/screens/exit.dart';
import '../screens/create_qr_code.dart';
import '../screens/home_screen.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int _selectedIndex = 0;
   static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text('Search Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    CreateQrCode(),
    Text("hello")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        body: Center(
          child: _widgetOptions[_selectedIndex],
          // _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.qr_code_scanner),
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
          // iconSize: 30.h,
          // selectedFontSize: 14.h,
          // unselectedFontSize: 12.h,
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.grey.shade500,
          selectedItemColor:Colors.blue,
          backgroundColor: Colors.white,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
        //      Container(
        //       height: 60.h,
        //       decoration: BoxDecoration(
        //           color: Colors.black,),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceAround,
        //         children: [
        //           Bottom_Navigation_Bar(
        //             icon: Icons.qr_code_scanner,
        //             iconName: 'SCAN',
        //             index: 0,
        //             selected: _selectedIndex == 0,
        //           ),
        //           Bottom_Navigation_Bar(
        //             icon: MdiIcons.clockTimeFiveOutline,
        //             iconName: 'HISTORY',
        //             index: 1,
        //             selected: _selectedIndex == 1,
        //           ),
        //           Bottom_Navigation_Bar(
        //             icon: Icons.add_box_outlined,
        //             iconName: 'CREATE',
        //             index: 2,
        //             selected: _selectedIndex == 2,
        //           ),
        //           Bottom_Navigation_Bar(
        //             icon: Icons.settings_outlined,
        //             iconName: 'SETTING',
        //             index: 3,
        //             selected: _selectedIndex == 3,
        //           ),
        //         ],
        //       ),
        //     ),
        //   );
        // }

        // GestureDetector Bottom_Navigation_Bar(
        //     {required IconData icon,
        //     String? iconName,
        //     int? index,
        //     required bool selected}) {
        //   return GestureDetector(
        //     onTap: () => setState(() {
        //       _selectedIndex = index!;
        //     }),
        //     child: SizedBox(
        //       width: 92.w,
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(
        //             icon,
        //             color: selected ? Colors.white : Colors.grey,
        //             size: 30.h,
        //           ),
        //           SizedBox(
        //             height: 5.h,
        //           ),
        //           Text(
        //             iconName!,
        //             style: TextStyle(
        //               fontSize: 14.h,
        //               color: selected ? Colors.white : Colors.grey,
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
      ),
    );
  }
}
