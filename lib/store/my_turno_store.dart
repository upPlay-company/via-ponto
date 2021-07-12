import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:viaponto_oficial/model/bater_ponto/turno.dart';
import 'package:viaponto_oficial/repository/my_turno_repository.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

part 'my_turno_store.g.dart';

class MyTurnoStore = _MyTurnoStore with _$MyTurnoStore;

abstract class _MyTurnoStore with Store{

  _MyTurnoStore() {
    _getMyTurno();
  }

  @observable
  List<Turno> allAds = [];

  Future<void> _getMyTurno() async {
    final user = GetIt.I<UserManagerStore>().user;

    loading = true;
    allAds = await MyTurnoRepository().getMyTurno(user);
    loading = false;

    print(allAds);
  }

  @observable
  bool loading = false;

  void refresh() => _getMyTurno();

}