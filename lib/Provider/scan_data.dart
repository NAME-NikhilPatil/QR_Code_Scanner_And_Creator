import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:qr_code_scan/model/create.dart';
import 'package:qr_code_scan/model/history.dart';

class ScanData with ChangeNotifier {
  addItem(History? item) async {
    var box = await Hive.openBox<History>('history');

    box.add(item!);

    notifyListeners();
  }

  addItemC(CreateQr item) async {
    var boxy = await Hive.openBox<CreateQr>('create');

    boxy.add(item);
    print(item.qrCodeValue);

    notifyListeners();
  }

  List? _historyList = <History>[];

  List? get historyList => _historyList;
  List _createList = <CreateQr>[];

  List get createList => _createList;
  bool click = true;
  bool clicked(){
    return click=true;
    notifyListeners();
  }
  


  getItem() async {
    final box = await Hive.openBox<History>('history');

    List historyLissy = box.values.toList();
    _historyList = historyLissy.reversed.toList();

    notifyListeners();
  }

  getItemC() async {
    final boxy = await Hive.openBox<CreateQr>('create');

    List createLissy = boxy.values.toList();
    _createList = createLissy.reversed.toList();

    notifyListeners();
  }

  deleteItem() {
    final box = Hive.box<History>('history');

    box.clear();

    notifyListeners();
  }

  deleteItemC() {
    final box = Hive.box<CreateQr>('create');

    box.clear();

    notifyListeners();
  }
  
}
