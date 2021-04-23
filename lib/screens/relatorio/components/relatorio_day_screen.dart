import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:viaponto_oficial/screens/relatorio/components/relatorio_day.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

class RelatorioDayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final MyPontoStore store = MyPontoStore();

    return Scaffold(
      body: CustomScrollView(
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
                              onTap: () {},
                              child: Icon(Icons.arrow_forward_ios))
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
          Observer(
            builder: (_) {
              if (store.allAds.isEmpty) Container();

              final List<Widget> children =
              store.allAds.map<Widget>((section) {
                return RelatorioDay(section, store);
              }).toList();

              return SliverList(
                delegate: SliverChildListDelegate(children),
              );
            },
          )
        ],
      ),
    );
  }
}
