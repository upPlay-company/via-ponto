import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/repository/bater_ponto_repository.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

part 'bater_ponto_store.g.dart';

class BaterPontoStore = _BaterPontoStore with _$BaterPontoStore;

abstract class _BaterPontoStore with Store {
  final MyPontoStore store = MyPontoStore();

  _BaterPontoStore({this.ponto}) {
    quantity = ponto.quantity;
  }

  final BaterPonto ponto;

  @observable
  int quantity;

  @action
  int setQuantity(int value) => quantity = value;

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
    ponto.quantity = quantity;

    loading = true;
    await BaterPontoRepository().save(ponto, store);
    savedAd = true;
    loading = false;
  }
}
