import 'dart:ui';
import 'package:viaponto_oficial/helpers/extensions.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/model/users/user.dart';
import 'package:viaponto_oficial/repository/user_repository.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

part 'edit_account_store.g.dart';

class EditAccountStore = _EditAccountStore with _$EditAccountStore;

abstract class _EditAccountStore with Store {
  _EditAccountStore() {
    user = userManagerStore.user;

    email = user.email;
  }

  User user;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @observable
  String email;

  @action
  void setEmail(String value) => email = value;

  @computed
  bool get emailValid => email != null && email.isEmailValid();
  String get emailError =>
      email == null || emailValid ? null : 'E-mail inválido';

  @observable
  String pass1 = '';

  @action
  void setPass1(String value) => pass1 = value;

  @observable
  String pass2 = '';

  @action
  void setPass2(String value) => pass2 = value;

  @computed
  bool get passValid => pass1 == pass2 && (pass1.length >= 6 || pass1.isEmpty);
  String get passError {
    if (pass1.isNotEmpty && pass1.length < 6)
      return 'Senha muito curta';
    else if (pass1 != pass2) return 'Senhas não coincidem';
    return null;
  }

  @computed
  bool get isFormValid => passValid;

  @observable
  bool loading = false;

  @observable
  bool saveAd = false;

  @observable
  String error;

  @computed
  VoidCallback get savePressed => (isFormValid && !loading) ? _save : null;

  @action
  Future<void> _save() async {
    loading = true;

    user.email = email;

    if (pass1.isNotEmpty)
      user.password = pass1;
    else
      user.password = null;

      await UserRepository().update(user);
      userManagerStore.setUser(user);
      saveAd = true;

    loading = false;
  }

  void logout() => userManagerStore.logout();
}
