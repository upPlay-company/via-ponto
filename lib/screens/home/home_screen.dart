import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:viaponto_oficial/store/bater_ponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final BaterPontoStore store = BaterPontoStore();

  DateTime date = DateTime.now();

  int date1 = DateTime.now().hour;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();

    when((_) => store.savedAd, () {
        Navigator.of(context).pop();
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 35),
              child: SizedBox(
                height: 44,
                width: 170,
                child: FloatingActionButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    ponto(context);
                  },
                  backgroundColor: Theme.of(context).primaryColor,
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
              backgroundColor: Theme.of(context).primaryColor,
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
          ],
        ));
  }

  void ponto(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Observer(builder: (_){
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          title: Center(
              child: Text('PONTO DE ENTRADA', style: TextStyle(fontSize: 16))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 15, right: 8),
                      child: TextFormField(
                        initialValue: DateFormat(" d 'de' MMMM 'de' y", "pt_BR").format(date),
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        enabled: false,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                            ),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w800)),
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, bottom: 8, left: 15, right: 8),
                      child: Container(
                        child: Row(
                          children: [
                            Icon(Icons.alarm),
                            DigitalClock(
                              areaDecoration: BoxDecoration(color: Colors.transparent),
                              areaAligment: AlignmentDirectional.center,
                              hourMinuteDigitDecoration:
                              BoxDecoration(color: Colors.transparent),
                              secondDigitDecoration:
                              BoxDecoration(color: Colors.transparent),
                              hourMinuteDigitTextStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                              secondDigitTextStyle:
                              TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 8, bottom: 8, left: 15, right: 8),
                    child: TextFormField(
                      // TODO: LOCALIZAÇÃO USUARIO
                      initialValue: userManagerStore.user.nomeEmpresa,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.location_pin,
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w800)),
                    )),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.red),
              ),
            ),
            Observer(builder: (_){
              return TextButton(
                onPressed: store.sendPressed,
                child: Text(
                  'Enviar',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              );
            })
          ],
        );
      }),
    );
  }
}
