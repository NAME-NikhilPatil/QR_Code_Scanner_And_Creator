import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/bottom_navigation.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() async {
  await init();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 667),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Qr Code Scanner',
          // You can use the library anywhere in the app even in theme
          theme: ThemeData(),

          initialRoute: child.toString(),
          routes: {
            '/': (context) => const MyNavigationBar(),
            // When navigating to the "/second" route, build the SecondScreen widget.
            // '/second': (context) => ScanResult(),
          },
        );
      },
      child: const MyNavigationBar(),
    );
  }
}
