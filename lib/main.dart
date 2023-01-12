import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scan/providers/scan_data.dart';
import 'package:qr_code_scan/constants.dart';
import 'package:qr_code_scan/model/history.dart';
import 'package:qr_code_scan/providers/saved_setting.dart';
import 'package:qr_code_scan/other_screen/first_time.dart';
import 'model/create.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SaveSetting.init();
  await ScreenUtil.ensureScreenSize();
  await Hive.initFlutter();
  Hive.registerAdapter(HistoryAdapter());
  Hive.registerAdapter(CreateQrAdapter());
  await Hive.openBox<History>('history');
  await Hive.openBox<CreateQr>('create');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
  // runApp(
  //   DevicePreview(
  //     enabled: true,
  //     tools: [
  //       ...DevicePreview.defaultTools,
  //     ],
  //     builder: (context) => MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 667),
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => ScanData()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Qr Code Scanner',
            theme: ThemeData(
              primaryColor: Constants.primaryColor,
            ),
            home: const FirstTime(),
          ),
        );
      },
    );
  }
}
