import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/screens/relatorio/components/relatorio_day.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

class RelatorioDayScreen extends StatefulWidget {
  @override
  _RelatorioDayScreenState createState() => _RelatorioDayScreenState();
}

class _RelatorioDayScreenState extends State<RelatorioDayScreen> {
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
                      Text('RELATÓRIO DIÁRIOS'),
                      SizedBox(height: 10),
                      Text('COMPROVANTE EM PDF')
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

          final List<Widget> children = store.allAds.map<Widget>((section) {
            return RelatorioDay(
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
