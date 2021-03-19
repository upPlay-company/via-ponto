import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/repository/parse_errors.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class BaterPontoRepository {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  var formatTime = DateFormat("HH:mm:ss").format(DateTime.now());

  Future<void> save(BaterPonto ponto) async {

    final parseUser = ParseUser(userManagerStore.user.userName, userManagerStore.user.password, userManagerStore.user.email)..set(keyUserId, userManagerStore.user.id);

    final PontoObject = ParseObject(keyPontoTable);

    if(ponto != null) PontoObject.objectId = ponto.id;

    final parseAcl = ParseACL(owner: parseUser);
    parseAcl.setPublicReadAccess(allowed: true);
    parseAcl.setPublicWriteAccess(allowed: false);
    PontoObject.setACL(parseAcl);

    PontoObject.set<String>(keyPontoLocal, 'Rua Elias Gorayeb, 3091');
    PontoObject.set<String>(keyPontoHorario, formatTime);
    PontoObject.set<ParseUser>(keyPontoIdUser, parseUser);
    PontoObject.set<int>(keyPontoQuantity, 1);
    PontoObject.set<String>(keyPontoRegistro, 'entrada');
    PontoObject.set<ParseObject>(keyPontoIdEmpresa,
          ParseObject(keyEmpresaTable)..set(keyEmpresaId, userManagerStore.user.idEmpresa.id));

    final response = await PontoObject.save();

    if(!response.success){
      return Future.error(ParseErrors.getDescription(response.error.code));
    }

  }

}