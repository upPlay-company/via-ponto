import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/empresas/empresas.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';

class Turno {

  Turno.fromParse(ParseObject object) {
    id = object.objectId;
    primeiraEntrada = object.get<String>(keyTurnoPrimeiraEntrada);
    primeiraSaida = object.get<String>(keyTurnoPrimeiraSaida);
    segundaEntrada = object.get<String>(keyTurnoSegundaEntrada);
    segundaSaida = object.get<String>(keyTurnoSegundaSaida);
    empresas = Empresas.fromParse(object.get<ParseObject>(keyTurnoEmpresa));
    nomeDepartamento = object.get<String>(keyTurnoNomeDepartamento);
    diaSemana = object.get<String>(keyTurnoDiaSemana);
    created = object.get<DateTime>(keyTurnoAt);
  }

  Turno();

  String id;
  String segundaEntrada;
  String segundaSaida;
  String primeiraEntrada;
  String primeiraSaida;
  String departamento;
  Empresas empresas;
  String diaSemana;
  String nomeDepartamento;
  DateTime created;

  @override
  String toString() {
    return 'Turno{id: $id, segundaEntrada: $segundaEntrada, segundaSaida: $segundaSaida, primeiraEntrada: $primeiraEntrada, primeiraSaida: $primeiraSaida, departamento: $departamento, empresas: $empresas, diaSemana: $diaSemana, nomeDepartamento: $nomeDepartamento, created: $created}';
  }
}