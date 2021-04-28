import 'package:date_picker_timeline/date_picker_widget.dart';
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
  DatePickerController _controller = DatePickerController();

  DateTime _selectedValue = DateTime.now();

  final MyPontoStore store = MyPontoStore();
  final BaterPonto ponto = BaterPonto();

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
            height: 120,
            child: Padding(
              padding: EdgeInsets.zero,
              child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Container(
                          padding: EdgeInsets.only(right: 15),
                          child: DatePicker(
                            DateTime.now().subtract(Duration(days: 30)),
                            locale: "pt-br",
                            width: 50,
                            height: 100,
                            controller: _controller,
                            daysCount: 31,
                            initialSelectedDate: DateTime.now(),
                            selectionColor: Colors.black,
                            selectedTextColor: Colors.white,
                            onDateChange: (date) {
                              setState(() {
                                _selectedValue = date;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  )),
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
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('FALTAS'),
                      SizedBox(height: 10),
                      Text('10')
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
                ponto: section, store: store, date: _selectedValue);
          }).toList();

          return SliverList(
            delegate: SliverChildListDelegate(children),
          );
        },
      )
    ]));
  }
}
