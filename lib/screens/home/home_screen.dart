import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';
import 'components/active_ponto_day.dart';
import 'components/bater_ponto_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  final MyPontoStore store = MyPontoStore();

  DateTime date = DateTime.now();

  int date1 = DateTime.now().hour;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.transparent,
                padding: const EdgeInsets.only(left: 35),
                child: SizedBox(
                  height: 44,
                  width: 200,
                  child: FloatingActionButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => BaterPontoTile()));
                    },
                    backgroundColor: Theme
                        .of(context)
                        .primaryColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'BATER PONTO',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Icons.timer)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: 200,
                automaticallyImplyLeading: false,
                backgroundColor: Theme
                    .of(context)
                    .primaryColor,
                title: Center(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat("EEEE,", "pt_BR").format(date),
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            DateFormat(" d 'de' MMMM 'de' y", "pt_BR")
                                .format(date),
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      if (date1 > 0 && date1 < 12)
                        Text('Bom dia,', style: TextStyle(color: Colors.white)),
                      if (date1 > 12 && date1 < 18)
                        Text('Boa tarde,', style: TextStyle(color: Colors.white)),
                      if (date1 > 18 && date1 < 0)
                        Text('Boa noite,', style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Text(userManagerStore.user.name,
                          style: TextStyle(color: Colors.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Text('Empresa: ${userManagerStore.user.nomeEmpresa}',
                          style: TextStyle(color: Colors.white, fontSize: 12)),
                      SizedBox(
                        height: 20,
                      ),
                      DigitalClock(
                        areaDecoration: BoxDecoration(color: Colors.transparent),
                        areaAligment: AlignmentDirectional.center,
                        hourMinuteDigitDecoration:
                        BoxDecoration(color: Colors.transparent),
                        secondDigitDecoration:
                        BoxDecoration(color: Colors.transparent),
                        hourMinuteDigitTextStyle:
                        TextStyle(fontSize: 25, color: Colors.white),
                        secondDigitTextStyle:
                        TextStyle(fontSize: 25, color: Colors.white),
                        is24HourTimeFormat: true,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Observer(builder: (_) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: store.allAds.length,
                    itemBuilder: (_, index) {
                      return ActivePontoDay(store.allAds[index], store);
                    },
                  );
                }),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 70),
              )
            ],
          )),
    );
  }
}

