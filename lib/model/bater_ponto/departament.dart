import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/empresas/empresas.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';

class Departament {

  Departament({this.id,
    this.nome,
    this.empresas
  });

  Departament.fromParse(ParseObject parseObject)
      : id = parseObject.objectId,
      nome = parseObject.get<String>(keyDepartamentNome),
      empresas = Empresas.fromParse(parseObject.get<ParseObject>(keyDepartamentEmpresa));


  String id;
  String nome;
  Empresas empresas;


}