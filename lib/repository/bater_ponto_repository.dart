import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/model/users/user.dart';
import 'package:viaponto_oficial/repository/parse_errors.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';
import 'package:viaponto_oficial/store/my_turno_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class BaterPontoRepository {
  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  String formatTimeBanco = DateFormat("HH:mm").format(DateTime.now());

  String formatTime = DateFormat("HH:mm")
      .format(DateTime.now())
      .replaceAll(new RegExp(':'), '');

  String semana = DateFormat("EEEE", "pt_BR").format(DateTime.now());

  String diaSemana = DateFormat("dd/MM/yyyy", "pt_BR").format(DateTime.now());

  String semanaEntrada1,
      semanaEntrada2,
      semanaSaida1,
      semanaSaida2,
      sabadoEntrada1,
      sabadoEntrada2,
      sabadoSaida1,
      sabadoSaida2,
      domingoEntrada1,
      domingoEntrada2,
      domingoSaida1,
      domingoSaida2;

  Future<void> save(BaterPonto ponto, MyTurnoStore myTurnoStore) async {
      final parseUser = ParseUser(userManagerStore.user.userName,
          userManagerStore.user.password, userManagerStore.user.email)
        ..set(keyUserId, userManagerStore.user.id);

      // ignore: non_constant_identifier_names
      final PontoObject = ParseObject(keyPontoTable);

      final parseAcl = ParseACL(owner: parseUser);
      parseAcl.setPublicReadAccess(allowed: true);
      parseAcl.setPublicWriteAccess(allowed: false);
      PontoObject.setACL(parseAcl);

      PontoObject.set<String>(keyPontoLocal, ponto.localization);
      PontoObject.set<String>(keyPontoHorario, formatTimeBanco);
      PontoObject.set<String>(keyPontoDiaSemana, semana);
      PontoObject.set<String>(keyPontoDate, diaSemana);
      PontoObject.set<ParseUser>(keyPontoIdUser, parseUser);

      int horaAtual = int.parse(formatTime);

      if (userManagerStore.user.idEmpresa.id ==
          myTurnoStore.allAds[0].empresas.id) {
        if (semana == 'sabado') {

            sabadoEntrada1 = myTurnoStore.allAds[5].primeiraEntrada
                .replaceAll(new RegExp(':'), '');
            sabadoSaida1 = myTurnoStore.allAds[5].primeiraSaida
                .replaceAll(new RegExp(':'), '');
            sabadoEntrada2 = myTurnoStore.allAds[5].segundaEntrada
                .replaceAll(new RegExp(':'), '');
            sabadoSaida2 = myTurnoStore.allAds[5].segundaSaida
                .replaceAll(new RegExp(':'), '');

          int sabadoentrada1 = sabadoEntrada1 == 'nao definido' ? 0000 : int.parse(sabadoEntrada1);
          int sabadoentrada2 = sabadoEntrada2 == 'nao definido' ? 0000 : int.parse(sabadoEntrada2);
          int sabadosaida1 = sabadoSaida1 == 'nao definido' ? 0000 : int.parse(sabadoSaida1) ;
          int sabadosaida2 = sabadoSaida2 == 'nao definido' ? 0000 : int.parse(sabadoSaida2) ;

          int hora1saida30antes = sabadosaida1 - 0070;
          int hora2saida30antes = sabadosaida2 - 0070;

          if (horaAtual <= sabadoentrada1 ||
              horaAtual >= sabadoentrada1 && horaAtual < hora1saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '1ª Entrada');
          } else if (horaAtual >= hora1saida30antes &&
              horaAtual < sabadoentrada2) {
            PontoObject.set<String>(keyPontoRegistro, '1ª Saída');
          } else if (horaAtual >= sabadoentrada2 &&
              horaAtual < hora2saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '2ª Entrada');
          } else if (horaAtual >= hora2saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '2ª Saída');
          }
        } else if (semana == 'domingo') {

            domingoEntrada1 = myTurnoStore.allAds[6].primeiraEntrada.replaceAll(new RegExp(':'), '');
            domingoSaida1 = myTurnoStore.allAds[6].primeiraSaida.replaceAll(new RegExp(':'), '');
            domingoEntrada2 = myTurnoStore.allAds[6].segundaEntrada.replaceAll(new RegExp(':'), '');
            domingoSaida2 = myTurnoStore.allAds[6].segundaSaida.replaceAll(new RegExp(':'), '');

          int domingoentrada1 = domingoEntrada1 == 'nao definido' ? 0000 : int.parse(domingoEntrada1);
          int domingoentrada2 = domingoEntrada2 == 'nao definido' ? 0000 : int.parse(domingoEntrada2);
          int domingosaida1 = domingoSaida1 == 'nao definido' ? 0000 : int.parse(domingoSaida1);
          int domingosaida2 = domingoSaida2 == 'nao definido' ? 0000 : int.parse(domingoSaida2);

          int hora1saida30antes = domingosaida1 - 0070;
          int hora2saida30antes = domingosaida2 - 0070;

          if (horaAtual <= domingoentrada1 ||
              horaAtual >= domingoentrada1 && horaAtual < hora1saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '1ª Entrada');
          } else if (horaAtual >= hora1saida30antes &&
              horaAtual < domingoentrada2) {
            PontoObject.set<String>(keyPontoRegistro, '1ª Saída');
          } else if (horaAtual >= domingoentrada2 &&
              horaAtual < hora2saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '2ª Entrada');
          } else if (horaAtual >= hora2saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '2ª Saída');
          }
        } else {
          // segunda a sexta
          print('entrou');
          semanaEntrada1 = myTurnoStore.allAds[0].primeiraEntrada
              .replaceAll(new RegExp(':'), '');
          semanaEntrada2 = myTurnoStore.allAds[0].segundaEntrada
              .replaceAll(new RegExp(':'), '');
          semanaSaida1 = myTurnoStore.allAds[0].primeiraSaida
              .replaceAll(new RegExp(':'), '');
          semanaSaida2 = myTurnoStore.allAds[0].segundaEntrada
              .replaceAll(new RegExp(':'), '');
          int horaentrada1 = int.parse(semanaEntrada1);
          int horaentrada2 = int.parse(semanaEntrada2);
          int horasaida1 = int.parse(semanaSaida1);
          int horasaida2 = int.parse(semanaSaida2);

          print(horasaida1);

          int hora1saida30antes = horasaida1 - 0070;
          int hora2saida30antes = horasaida2 - 0070;

          if (horaAtual <= horaentrada1 ||
              horaAtual >= horaentrada1 && horaAtual < hora1saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '1ª Entrada');
          } else if (horaAtual >= hora1saida30antes &&
              horaAtual < horaentrada2) {
            print('entrou saida');
            PontoObject.set<String>(keyPontoRegistro, '1ª Saída');
          } else if (horaAtual >= horaentrada2 &&
              horaAtual < hora2saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '2ª Entrada');
          } else if (horaAtual >= hora2saida30antes) {
            PontoObject.set<String>(keyPontoRegistro, '2ª Saída');
          }
        }
      }

      PontoObject.set<int>(keyPontoQuantity, ponto.quantity);
      PontoObject.set<ParseObject>(
          keyPontoIdEmpresa,
          ParseObject(keyEmpresaTable)
            ..set(keyEmpresaId, userManagerStore.user.idEmpresa.id));

      final response = await PontoObject.save();

      print(response.statusCode);

      if (!response.success) {
        return Future.error(ParseErrors.getDescription(response.error.code));
      }
  }

  Future<List<BaterPonto>> getMyPonto(User user) async {
    final currentUser = ParseUser(user.userName, user.password, user.email)
      ..set(keyUserId, user.id);
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
