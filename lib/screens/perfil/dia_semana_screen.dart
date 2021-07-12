import 'package:flutter/material.dart';
import 'package:viaponto_oficial/model/bater_ponto/turno.dart';

class DiaSemanaScreen extends StatelessWidget {

  DiaSemanaScreen(this.turno);

  final Turno turno;

  @override
  Widget build(BuildContext context) {

    Color primary = Theme.of(context).primaryColor;
  if(turno.diaSemana == 'segunda')
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Segunda à sexta:', style: TextStyle(fontSize: 18, color: Colors.black),),
              Text('${turno.primeiraEntrada} as ${turno.primeiraSaida} / '
                  '${turno.segundaEntrada} as ${turno.segundaSaida}',
                style: TextStyle(fontSize: 18, color: primary),),
            ],
          )),
    );
  else if(turno.diaSemana == 'sabado')
    return Padding(
      padding: const EdgeInsets.only(top: 8, left: 16),
      child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sábado:', style: TextStyle(fontSize: 18, color: Colors.black),),
              Row(
                children: [
                    Text('${turno.primeiraEntrada} as ${turno.primeiraSaida}', style: TextStyle(fontSize: 18, color: primary),),
                    if(turno.segundaEntrada != 'nao definido')
                      Text(' / ${turno.segundaEntrada} as ${turno.segundaSaida}', style: TextStyle(fontSize: 18, color: primary),),
                ],
              ),
            ],
          )),
    );
  else if(turno.diaSemana == 'domingo')
    if(turno.primeiraEntrada != 'nao definido')
      return Padding(
        padding: const EdgeInsets.only(top: 8, left: 16),
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sábado:', style: TextStyle(fontSize: 18, color: Colors.black),),
                Row(
                  children: [
                    Text('${turno.primeiraEntrada} as ${turno.primeiraSaida}', style: TextStyle(fontSize: 18, color: primary),),
                    Text(' / ${turno.segundaEntrada} as ${turno.segundaSaida}', style: TextStyle(fontSize: 18, color: primary),),
                  ],
                ),
              ],
            )),
      );
    else
      return Padding(
        padding: const EdgeInsets.only(top: 8, left: 16),
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Domingo:', style: TextStyle(fontSize: 18, color: Colors.black),),
                Row(
                  children: [
                    Text('dia não facultativo', style: TextStyle(fontSize: 18, color: primary),),
                  ],
                ),
              ],
            )),
      );
    else return Container();
  }
}
