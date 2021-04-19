import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/empresas/empresas.dart';
import 'package:viaponto_oficial/model/users/user.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';
import 'package:viaponto_oficial/repository/user_repository.dart';

class BaterPonto {
  BaterPonto.fromParse(ParseObject object) {
    id = object.objectId;
    time = object.get<String>(keyPontoHorario);
    localization = object.get<String>(keyPontoLocal);
    quantity = object.get<int>(keyPontoQuantity);
    registro = object.get<String>(keyPontoRegistro);
    empresas = Empresas.fromParse(object.get<ParseObject>(keyPontoIdEmpresa));
    user =
        UserRepository().mapParseToUser(object.get<ParseUser>(keyPontoIdUser));
    created = object.createdAt;
  }

  BaterPonto();

  String id;
  String time;
  String localization;
  int quantity = 1;
  String registro;
  Empresas empresas;
  User user;
  DateTime created;

  @override
  String toString() {
    return 'BaterPonto{id: $id, time: $time, localization: $localization, quantity: $quantity, empresas: $empresas, user: $user, created: $created}';
  }
}
