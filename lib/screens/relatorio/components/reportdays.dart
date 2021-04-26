import 'package:flutter/material.dart';
import 'package:viaponto_oficial/model/bater_ponto/bater_ponto.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportDays extends StatefulWidget {
  ReportDays({this.ponto});
  final BaterPonto ponto;

  @override
  _ReportDaysState createState() => _ReportDaysState();
}

class _ReportDaysState extends State<ReportDays> {
  _ReportDaysState({this.ponto});

  final BaterPonto ponto;
  final pw.Document doc = pw.Document();

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
        build: (context) => _buildContent(context),
      ),
    );
  }

  pw.Widget _buildHeader(pw.Context context) {}
  pw.Widget _buildFooter(pw.Context context) {}
}
