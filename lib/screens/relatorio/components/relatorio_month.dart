import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/screens/relatorio/components/report_month.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

class RelatorioMonth extends StatefulWidget {
  @override
  _RelatorioMonthState createState() => _RelatorioMonthState();
}

class _RelatorioMonthState extends State<RelatorioMonth> {
  DateTime _selectedValue = DateTime.now();

  final MyPontoStore store = MyPontoStore();
  final BaterPonto ponto = BaterPonto();
  final List<int> month = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
  ];
  int monthIndex = DateTime.now().month;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverToBoxAdapter(
          child: Column(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 80,
            padding: EdgeInsets.only(
              top: 20,
              left: MediaQuery.of(context).size.width * 0.12,
              right: MediaQuery.of(context).size.width * 0.12,
            ),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GridTile(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          monthIndex = index;
                        });
                      },
                      child: returnMonthcurrent(index, monthIndex),
                    ),
                  ),
                );
              },
              itemCount: month.length,
              scrollDirection: Axis.horizontal,
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
                      Text('08:00'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('HORAS EXTRAS'),
                      SizedBox(height: 10),
                      Text('01:00'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('FALTAS'),
                      SizedBox(height: 10),
                      Text('10'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      )),
      Observer(
        builder: (_) {
          if (store.allAds.isEmpty) Container();

          final List<Widget> children = store.allAds.map<Widget>((section) {
            return ReportMonth(
              ponto: section,
              store: store,
              date: _selectedValue,
              month: monthIndex,
            );
          }).toList();

          return SliverList(
            delegate: SliverChildListDelegate(children),
          );
        },
      )
    ]));
  }

  //Função para interar a lista de mês e return String tipo mês
  String returnMesString(int month) {
    switch (month) {
      case 1:
        return 'Janeiro';
        break;
      case 2:
        return 'Feveiro';
        break;
      case 3:
        return 'Março';
        break;
      case 4:
        return 'Abril';
        break;
      case 5:
        return 'Maio';
        break;
      case 6:
        return 'Junho';
        break;
      case 7:
        return 'Julho';
        break;
      case 8:
        return 'Agosto';
        break;
      case 9:
        return 'Setembro';
        break;
      case 10:
        return 'Outubro';
        break;
      case 11:
        return 'Novembro';
        break;
      case 12:
        return 'Dezembro';
        break;
      default:
        return '';
    }
  }

  //Função para retorna mês atual
  Widget returnMonthcurrent(int index, int monthIndex) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: month[index] == monthIndex
          ? Card(
              color: Colors.black,
              child: Container(
                height: 80,
                width: 80,
                child: Center(
                  child: Text(
                    returnMesString(
                      month[index],
                    ),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : Center(
              child: Text(
                returnMesString(
                  month[index],
                ),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
    );
  }
}
