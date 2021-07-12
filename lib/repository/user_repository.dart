import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:viaponto_oficial/model/bater_ponto/departament.dart';
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
      cpf: parseUser.get(keyUserCpf),
      dataNasc: parseUser.get(keyUserNasc),
      departamento: Departament.fromParse(parseUser.get(keyUserDepatarmento)),
      idEmpresa: Empresas.fromParse(parseUser.get(keyUserIdEmpresa)),
      userName: parseUser.get(keyUserUserName),
      demitido: parseUser.get(keyUserDemitido),
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }
}