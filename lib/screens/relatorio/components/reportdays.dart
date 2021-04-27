import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:flutter/foundation.dart';
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
  final pw.Document doc = pw.Document();

  final UserManagerStore userManagerStore = GetIt.I<UserManagerStore>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  //Declarações de funções
  generatePDFInvoice() async {
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(margin: pw.EdgeInsets.zero),
        header: _buildHeader,
        footer: _buildFooter,
        //build: (context) => _buildContent(context),
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
            pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text("COMPROVANTE DO REGISTRO DO PONTO \n DO FUNCIONÁRIO"),
                pw.Text("RAZÃO SOCIAL: ${ponto.empresas.razaoSocial}"),
                pw.Text("LOCAL: ${ponto.empresas.logradouro}"),
                pw.Text("TIPO: ${ponto.registro}"),
                pw.Text("NOME: ${ponto.user.name}"),
                pw.Text("DATA: ${ponto.created}"),
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

  pw.Widget _buildContent(pw.Context context) {}
  pw.Widget _buildQrCode(pw.Context context) {}
}
