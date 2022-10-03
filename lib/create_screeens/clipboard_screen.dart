import 'package:flutter/material.dart';

class ClipboardScreen extends StatelessWidget {
  const ClipboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Create Qr Code from Clipboard"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("Hello"),
        ),
      ),
    );
  }
}
