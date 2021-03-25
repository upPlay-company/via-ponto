import 'package:flutter/material.dart';
import 'package:viaponto_oficial/screens/ponto/bater_ponto_screen.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';

class BaterPontoTile extends StatefulWidget {

  @override
  _BaterPontoTileState createState() => _BaterPontoTileState();
}

class _BaterPontoTileState extends State<BaterPontoTile> {

  final MyPontoStore store = MyPontoStore();

  @override
  Widget build(BuildContext context) {
    if(store.loading)
      return Container(
        color: Theme.of(context).primaryColor,
        height: 50,
          child: Center(
              child: CircularProgressIndicator()
          )
      );
    else
      return BaterPontoScreen(ponto: store.allAds.first);
  }
}
