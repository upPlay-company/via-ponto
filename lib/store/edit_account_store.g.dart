// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditAccountStore on _EditAccountStore, Store {
  Computed<bool> _$emailValidComputed;

  @override
  bool get emailValid =>
      (_$emailValidComputed ??= Computed<bool>(() => super.emailValid,
              name: '_EditAccountStore.emailValid'))
          .value;
  Computed<bool> _$passValidComputed;

  @override
  bool get passValid =>
      (_$passValidComputed ??= Computed<bool>(() => super.passValid,
              name: '_EditAccountStore.passValid'))
          .value;
  Computed<bool> _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_EditAccountStore.isFormValid'))
          .value;
  Computed<VoidCallback> _$savePressedComputed;

  @override
  VoidCallback get savePressed =>
      (_$savePressedComputed ??= Computed<VoidCallback>(() => super.savePressed,
              name: '_EditAccountStore.savePressed'))
          .value;

  final _$emailAtom = Atom(name: '_EditAccountStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$pass1Atom = Atom(name: '_EditAccountStore.pass1');

  @override
  String get pass1 {
    _$pass1Atom.reportRead();
    return super.pass1;
  }

  @override
  set pass1(String value) {
    _$pass1Atom.reportWrite(value, super.pass1, () {
      super.pass1 = value;
    });
  }

  final _$pass2Atom = Atom(name: '_EditAccountStore.pass2');

  @override
  String get pass2 {
    _$pass2Atom.reportRead();
    return super.pass2;
  }

  @override
  set pass2(String value) {
    _$pass2Atom.reportWrite(value, super.pass2, () {
      super.pass2 = value;
    });
  }

  final _$loadingAtom = Atom(name: '_EditAccountStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$saveAdAtom = Atom(name: '_EditAccountStore.saveAd');

  @override
  bool get saveAd {
    _$saveAdAtom.reportRead();
    return super.saveAd;
  }

  @override
  set saveAd(bool value) {
    _$saveAdAtom.reportWrite(value, super.saveAd, () {
      super.saveAd = value;
    });
  }

  final _$errorAtom = Atom(name: '_EditAccountStore.error');

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  final _$_saveAsyncAction = AsyncAction('_EditAccountStore._save');

  @override
  Future<void> _save() {
    return _$_saveAsyncAction.run(() => super._save());
  }

  final _$_EditAccountStoreActionController =
      ActionController(name: '_EditAccountStore');

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass1(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPass1');
    try {
      return super.setPass1(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPass2(String value) {
    final _$actionInfo = _$_EditAccountStoreActionController.startAction(
        name: '_EditAccountStore.setPass2');
    try {
      return super.setPass2(value);
    } finally {
      _$_EditAccountStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
email: ${email},
pass1: ${pass1},
pass2: ${pass2},
loading: ${loading},
saveAd: ${saveAd},
error: ${error},
emailValid: ${emailValid},
passValid: ${passValid},
isFormValid: ${isFormValid},
savePressed: ${savePressed}
    ''';
  }
}
