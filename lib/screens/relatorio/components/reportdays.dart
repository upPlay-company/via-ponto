import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:viaponto_oficial/store/user_manager_store.dart';

class GeneratePDF {
  BaterPonto ponto;
  GeneratePDF({
    @required this.ponto,
  });

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  /// Cria e Imprime a fatura
  generatePDFInvoice() async {
    final pw.Document doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        header: _buildHeader,
        build: (context) => _buildContent(context),
      ),
    );
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  /// Constroi o cabeçalho da página
  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
        color: PdfColors.green,
        height: 150,
        child: pw.Padding(
            padding: pw.EdgeInsets.all(16),
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Padding(
                            padding: pw.EdgeInsets.all(8), child: pw.PdfLogo()),
                      ]),
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Text('Compravante de Registro',
                            style: pw.TextStyle(
                                fontSize: 22, color: PdfColors.white))
                      ])
                ])));
  }

  /// Constroi o conteúdo da página
  List<pw.Widget> _buildContent(pw.Context context) {
    return [
      pw.Padding(
          padding: pw.EdgeInsets.only(top: 30, left: 25, right: 25),
          child: _buildContentClient()),
      pw.Padding(
          padding: pw.EdgeInsets.only(top: 50, left: 25, right: 25),
          child: _contentTable(context)),
    ];
  }

  pw.Widget _buildContentClient() {
    return pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _titleText('COMPROVANTE DO REGISTRO DO PONTO DO FUNCIONÁRIO'),
            ],
          ),
        ]);
  }

  /// Retorna um texto com formatação própria para título
  _titleText(String text) {
    return pw.Padding(
        padding: pw.EdgeInsets.only(top: 8),
        child: pw.Text(text,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)));
  }

  /// Constroi uma tabela com base nos produtos da fatura
  pw.Widget _contentTable(pw.Context context) {
    // Define uma lista usada no cabeçalho

    return pw.Column(
      children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text('RAZÃO SOCIAL: '),
            pw.Text(ponto.empresas.nomeEmpresa),
          ]
        ),
        pw.SizedBox(height: 15),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('CNPJ: '),
              pw.Text(ponto.empresas.cnpj),
            ]
        ),
        pw.SizedBox(height: 15),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text('LOCAL: '),
            ]
        ),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            children: [
              pw.Text(ponto.localization),
            ]
        ),
        pw.SizedBox(height: 5),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('TIPO: '),
              pw.Text(ponto.registro),
            ]
        ),
        pw.SizedBox(height: 15),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('NOME: '),
              pw.Text(userManagerStore.user.name),
            ]
        ),
        pw.SizedBox(height: 15),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('DATA: '),
              pw.Text('${ponto.created.day}/${ponto.created.month}/${ponto.created.year}'),
            ]
        ),
        pw.SizedBox(height: 15),
        pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('HORA: '),
              pw.Text('${ponto.time}'),
            ]
        ),
      ]
    );
  }

}