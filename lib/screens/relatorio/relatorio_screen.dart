import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    tabController = TabController(length: 2, vsync: this, initialIndex: widget.inicialPage);
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
      ),
      body: RelatorioDayScreen(),
    );
  }
}
