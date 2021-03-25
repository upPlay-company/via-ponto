import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/model/users/user.dart';
import 'package:viaponto_oficial/repository/parse_errors.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class BaterPontoRepository {

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  var formatTime = DateFormat("HH:mm:ss").format(DateTime.now());


  Future<void> save(BaterPonto ponto, MyPontoStore store) async {

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

    if(ponto.quantity == 1) PontoObject.set<String>(keyPontoRegistro, '1ª Entrada');
    if(ponto.quantity == 2) PontoObject.set<String>(keyPontoRegistro, '1ª Saída');
    if(ponto.quantity == 3) PontoObject.set<String>(keyPontoRegistro, '2ª Entrada');
    if(ponto.quantity == 4) PontoObject.set<String>(keyPontoRegistro, '2ª Saída');

    PontoObject.set<int>(keyPontoQuantity, ponto.quantity);
    PontoObject.set<ParseObject>(keyPontoIdEmpresa,
          ParseObject(keyEmpresaTable)..set(keyEmpresaId, userManagerStore.user.idEmpresa.id));

    final response = await PontoObject.save();

    if(!response.success){
      return Future.error(ParseErrors.getDescription(response.error.code));
    }

  }

  Future<List<BaterPonto>> getMyPonto(User user) async {
    final currentUser = ParseUser(user.userName, user.password, user.email)..set(keyUserId, user.id);
    final queryBuilder = QueryBuilder<ParseObject>(ParseObject(keyPontoTable));

    queryBuilder.setLimit(100);
    queryBuilder.orderByDescending(keyPontoAt);
    queryBuilder.whereEqualTo(keyPontoIdUser, currentUser.toPointer());
    queryBuilder.includeObject([keyPontoIdEmpresa, keyPontoIdUser]);

    final response = await queryBuilder.query();
    if (response.success && response.results != null) {
      return response.results.map((po) => BaterPonto.fromParse(po)).toList();
    } else if (response.success && response.results == null) {
      return [];
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }
}