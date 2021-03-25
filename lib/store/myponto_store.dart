
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/repository/bater_ponto_repository.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

part 'myponto_store.g.dart';

class MyPontoStore = _MyPontoStore with _$MyPontoStore;

abstract class _MyPontoStore with Store {

  _MyPontoStore() {
    _getMyPonto();
  }

  @observable
  List<BaterPonto> allAds = [];

  Future<void> _getMyPonto() async {
    final user = GetIt.I<UserManagerStore>().user;

    try {
      loading = true;
      allAds = await BaterPontoRepository().getMyPonto(user);
      loading = false;
    } catch (e) {}
  }

  @observable
  bool loading = false;

  void refresh() => _getMyPonto();

}