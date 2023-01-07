import 'package:hive/hive.dart';

part 'history.g.dart';

@HiveType(typeId: 0)
class History extends HiveObject {
  @HiveField(0)
  Map<dynamic, dynamic> qrCodeValue;

  @HiveField(1)
  String? formate;
  History(this.qrCodeValue, this.formate);
}
