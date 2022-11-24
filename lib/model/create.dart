import 'package:hive/hive.dart';

part 'create.g.dart';

@HiveType(typeId: 1)
class CreateQr extends HiveObject {
  @HiveField(0)
  late String qrCodeValue;
  @HiveField(1)
  late String formate;

  CreateQr(this.qrCodeValue, this.formate);
}
