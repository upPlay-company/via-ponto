import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/repository/bater_ponto_repository.dart';

part 'bater_ponto_store.g.dart';

class BaterPontoStore = _BaterPontoStore with _$BaterPontoStore;

abstract class _BaterPontoStore with Store {

  BaterPonto ponto;

  @computed
  Function get sendPressed => _send;

  @observable
  bool loading = false;

  @observable
  String error;

  @observable
  bool savedAd = false;

  @action
  Future<void> _send() async {
    loading = true;
    await BaterPontoRepository().save(ponto);
    savedAd = true;
    loading = false;

  }

}