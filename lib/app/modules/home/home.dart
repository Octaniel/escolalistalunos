import 'package:barcode/barcode.dart';
import 'package:correiobarcode/app/modules/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class HomePage extends GetView<HomeController> {
  String value = "";
  TextEditingController controler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2083D5),
        title: Text('Escola lista alunos'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: Get.width * .3,
                  height: Get.height * .85,
                  alignment: Alignment.center,
                  child: ListView(
                    children: [
                      Text(
                        'Lista Alunos',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Primeiro periodo, 7ª classe, Tuma B',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      GetBuilder<HomeController>(
                        builder: (_) {
                          return Column(
                            children: [
                              Text(
                                controller.dd.value,
                                style: TextStyle(color: Colors.transparent),
                              ),
                              Column(
                                children: controller.nomes.map((e) {
                                  var i = controller.nomes.indexOf(e) + 1;
                                  String num =
                                      i.toString().length == 1 ? '0$i' : '$i';
                                  return ListTile(
                                    leading: Text('$num'),
                                    trailing:
                                        Text('$e'),
                                  );
                                }).toList(),
                              ),
                              Container(
                                margin:
                                EdgeInsets.symmetric(horizontal: Get.width * .1),
                                child: RaisedButton(
                                  onPressed: () async {
                                    controller.buildBarcode(
                                      filename: 'RR000339006ST',
                                    );
                                  },
                                  child: Text('Adicionar aluno'),
                                ),
                              ),
                            ],
                          );
                          // return controller.dd.value!=0
                          //     ? controller.barCodeImageUltimo
                          //     : Text('');
                        },
                        id: 'barCodeImageUltimo',
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 1,
                    height: Get.height * .90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF2083D5))),
                  ),
                ),
                Container(
                  width: Get.width * .45,
                  height: Get.height * .75,
                  alignment: Alignment.center,
                  child: ListView(
                    children: [
                      Text(
                        'Adicionar aluno',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: controler,
                        onSubmitted: (v) {
                          verificacaoAdicionarNome(v);
                        },
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          labelText: 'Nome do aluno aser adicionado',
                          hintText: 'Nome do aluno',
                          // contentPadding: EdgeInsets.all(5)
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: Get.width * .1),
                        child: RaisedButton(
                          onPressed: () async {
                            var v = controler.text;
                            verificacaoAdicionarNome(v);
                            // controller.buildBarcode(
                            //   filename: 'RR000339006ST',
                            // );
                          },
                          child: Text('Adicionar aluno'),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void verificacaoAdicionarNome(String v) {
    if (v.isEmpty ||
        !v.contains(' ') ||
        (v.toLowerCase() == v))
      Get.rawSnackbar(
          icon: Icon(
            FontAwesomeIcons.times,
            color: Colors.white,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Color(0xFFFE3C3C),
          messageText: Text(
            'Nome não completo, deve ser inserido o nome completo do aluno',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          borderRadius: 10,
          margin: EdgeInsets.only(
              left: 20, right: 20, bottom: 20));
    else
      controller.adicionarNome(v);
  }
}
