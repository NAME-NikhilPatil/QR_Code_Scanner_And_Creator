import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanData with ChangeNotifier{
  Barcode? barcode;
  Barcode? get BarcodeResult=>barcode;
  
}