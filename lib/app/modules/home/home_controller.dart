// import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:image/image.dart' as im;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:printing/printing.dart';

import 'widgets/share_js.dart';

class HomeController extends GetxController {
  var storage = GetStorage();

  // File img1;

  Uint8List savePdf;
  var savePdfS = "".obs;
  var dd = ''.obs;
  int quantidade = 1;
  int numero = 0;
  List<String> nomes = List();
  List numeros = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40
  ];

  adicionarNome(String nome) {
    nomes.add(nome);
    dd.value = dd.value + '1';
    update(['barCodeImageUltimo']);
  }

  Future<void> buildBarcode({
    String filename,
  }) async {
    String data = storage.read('ultimo');
    if (data == null) data = '000339006';
    var dataInt = int.parse(data) + 1;
    data = '$dataInt';
    for (int o = data.length; o < 9; o++) {
      data = '0' + data;
    }
    final pdf = pw.Document();
    // final Directory directory =
    //     await path_provider.getApplicationDocumentsDirectory();
    // final String path = directory.path;
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return center('Primeiro'); // Center
        },
      ),
    );
    numero = 0;
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return center('Segundo'); // Center
        },
      ),
    );
    numero = 0;
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return center('Terçeiro'); // Center
        },
      ),
    );

    // img1 = File('$path/$filename.pdf');
    // img1.writeAsBytesSync(pdf.save());
    // path = img1.path;
    // print('${img1.path}');

    savePdf = pdf.save();
    savePdfS.value = data;
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) {
        return savePdf;
      },
      name: 'RR000339006ST',
      format: PdfPageFormat.roll80,
    );
    // share(
    //     bytes: savePdf, filename: '$filename.pdf', mimetype: 'application/pdf');
    update();
  }

  create(int quantidade) {
    for (int i = 0; i < quantidade; i++) {}
  }

  center(String periodo) {
    return pw.Column(children: [
      pw.Text('$periodo Período, 7ª classe, Turma B',
          style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
      pw.Divider(height: 0),
      header(),
      pw.Divider(height: 0),
      pw.Column(
          children: nomes
              .map((e) => pw.Column(children: [
                    data(e),
                    pw.Divider(height: 0),
                  ]))
              .toList()),
    ]);
  }

  pw.Row data(String data) {
    var num = nomes.indexOf(data);
    num += 1;
    return pw.Row(children: [
      dividerVertical(),
      pw.Container(
        width: 26.5,
        child: pw.Center(
          child: pw.Text('${num.toString().length == 1 ? '0$num' : num}'),
        ),
      ),
      dividerVertical(),
      pw.Container(
          width: 179.8,
          child: pw.Center(
            child: pw.Text('$data hhhhhhhhhhhhhhhhhhhhhhhh'),
          )),
      dividerVertical(),
      pw.Container(
          width: 55.5,
          child: pw.Center(
            child: pw.Text(''),
          )),
      dividerVertical(),
      pw.Container(
          width: 55.5,
          child: pw.Center(
            child: pw.Text(''),
          )),
      dividerVertical(),
      pw.Container(
          width: 62.6,
          child: pw.Center(
            child: pw.Text(''),
          )),
      dividerVertical(),
      pw.Container(
          width: 63.3,
          child: pw.Center(
            child: pw.Text(''),
          )),
      dividerVertical(),
      pw.Container(
          width: 52.7,
          child: pw.Center(
            child: pw.Text(''),
          )),
      dividerVertical(),
    ]);
  }

  pw.Row header() {
    return pw.Row(children: [
      dividerVertical(),
      pw.SizedBox(width: 5),
      pw.Text('Nº', style: pw.TextStyle(fontSize: 15)),
      pw.SizedBox(width: 5),
      dividerVertical(),
      pw.SizedBox(width: 70),
      pw.Text('Nome', style: pw.TextStyle(fontSize: 15)),
      pw.SizedBox(width: 70),
      dividerVertical(),
      pw.SizedBox(width: 10),
      pw.Text('1ªAv.', style: pw.TextStyle(fontSize: 15)),
      pw.SizedBox(width: 10),
      dividerVertical(),
      pw.SizedBox(width: 10),
      pw.Text('2ªAv.', style: pw.TextStyle(fontSize: 15)),
      pw.SizedBox(width: 10),
      dividerVertical(),
      pw.SizedBox(width: 10),
      pw.Text('Partic.', style: pw.TextStyle(fontSize: 15)),
      pw.SizedBox(width: 10),
      dividerVertical(),
      pw.SizedBox(width: 10),
      pw.Text('Traba.', style: pw.TextStyle(fontSize: 15)),
      pw.SizedBox(width: 10),
      dividerVertical(),
      pw.SizedBox(width: 10),
      pw.Text('Final', style: pw.TextStyle(fontSize: 15)),
      pw.SizedBox(width: 10),
      dividerVertical(),
    ]);
  }

  pw.Container dividerVertical() {
    return pw.Container(
      width: 1,
      height: 17,
      decoration: pw.BoxDecoration(
        borderRadius: 1,
        border: pw.BoxBorder(color: PdfColor.fromInt(0xFF202124)),
      ),
    );
  }

  // File file(String data) {
  //   final imag = im.Image(800, 150);
  //   im.fill(imag, im.getColor(255, 255, 255));
  //   drawBarcode(imag, Barcode.code39(), 'RR${data}ST', font: im.arial_48);
  //   var fil = File('$data.png');
  //   fil.writeAsBytesSync(im.encodePng(imag));
  //   return fil;
  // }

  @override
  void onInit() {
    super.onInit();
  }
}
