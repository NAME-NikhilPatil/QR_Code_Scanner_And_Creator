import 'package:hive/hive.dart';
import 'package:qr_code_scan/model/history.dart';

class Boxes{
  static Box<History> getHistory()=>Hive.box<History>('history');
}