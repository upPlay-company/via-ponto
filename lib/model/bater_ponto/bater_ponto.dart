import 'package:viaponto_oficial/model/empresas/empresas.dart';
import 'package:viaponto_oficial/model/users/user.dart';

class BaterPonto {

  String id;
  String time;
  String localization;
  int quantity;
  String registro;
  Empresas empresas;
  User user;
  DateTime created;

  @override
  String toString() {
    return 'BaterPonto{id: $id, time: $time, localization: $localization, quantity: $quantity, empresas: $empresas, user: $user, created: $created}';
  }
}