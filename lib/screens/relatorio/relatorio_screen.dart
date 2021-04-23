import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viaponto_oficial/screens/relatorio/components/relatorio_month.dart';
import 'package:viaponto_oficial/screens/relatorio/components/relatorio_week.dart';

import 'components/relatorio_day_screen.dart';

class RelatorioScreen extends StatefulWidget {
  RelatorioScreen({this.inicialPage = 0});

  final int inicialPage;

  @override
  _RelatorioScreenState createState() => _RelatorioScreenState();
}

class _RelatorioScreenState extends State<RelatorioScreen>
    with SingleTickerProviderStateMixin {

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
          RelatorioDayScreen(),
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
