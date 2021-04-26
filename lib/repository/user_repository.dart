import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/empresas/empresas.dart';
import 'package:viaponto_oficial/model/users/user.dart';
import 'package:viaponto_oficial/repository/parse_errors.dart';
import 'package:viaponto_oficial/repository/table_keys.dart';

class UserRepository {

  Future<User> loginWithEmail(String email, String password) async {
    final parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      return Future.error(ParseErrors.getDescription(response.error.code));
    }
  }

  Future<User> currentUser() async {
    final parseUser = await ParseUser.currentUser();
    print(parseUser);
    if (parseUser != null) {
      final response =
      await ParseUser.getCurrentUserFromServer(parseUser.sessionToken);
      if (response.success) {
        return mapParseToUser(response.result);
      } else {
        await parseUser.logout();
      }
    }
    return null;
  }

  Future<void> logout() async {
    final ParseUser currentUser = await ParseUser.currentUser();
    await currentUser.logout();
  }

  Future<void> save(User user) async {
    final ParseUser parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      parseUser.set<String>(keyUserName, user.name);
      parseUser.set<String>(keyUserPhone, user.phone);

      if (user.password != null) {
        parseUser.password = user.password;
      }

      final response = await parseUser.save();

      if (!response.success)
        return Future.error(ParseErrors.getDescription(response.error.code));

      if (user.password != null) {
        await parseUser.logout();

        final loginResponse =
        await ParseUser(user.email, user.password, user.email).login();

        if (!loginResponse.success)
          return Future.error(ParseErrors.getDescription(response.error.code));
      }
    }
  }

  Future<void> update(User user) async {
    final ParseUser parseUser = await ParseUser.currentUser();

    if (parseUser != null) {
      parseUser.set<String>(keyUserEmail, user.email);

      if (user.password != null) {
        parseUser.password = user.password;
      }

      final response = await parseUser.update();

      if (!response.success)
        return Future.error(ParseErrors.getDescription(response.error.code));

      if (user.password != null) {
        await parseUser.logout();

        final loginResponse =
        await ParseUser(user.email, user.password, user.email).login();
      }
    }
  }



  User mapParseToUser(ParseUser parseUser) {
    return User(
      id: parseUser.objectId,
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      cargo: parseUser.get(keyUserCargo),
      cpf: parseUser.get(keyUserCpf),
      dataNasc: parseUser.get(keyUserNasc),
      departamento: parseUser.get(keyUserDepatarmento),
      idEmpresa: Empresas.fromParse(parseUser.get(keyUserIdEmpresa)),
      nomeEmpresa: parseUser.get(keyUserNomeEmpresa),
      userName: parseUser.get(keyUserUserName),
      semanaEntrada1: parseUser.get(keyUserHoraEntrada1),
      semanaEntrada2: parseUser.get(keyUserHoraEntrada2),
      semanaSaida1: parseUser.get(keyUserHoraSaida1),
      semanaSaida2: parseUser.get(keyUserHoraSaida2),
      sabadoEntrada1: parseUser.get(keyUserHoraSabadoEntrada1),
      sabadoEntrada2: parseUser.get(keyUserHoraSabadoEntrada2),
      sabadoSaida1: parseUser.get(keyUserHoraSabadoSaida1),
      sabadoSaida2: parseUser.get(keyUserHoraSabadoSaida2),
      domingoEntrada1: parseUser.get(keyUserHoraDomingoEntrada1),
      domingoEntrada2: parseUser.get(keyUserHoraDomingoEntrada2),
      domingoSaida1: parseUser.get(keyUserHoraDomingoSaida1),
      domingoSaida2: parseUser.get(keyUserHoraDomingoSaida2),
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }
}