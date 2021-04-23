import 'package:flutter/material.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

class RelatorioDay extends StatelessWidget {
  RelatorioDay(this.ponto, this.store);

  final BaterPonto ponto;
  final MyPontoStore store;

  @override
  Widget build(BuildContext context) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(ponto.time,
                            style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          '${ponto.registro}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Icon(Icons.description)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black.withAlpha(50)))),
            )
          ],
        ),
      );
  }
}
