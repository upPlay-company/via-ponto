import 'package:flutter/material.dart';

class RelatorioMonth extends StatefulWidget {
  @override
  _RelatorioMonthState createState() => _RelatorioMonthState();
}

class _RelatorioMonthState extends State<RelatorioMonth> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Column(
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
                          onTap: (){},
                          child: Icon(Icons.arrow_back_ios)),
                      Text('MÊS', style: TextStyle(color: Colors.white),),
                      GestureDetector(
                          onTap: (){},
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
              )
            ],
          )
        ]
    );
  }
}
