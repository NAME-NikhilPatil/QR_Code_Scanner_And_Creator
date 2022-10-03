import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scan/qr_code_create_code.dart/sava_qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Website extends StatefulWidget {
  const Website({super.key});
//  dynamic dtguid;

//   dynamic abid;
//   dynamic txnid;
//   dynamic uid;

  @override
  State<Website> createState() => _WebsiteState();
}

class _WebsiteState extends State<Website> {
  GlobalKey globalKey = GlobalKey();
  String _dataString = "Hello from this QR";
  bool? physicaldevice;
  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  dynamic dtguid;

  dynamic abid;
  dynamic txnid;
  dynamic uid;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  takeScreenShot(ref) async {
    PermissionStatus res;
    res = await Permission.storage.request();
    if (res.isGranted) {
      final boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 5.0);
      final byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
      if (byteData != null) {
        final pngBytes = byteData.buffer.asUint8List();
        final directory = (await getApplicationDocumentsDirectory()).path;
        final imgFile = File(
          '$directory/${DateTime.now()}${ref.qrData!}.png',
        );
        imgFile.writeAsBytes(pngBytes);
        GallerySaver.saveImage(imgFile.path).then((success) async {
          await ref.createQr(ref.qrData!);
        });
      }
    }
  }

  Future<void> deviceInfo() async {
    // abid = ;
    // txnid = txnid;
    // uid = uid;
    _dataString = '''
  {
  "abid": ${controller.text},  
  "uid":${controller1.text},
  "txnid":${controller2.text}
  }
  ''';

    print("_dataString $_dataString");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [_contentWidget()],
          ),
        ),
      ),
    );
  }

  _contentWidget() {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          // Card(
          //   elevation: 8.0,
          //   shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(13.0)),
          //   color: Colors.blueGrey[300],
          //   child: const ListTile(
          //     title: Text(
          //       'QRCode',
          //       style: TextStyle(
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),
          TextField(controller: controller, autofocus: true,),
          TextField(controller: controller1, autofocus: true),
          TextField(controller: controller2, autofocus: true),
          TextButton(
              onPressed: () {
                deviceInfo();
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SaveWebsite(dataString: _dataString,)));
              },
              child: Text("Generate")),
              // Container(
              //   color: Colors.white,
              //   child: Center(
              //     child: RepaintBoundary(
              //       key: globalKey,
              //       child: QrImage(
              //         data: _dataString,
              //         // data:abid,  uid,  txnid,
              //         version: QrVersions.auto,
              //         size: 200,
              //         gapless: false,
              //         embeddedImage: const AssetImage('assets/img/logo.png'),
              //         embeddedImageStyle: QrEmbeddedImageStyle(
              //           size: const Size(70, 70),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            //  Center(
            //   child: RepaintBoundary(
            //     key: globalKey,
            //     child: QrImage(
            //       data: _dataString,
            //       size: 250,
            //       backgroundColor: Colors.white,
            //       version: QrVersions.auto,
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 25),
            // CupertinoButton(
            //   child: const Text("Save"),
            //   onPressed: () => takeScreenShot(_dataString),
            // ),
          // Expanded(
          //   child: Container(
          //     color: Colors.white,
          //     child: Center(
          //       child: RepaintBoundary(
          //         key: globalKey,
          //         child: QrImage(
          //           data: _dataString,
          //           // data:abid,  uid,  txnid,
          //           version: QrVersions.auto,
          //           size: 200,
          //           gapless: false,
          //           embeddedImage: const AssetImage('assets/img/logo.png'),
          //           embeddedImageStyle: QrEmbeddedImageStyle(
          //             size: const Size(50, 50),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}


// // class BookingQRGenerate extends StatefulWidget {
// //   // final dynamic abid;
// //   // final dynamic uid;
// //   // final dynamic txnid;

// //   const BookingQRGenerate({
// //     super.key,
// //     // required this.abid,
// //     // required this.uid,
// //     // required this.txnid,
// //   });
// //   @override
// //   State<StatefulWidget> createState() => BookingQRGenerateState();
// // }

// class BookingQRGenerateState extends State<BookingQRGenerate> {
//   GlobalKey globalKey = GlobalKey();
//   String _dataString = "Hello from this QR";
//   bool? physicaldevice;
//   var deviceid;

//   dynamic dtguid;

//   dynamic abid;
//   dynamic txnid;
//   dynamic uid;

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]);
//   }

//  @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: _contentWidget(),
//       ),
//     );
//   }


    
  
 
  

  

