// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
// import 'package:viaponto_oficial/store/myponto_store.dart';
// import 'package:viaponto_oficial/store/user_manager_store.dart';
//
// class ReportMonth extends StatelessWidget {
//   ReportMonth({this.ponto, this.store, this.date, this.month});
//
//   final BaterPonto ponto;
//   final MyPontoStore store;
//   final month;
//   final DateTime date;
//   String semanaEntrada1,
//       semanaEntrada2,
//       semanaSaida1,
//       semanaSaida2,
//       sabadoEntrada1,
//       sabadoEntrada2,
//       sabadoSaida1,
//       sabadoSaida2,
//       domingoEntrada1,
//       domingoEntrada2,
//       domingoSaida1,
//       domingoSaida2;
//
//   final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();
//
//   @override
//   Widget build(BuildContext context) {
//     // segunda a sexta
//     semanaEntrada1 = userManagerStore.user.semanaEntrada1.replaceAll(new RegExp(':'), '');
//     semanaEntrada2 = userManagerStore.user.semanaEntrada2.replaceAll(new RegExp(':'), '');
//     semanaSaida1 = userManagerStore.user.semanaSaida1.replaceAll(new RegExp(':'), '');
//     semanaSaida2 = userManagerStore.user.semanaSaida2.replaceAll(new RegExp(':'), '');
//     int horaentrada1 = int.parse(semanaEntrada1);
//     int horaentrada2 = int.parse(semanaEntrada2);
//     int horasaida1 = int.parse(semanaSaida1);
//     int horasaida2 = int.parse(semanaSaida2);
//
//     double horatotalsemana = (((horasaida1 - horaentrada1) / 100) * 60) + (((horasaida2 - horaentrada2) / 100) * 60);
//
//     print('hora semana total: $horatotalsemana');
//
//     //Ponto do funcionario
//     int pontoSaida;
//     int pontoEntrada;
//     int pontoSaida1;
//     int pontoEntrada1;
//     double cargaProrrogada = 0;
//     double cargaNova = 0;
//
//     if(month == ponto.created.month) {
//       if (ponto.registro == "1ª Entrada" && ponto.time != null) {
//         pontoEntrada = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
//       }
//       if (ponto.registro == "2ª Entrada" && ponto.time != null) {
//         pontoEntrada1 = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
//       }
//       if (ponto.registro == "1ª Saída" && ponto.time != null) {
//         pontoSaida = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
//       }
//       if (ponto.registro == "2ª Saída" && ponto.time != null) {
//         pontoSaida1 = int.parse(ponto.time.replaceAll(new RegExp(':'), ''));
//       }
//     }
//
//     double cargaHoraria = cargaHorariaDiaria(
//         cargaHora: horatotalsemana,
//         pontoSaida: pontoSaida ?? 0,
//         pontoEntrada: pontoEntrada ?? 0,
//         pontoSaida1: pontoSaida1 ?? 0,
//         pontoEntrada1: pontoEntrada1 ?? 0);
//
//     print(cargaHoraria);
//
//
//     if (cargaHoraria != null) {
//       if (month == ponto.created.month){
//         if (cargaHoraria > horatotalsemana)
//           cargaProrrogada = cargaHoraria - horatotalsemana;
//           cargaNova = cargaHoraria - cargaProrrogada;
//
//         print('carga extra: $cargaProrrogada');
//         print('carga nova: $cargaNova');
//         return Container(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(
//                               left: 20,
//                             ),
//                             child: Text(
//                               '${ponto.created.day}/${ponto.created.month}',
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 30,
//                           ),
//                           RichText(
//                             text: TextSpan(
//                               text: 'Trabalhado: ${(cargaNova / 60).toStringAsPrecision(1)}',
//                               style: DefaultTextStyle.of(context).style,
//                               children: <TextSpan>[
//                                 TextSpan(
//                                     text: '\n',
//                                     style: TextStyle(fontWeight: FontWeight.bold)),
//                                 TextSpan(
//                                     text: ' Extra: ${(cargaProrrogada / 60).toStringAsPrecision(1)}'),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     border: Border(
//                         bottom: BorderSide(color: Colors.black.withAlpha(50)))),
//               ),
//             ],
//           ),
//         );
//       } else return Container();
//     } else return Container();
//   }
//
//
//
//   //Declarações de funções
//   //Calculo para carga horaria normais e prorrogada
//   @required
//   double cargaHorariaDiaria({
//     double cargaHora, //entrada a do horario de trabalho
//     int pontoSaida, //saida do funcionario no trabalho
//     int pontoEntrada, //entrada do funcionario no trabalho
//     int pontoSaida1, //segunda saida do funcionario no trabalho
//     int pontoEntrada1,
//   }) {
//     //Declarações de variaveis processamento matematico
//     // calculo de conversão da carga horaria em minutos de trabalho do funcionario
//     //double cargaHorariaManha = (((saida - entrada) / 100) * 60) + (((saida1 - entrada1) / 100) * 60);
//     //double cargaHorariaTarde = (((saida1 - entrada1) / 100) * 60);
//     //double cargaHoraria = cargaHorariaManha + cargaHorariaTarde;
//     //Variavel para retorna o calculo das horas extras
//     double cargaProrrogada;
//     //Calculo para retorna a carga horaria que o funcionario cumpri no dia
//     double cargaHorariaDiariaManha = ((((pontoSaida - pontoEntrada) / 100) * 60) + (((pontoSaida1 - pontoEntrada1) / 100) * 60));
//     //double cargaHorariaDIariaTarde = (((pontoSaida1 - pontoEntrada1) / 100) * 60);
//     //double cargaHorariaDiaria = cargaHorariaDiariaManha + cargaHorariaDIariaTarde;
//
//     //Processamento de valores e resultados
//     //If para retorna a cargaHorariaDiaria funcionario cumprida no dia
//     if (cargaHora == cargaHorariaDiariaManha) {
//       cargaProrrogada = 0.0;
//       return cargaHorariaDiariaManha;
//     }
//     //else if para retorna a horas extra do funcionario excedida no dia
//     else if (cargaHorariaDiariaManha > cargaHora) {
//       return cargaProrrogada = cargaHorariaDiariaManha - cargaHora;
//     }
//   }
// }
// /*
// 'Trabalhado: ${cargaHorariaDiaria(saida: horasaida1, entrada: horaentrada1, saida1: horasaida2, entrada1: horaentrada2, pontoSaida: 1200, pontoEntrada: 800, pontoSaida1: 1800, pontoEntrada1: 1400)}',
//
// */
