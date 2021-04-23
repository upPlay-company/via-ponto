import 'package:flutter/material.dart';
import 'package:viaponto_oficial/screens/home/components/active_ponto_day.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

class RelatorioDay extends StatefulWidget {
  @override
  _RelatorioDayState createState() => _RelatorioDayState();
}

class _RelatorioDayState extends State<RelatorioDay> {
  final MyPontoStore store = MyPontoStore();
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: 70,
              child: Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {}, child: Icon(Icons.arrow_back_ios)),
                    Text(
                      'dias',
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {}, child: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.grey[200],
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('HORAS TOTAIS'),
                        SizedBox(height: 10),
                        Text('08:00')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('HORAS EXTRAS'),
                        SizedBox(height: 10),
                        Text('01:00')
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
        SliverToBoxAdapter(
          child: ListView.builder(
            itemCount: store.allAds.length,
            itemBuilder: (_, index) {
              return ActivePontoDay(store.allAds[index], store);
            },
          ),
        )
      ],
    );
  }
}
