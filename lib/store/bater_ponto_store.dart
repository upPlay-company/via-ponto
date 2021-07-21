import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/repository/bater_ponto_repository.dart';
import 'package:viaponto_oficial/store/my_turno_store.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

part 'bater_ponto_store.g.dart';

class BaterPontoStore = _BaterPontoStore with _$BaterPontoStore;

abstract class _BaterPontoStore with Store {
  final MyPontoStore store = MyPontoStore();

  final MyTurnoStore myTurnoStore = MyTurnoStore();

  _BaterPontoStore({this.ponto}) {
    location = ponto.localization;
  }

  final BaterPonto ponto;

  @observable
  String location;

  @action
  String setLocation(String value) => location = value;

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
    ponto.localization = location;
      loading = true;
      try {
        await BaterPontoRepository().save(ponto, myTurnoStore);
        savedAd = true;
      } catch (e){
        error = e;
      }
      loading = false;

  }
}
