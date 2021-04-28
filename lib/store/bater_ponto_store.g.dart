// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bater_ponto_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaterPontoStore on _BaterPontoStore, Store {
  Computed<Function> _$sendPressedComputed;

  @override
  Function get sendPressed =>
      (_$sendPressedComputed ??= Computed<Function>(() => super.sendPressed,
              name: '_BaterPontoStore.sendPressed'))
          .value;

  final _$locationAtom = Atom(name: '_BaterPontoStore.location');

  @override
  String get location {
    _$locationAtom.reportRead();
    return super.location;
  }

  @override
  set location(String value) {
    _$locationAtom.reportWrite(value, super.location, () {
      super.location = value;
    });
  }

  final _$loadingAtom = Atom(name: '_BaterPontoStore.loading');

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

  final _$errorAtom = Atom(name: '_BaterPontoStore.error');

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

  final _$savedAdAtom = Atom(name: '_BaterPontoStore.savedAd');

  @override
  bool get savedAd {
    _$savedAdAtom.reportRead();
    return super.savedAd;
  }

  @override
  set savedAd(bool value) {
    _$savedAdAtom.reportWrite(value, super.savedAd, () {
      super.savedAd = value;
    });
  }

  final _$_sendAsyncAction = AsyncAction('_BaterPontoStore._send');

  @override
  Future<void> _send() {
    return _$_sendAsyncAction.run(() => super._send());
  }

  final _$_BaterPontoStoreActionController =
      ActionController(name: '_BaterPontoStore');

  @override
  String setLocation(String value) {
    final _$actionInfo = _$_BaterPontoStoreActionController.startAction(
        name: '_BaterPontoStore.setLocation');
    try {
      return super.setLocation(value);
    } finally {
      _$_BaterPontoStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
location: ${location},
loading: ${loading},
error: ${error},
savedAd: ${savedAd},
sendPressed: ${sendPressed}
    ''';
  }
}
