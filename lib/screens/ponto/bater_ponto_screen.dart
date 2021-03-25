import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/screens/base/base_screen.dart';
import 'package:viaponto_oficial/store/bater_ponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class BaterPontoScreen extends StatefulWidget {

  BaterPontoScreen({this.ponto});

  final BaterPonto ponto;

  @override
  _BaterPontoScreenState createState() => _BaterPontoScreenState(ponto);
}

class _BaterPontoScreenState extends State<BaterPontoScreen> {

  _BaterPontoScreenState(BaterPonto ponto)
      : editing = ponto != null,
        store = BaterPontoStore(ponto: ponto ?? BaterPonto());

  final BaterPontoStore store;

  bool editing;

  DateTime date = DateTime.now();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  void initState() {
    super.initState();
    when((_) => store.savedAd, () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => BaseScreen()));
    });
  }

  void _incrementCounter(){
    if(store.ponto.quantity == null){
      int counter = 0;
      counter++;
      store.setQuantity(counter);
    } else {
      int counter = store.ponto.quantity;
      counter++;
      store.setQuantity(counter);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Observer(builder: (_){
                  if(store.loading)
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'REGISTRANDO PONTO',
                            style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                                Theme.of(context).primaryColor),
                          )
                        ],
                      ),
                    );
                  else
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Text('PONTO DE ENTRADA E SAÍDA', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: Navigator.of(context).pop,
                                child: Text(
                                  'Cancelar',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                                Observer(
                                  builder: (_){
                                    return TextButton(
                                      onPressed: (){
                                        _incrementCounter();
                                        store.sendPressed();
                                      },
                                      child: Text(
                                        'Enviar',
                                        style: TextStyle(color: Theme.of(context).primaryColor),
                                      ),
                                    );
                                  },
                                )
                            ],
                          ),
                        )
                      ],
                    );
                }),
              )
          ),
        ),
      ),
    );
  }
}
