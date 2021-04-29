import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class ReportMonth extends StatelessWidget {
  ReportMonth({this.ponto, this.store, this.date, this.month});

  final BaterPonto ponto;
  final MyPontoStore store;
  final month;
  final DateTime date;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    print("month report_month: ${month[3]}");
    if (month[3] == ponto.created.month)
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
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            '${ponto.created.day}/${ponto.created.month}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Trabalhando: ${ponto.time}',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: ' extra: 01:00'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black.withAlpha(50)))),
            ),
          ],
        ),
      );
    else
      return Container();
  }
}
