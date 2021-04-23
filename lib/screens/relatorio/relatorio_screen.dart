import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:viaponto_oficial/screens/relatorio/components/relatorio_month.dart';
import 'package:viaponto_oficial/screens/relatorio/components/relatorio_week.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

import 'components/relatorio_day.dart';

class RelatorioScreen extends StatefulWidget {
  RelatorioScreen({this.inicialPage = 0});

  final int inicialPage;

  @override
  _RelatorioScreenState createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends State<RelatorioScreen>
    with SingleTickerProviderStateMixin {
  final MyPontoStore store = MyPontoStore();

  TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.inicialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Relatório',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        elevation: 0,
        bottom: TabBar(
          indicator: BubbleTabIndicator(
            indicatorHeight: 50,
            indicatorColor: Colors.black,
            tabBarIndicatorSize: TabBarIndicatorSize.tab,
            indicatorRadius: 50,
          ),
          labelColor: Colors.white,
          controller: tabController,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(child: Text('DIA', style: TextStyle(fontSize: 16))),
            Tab(child: Text('SEMANA', style: TextStyle(fontSize: 16))),
            Tab(child: Text('MÊS', style: TextStyle(fontSize: 16))),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          CustomScrollView(
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
                  if (store.allAds.isEmpty) return Container();

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
          Container(
            child: RelatorioWeek(),
          ),
          Container(
            child: RelatorioMonth(),
          ),
        ],
      ),
    );
  }
}
