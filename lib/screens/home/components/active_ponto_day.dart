import 'package:flutter/material.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

class ActivePontoDay extends StatelessWidget {
  ActivePontoDay(this.ponto, this.store);

  final BaterPonto ponto;
  final MyPontoStore store;

  @override
  Widget build(BuildContext context) {

    DateTime date = DateTime.now();

    if(date.day == ponto.created.day)
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(ponto.time, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(width: 30,),
                  Text('${ponto.registro}', style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black.withAlpha(50)))
              ),
            )
          ],
        ),
      );
    else
      return Container();
  }
}
