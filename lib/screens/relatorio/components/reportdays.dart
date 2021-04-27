import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:viaponto_oficial/store/user_manager_store.dart';

class ReportDays extends StatefulWidget {
  ReportDays({this.ponto});
  final BaterPonto ponto;

  @override
  _ReportDaysState createState() => _ReportDaysState();
}

class _ReportDaysState extends State<ReportDays> {
  _ReportDaysState({this.ponto}) {
    generatePDFInvoice();
  }

  final BaterPonto ponto;

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  //Declarações de funções
  generatePDFInvoice() async {
    final pw.Document doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(margin: pw.EdgeInsets.zero),
        header: _buildHeader,
        footer: _buildFooter,
        build: (context) => _buildContent(context),
      ),
    );
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
    );
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Container(
      color: PdfColors.blue,
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
                  padding: pw.EdgeInsets.all(8),
                  child: pw.PdfLogo(),
                ),
                pw.Text(
                  "Comprovante de Registro",
                  style: pw.TextStyle(fontSize: 22, color: PdfColors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _buildFooter(pw.Context context) {
    return pw.Container(
      color: PdfColors.blue,
      height: 130,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(left: 16),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                _buildQrCode(context),
                pw.Padding(
                  padding: pw.EdgeInsets.only(top: 12),
                  child: pw.Text("Email"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<pw.Widget> _buildContent(pw.Context context) {
    return [
      pw.Padding(
        padding: pw.EdgeInsets.only(
          top: 30,
          left: 25,
          right: 25,
        ),
        child: _buildContentReport(),
      ),
      pw.Padding(
        padding: pw.EdgeInsets.only(
          top: 30,
          left: 25,
          right: 25,
        ),
        child: pw.Container(),
      ),
    ];
  }

  pw.Widget _buildQrCode(pw.Context context) {}
  pw.Widget _buildContentReport() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Cliente'),
            pw.Text(
              "COMPROVANTE DO REGISTRO DO PONTO \n DO FUNCIONÁRIO",
              style: pw.TextStyle(
                fontSize: 18,
              ),
            ),
            pw.Text(
              "RAZÃO SOCIAL: ${ponto.empresas.razaoSocial}",
              style: pw.TextStyle(fontSize: 18, color: PdfColors.green),
            ),
            pw.Text("LOCAL: ${ponto.empresas.logradouro}"),
            pw.Text("TIPO: ${ponto.registro}"),
            pw.Text("NOME: ${ponto.user.name}"),
            pw.Text("DATA: ${ponto.created}"),
          ],
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      'a',
      'a',
      'a',
      'a',
      'a',
    ];
    return pw.Table.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      // ignore: deprecated_member_use
      headerDecoration: pw.BoxDecoration(
        // ignore: deprecated_member_use
        borderRadius: 2,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.centerLeft,
        2: pw.Alignment.centerRight,
        3: pw.Alignment.center,
        4: pw.Alignment.centerRight,
      },
      //Define um estilo para o cabeçalho da tabela
      headerStyle: pw.TextStyle(
        fontSize: 18,
        color: PdfColors.blue,
        fontWeight: pw.FontWeight.bold,
      ),
      //Define um estilo para a célula
      cellStyle: const pw.TextStyle(
        fontSize: 18,
      ),
      //Define a decoração
      rowDecoration: pw.BoxDecoration(
        border: pw.BoxBorder(
          bottom: true,
          color: PdfColors.blue,
          width: .5,
        ),
      ),
      headers: tableHeaders, data: [],
    );
  }
}
