import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';


class BookingQRGenerate extends StatefulWidget {
  final dynamic abid;
  final dynamic uid;
  final dynamic txnid;

  const BookingQRGenerate({
    super.key,
    required this.abid,
    required this.uid,
    required this.txnid,
  });
  @override
  State<StatefulWidget> createState() => BookingQRGenerateState();
}

class BookingQRGenerateState extends State<BookingQRGenerate> {
  GlobalKey globalKey = GlobalKey();
  String _dataString = "Hello from this QR";
  bool? physicaldevice;
  var deviceid;

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
    deviceInfo();
  }

  Future<void> deviceInfo() async {
    abid = widget.abid;
    txnid = widget.txnid;
    uid = widget.uid;
    _dataString = '''
  {
  "abid": ${widget.abid},  
  "uid":${widget.uid},
  "txnid":${widget.txnid}
  }
  ''';

    print("_dataString $_dataString");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: _contentWidget(),
      ),
    );
  }

  _contentWidget() {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13.0)),
            color: Colors.blueGrey[300],
            child: const ListTile(
              title: Text(
                'QRCode',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: QrImage(
                    data: _dataString,
                    // data:abid,  uid,  txnid,
                    version: QrVersions.auto,
                    size: 200,
                    gapless: false,
                    embeddedImage: const AssetImage('assets/img/logo.png'),
                    embeddedImageStyle: QrEmbeddedImageStyle(
                      size: const Size(50, 50),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

