import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/bater_ponto/turno.dart';
import 'package:viaponto_oficial/model/users/user.dart';
import 'package:viaponto_oficial/repository/parse_errors.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';

class MyTurnoRepository {

  Future<List<Turno>> getMyTurno(User user) async {

    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyTurnoTable));

    queryBuilder.whereEqualTo(keyTurnoIdDepartament, user.departamento.id);
    queryBuilder.includeObject([keyTurnoEmpresa]);

    final response = await queryBuilder.query();

    if (response.success && response.results != null) {
      return response.results.map((po) => Turno.fromParse(po)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

}