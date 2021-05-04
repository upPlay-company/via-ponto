import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class ReportMonth extends StatelessWidget {
  ReportMonth({this.ponto, this.store, this.date, this.month});

  final BaterPonto ponto;
  final MyPontoStore store;
  final month;
  final DateTime date;
  String semanaEntrada1,
      semanaEntrada2,
      semanaSaida1,
      semanaSaida2,
      sabadoEntrada1,
      sabadoEntrada2,
      sabadoSaida1,
      sabadoSaida2,
      domingoEntrada1,
      domingoEntrada2,
      domingoSaida1,
      domingoSaida2;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    // segunda a sexta
    semanaEntrada1 =
        userManagerStore.user.semanaEntrada1.replaceAll(new RegExp(':'), '');
    semanaEntrada2 =
        userManagerStore.user.semanaEntrada2.replaceAll(new RegExp(':'), '');
    semanaSaida1 =
        userManagerStore.user.semanaSaida1.replaceAll(new RegExp(':'), '');
    semanaSaida2 =
        userManagerStore.user.semanaSaida2.replaceAll(new RegExp(':'), '');
    int horaentrada1 = int.parse(semanaEntrada1);
    int horaentrada2 = int.parse(semanaEntrada2);
    int horasaida1 = int.parse(semanaSaida1);
    int horasaida2 = int.parse(semanaSaida2);

    //Ponto do funcionario
    int pontoSaida;
    int pontoEntrada;
    int pontoSaida1;
    int pontoEntrada1;

    if (month == ponto.created.month &&
        ponto.registro == "1ª Entrada" &&
        ponto.created.day == ponto.created.day) {
      pontoEntrada = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
    } else if (month == ponto.created.month &&
        ponto.registro == "2ª Entrada" &&
        ponto.created.day == ponto.created.day) {
      pontoEntrada1 = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
    } else if (month == ponto.created.month &&
        ponto.registro == "1ª Saída" &&
        ponto.created.day == ponto.created.day) {
      pontoSaida = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
    } else if (month == ponto.created.month &&
        ponto.registro == "2ª Saída" &&
        ponto.created.day == ponto.created.day) {
      pontoSaida1 = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
    }

    double teste = cargaHorariaDiaria(
        saida: horasaida1,
        entrada: horaentrada1,
        saida1: horasaida2,
        entrada1: horaentrada2,
        pontoSaida: pontoSaida,
        pontoEntrada: pontoEntrada,
        pontoSaida1: pontoSaida1,
        pontoEntrada1: pontoEntrada1);

    if (month == ponto.created.month)
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            '${ponto.created.day}/${ponto.created.month}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Trabalhado: ${teste / 60}',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      ' extra: ${teste == teste ? 0 : teste}'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black.withAlpha(50)))),
            ),
          ],
        ),
      );
    else
      return Container();
  }

  //Declarações de funções
  //Calculo para carga horaria normais e prorrogada
  @required
  double cargaHorariaDiaria({
    int saida, //saida do horario de trabalho,
    int entrada, //entrada do horario de trabalho
    int saida1, //saida do horario de trabalho,
    int entrada1, //entrada do horario de trabalho
    int pontoSaida, //saida do funcionario no trabalho
    int pontoEntrada, //entrada do funcionario no trabalho
    int pontoSaida1, //segunda saida do funcionario no trabalho
    int pontoEntrada1,
  } // segunda entrada do funcionario no trabalho
      ) {
    //Declarações de variaveis processamento matematico
    // calculo de conversão da carga horaria em minutos
    double cargaHorariaManha = (((saida - entrada) / 100) * 60);
    double cargaHorariaTarde = (((saida1 - entrada1) / 100) * 60);
    double cargaHoraria = cargaHorariaManha + cargaHorariaTarde;

    //Variavel para retorna o calculo das horas extras
    double cargaProrrogada;
    //Calculo para retorna a carga horaria que o funcionario cumpri no dia
    double cargaHorariaDiariaManha = (((pontoSaida - pontoEntrada) / 100) * 60);
    double cargaHorariaDIariaTarde =
        (((pontoSaida1 - pontoEntrada1) / 100) * 60);
    double cargaHorariaDiaria =
        cargaHorariaDiariaManha + cargaHorariaDIariaTarde;

    //Processamento de valores e resultados
    //If para retorna a cargaHorariaDiaria funcionario cumprida no dia
    if (cargaHoraria == cargaHorariaDiaria) {
      cargaProrrogada = 0.0;
      return cargaHorariaDiaria;
    }
    //else if para retorna a horas extra do funcionario excedida no dia
    else if (cargaHorariaDiaria > cargaHoraria) {
      return cargaProrrogada = cargaHorariaDiaria - cargaHoraria;
    }
    return cargaProrrogada;
  }
}
/*
'Trabalhado: ${cargaHorariaDiaria(saida: horasaida1, entrada: horaentrada1, saida1: horasaida2, entrada1: horaentrada2, pontoSaida: 1200, pontoEntrada: 800, pontoSaida1: 1800, pontoEntrada1: 1400)}',

*/
