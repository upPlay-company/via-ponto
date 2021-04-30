import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/repository/bater_ponto_repository.dart';
import 'package:viaponto_oficial/store/myponto_store.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class ReportMonth extends StatelessWidget {
  ReportMonth({this.ponto, this.store, this.date, this.month});

  final BaterPonto ponto;
  final MyPontoStore store;
  BaterPontoRepository teste;
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

    // sabado
    sabadoEntrada1 =
        userManagerStore.user.sabadoEntrada1.replaceAll(new RegExp(':'), '');
    sabadoEntrada2 =
        userManagerStore.user.sabadoEntrada2.replaceAll(new RegExp(':'), '');
    sabadoSaida1 =
        userManagerStore.user.sabadoSaida1.replaceAll(new RegExp(':'), '');
    sabadoSaida2 =
        userManagerStore.user.sabadoSaida2.replaceAll(new RegExp(':'), '');
    int sabadoentrada1 = int.parse(sabadoEntrada1);
    int sabadoentrada2 = int.parse(sabadoEntrada2);
    int sabadosaida1 = int.parse(sabadoSaida1);
    int sabadosaida2 = int.parse(sabadoSaida2);

    // domingo
    domingoEntrada1 =
        userManagerStore.user.semanaEntrada1.replaceAll(new RegExp(':'), '');
    domingoEntrada2 =
        userManagerStore.user.semanaEntrada2.replaceAll(new RegExp(':'), '');
    domingoSaida1 =
        userManagerStore.user.semanaSaida1.replaceAll(new RegExp(':'), '');
    domingoSaida2 =
        userManagerStore.user.semanaSaida2.replaceAll(new RegExp(':'), '');
    int domingoentrada1 = int.parse(domingoEntrada1);
    int domingoentrada2 = int.parse(domingoEntrada2);
    int domingosaida1 = int.parse(domingoSaida1);
    int domingosaida2 = int.parse(domingoSaida2);

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
                            text: 'Trabalhado: ${ponto.time}',
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                  text: '\n',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              TextSpan(text: ' extra: 01:00'),
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
  double cargaHorariaDiaria({
    int saida, //saida do horario de trabalho,
    int entrada, //entrada do horario de trabalho
    int pontoEntrada, //entrada do funcionario no trabalho
    int pontoSaida, //saida do funcionario no trabalho
    int pontoEntrada1, // segunda entrada do funcionario no trabalho
    int pontoSaida1, //segunda saida do funcionario no trabalho
  }) {
    //Declarações de variaveis processamento matematico
    // calculo de conversão da carga horaria em minutos
    double cargaHoraria = ((saida - entrada) / 100) * 60;
    //Variavel para retorna o calculo das horas extras
    double cargaProrrogada;
    //Calculo para retorna a carga horaria que o funcionario cumpri no dia
    double cargaHorariaDiaria = ((pontoSaida - pontoEntrada) / 100) * 60 +
        ((pontoSaida1 - pontoEntrada1) / 100) * 60;

    //Processamento de valores e resultados
    //If para retorna a cargaHorariaDiaria funcionario cumprida no dia
    if (cargaHoraria == cargaHorariaDiaria) {
      cargaProrrogada = 0.0;
      return cargaHorariaDiaria;
    }
    //else if para retorna a horas extra do funcionario excedida no dia
    else if (cargaHoraria > cargaHorariaDiaria) {
      return cargaProrrogada = cargaHoraria - cargaHorariaDiaria;
    }
    return 0;
  }
}
