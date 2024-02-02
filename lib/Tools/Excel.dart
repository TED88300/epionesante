import 'dart:io';
import 'dart:math';

import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:sqflite/sqflite.dart';

class gData {
  String? date;
  String? saturation;
  String? tension_diastolique;
  String? tension_systolique;
  String? pouls;
  String? poids;

  int? msaturation = 0;
  int? mtension_diastolique = 0;
  int? mtension_systolique = 0;
  int? mpouls = 0;
  int? mpoids = 0;
  int? Msaturation = 0;
  int? Mtension_diastolique = 0;
  int? Mtension_systolique = 0;
  int? Mpouls = 0;
  int? Mpoids = 0;



  String? qualite_sommeil;
  String? temps_sommeil;

  String? valeurContexteSecondaire;
  String? donneeContexte;
  String? valeurDonnee;
}



int dateSortComparison(DonneesGet a, DonneesGet b) {
final ChartDataA = a.date;
final ChartDataB = b.date;

if (ChartDataA!.compareTo(ChartDataB!) < 0) {
return -1;
} else if (ChartDataA.compareTo(ChartDataB) > 0) {
return 1;
} else {
return 0;
}
}

class Excel {
  static Future<void> CrtExcelPat(Api_Patient wApi_Patient) async {
    List<gData> listData = [];

    await DbTools.ApiSrv_patient_getdonnees(wApi_Patient.cryptedId!);
    DateTime mDate = DateTime.now();
    DateTime MDate = DateTime.now();

    DbTools.patient_donneesList.sort(dateSortComparison);

    DbTools.patient_donneesList.forEach((item) {

      String valeurContexteSecondaire = "${item.valeurContexteSecondaire}";
      if (valeurContexteSecondaire.contains("TextEditingController"))
          valeurContexteSecondaire = "";
      if (valeurContexteSecondaire.contains("null"))
        valeurContexteSecondaire = "";

      String donneeContexte = "${item.donneeContexte}";
      String valeurDonnee = "${item.valeurDonnee}";




//      print("patient_donneesList ${item.date} ${item.codeDonnee}   ${item.valeurDonnee}  ${item.donneeContexte} ${valeurContexteSecondaire}");
      bool Trv = false;
      gData wData = gData();
      listData.forEach((element) {

        DateTime? dateTime = DateTime.now();
        dateTime  = DateTime.tryParse(element.date!);

        if (dateTime!.isBefore(mDate)) mDate = dateTime;
        if (dateTime.isAfter(MDate)) MDate = dateTime;

        if (element.date!.compareTo(item.date!) == 0) {
          Trv = true;
          if (item.codeDonnee!.compareTo("poids") == 0) {
            element.poids = item.valeurDonnee;
            element.mpoids = item.seuilMiniDonnee;
            element.Mpoids = item.seuilMaxiDonnee;
          }
          if (item.codeDonnee!.compareTo("pouls") == 0) {
            element.pouls = item.valeurDonnee;
            element.mpouls = item.seuilMiniDonnee;
            element.Mpouls = item.seuilMaxiDonnee;
          }
          if (item.codeDonnee!.compareTo("saturation") == 0) {
            element.saturation = item.valeurDonnee;
            element.msaturation = item.seuilMiniDonnee;
            element.Msaturation = item.seuilMaxiDonnee;
          }

          if (item.codeDonnee!.compareTo("tension_diastolique") == 0) {
            element.tension_diastolique = item.valeurDonnee;
            element.mtension_diastolique = item.seuilMiniDonnee;
            element.Mtension_diastolique = item.seuilMaxiDonnee;
          }
          if (item.codeDonnee!.compareTo("tension_systolique") == 0) {
            element.tension_systolique  = item.valeurDonnee;
            element.mtension_systolique = item.seuilMiniDonnee;
            element.Mtension_systolique = item.seuilMaxiDonnee;
          }

          if (item.codeDonnee!.compareTo("qualite_sommeil") == 0) {
            element.qualite_sommeil = item.valeurDonnee;
          }
          if (item.codeDonnee!.compareTo("temps_sommeil") == 0) {
            element.temps_sommeil = item.valeurDonnee;
          }


          return;
        }
      });

      if (!Trv) {
        wData.date = item.date!;




        wData.valeurContexteSecondaire = valeurContexteSecondaire;
        wData.donneeContexte = donneeContexte;
        wData.valeurDonnee = valeurDonnee;


        if (item.codeDonnee!.compareTo("poids") == 0) {
          wData.poids = item.valeurDonnee;
          wData.mpoids = item.seuilMiniDonnee;
          wData.Mpoids = item.seuilMaxiDonnee;
        }
        if (item.codeDonnee!.compareTo("pouls") == 0) {
          wData.pouls = item.valeurDonnee;
          wData.mpouls = item.seuilMiniDonnee;
          wData.Mpouls = item.seuilMaxiDonnee;
        }
        if (item.codeDonnee!.compareTo("saturation") == 0) {
          wData.saturation = item.valeurDonnee;
          wData.msaturation = item.seuilMiniDonnee;
          wData.Msaturation = item.seuilMaxiDonnee;
        }
        if (item.codeDonnee!.compareTo("tension_diastolique") == 0) {
          wData.tension_diastolique = item.valeurDonnee;
          wData.mtension_diastolique = item.seuilMiniDonnee;
          wData.Mtension_diastolique = item.seuilMaxiDonnee;
        }
        if (item.codeDonnee!.compareTo("tension_systolique") == 0) {
          wData.tension_systolique = item.valeurDonnee;
          wData.mtension_systolique = item.seuilMiniDonnee;
          wData.Mtension_systolique = item.seuilMaxiDonnee;
        }

        if (item.codeDonnee!.compareTo("qualite_sommeil") == 0) {
          wData.qualite_sommeil = item.valeurDonnee;
        }
        if (item.codeDonnee!.compareTo("temps_sommeil") == 0) {
          wData.temps_sommeil = item.valeurDonnee;
        }

        listData.add(wData);
      }


    });

    listData.forEach((elistData) {
      print("listData ${elistData.date} ${elistData.donneeContexte} ${elistData.valeurDonnee} ${elistData.valeurContexteSecondaire} ${elistData.poids} ${elistData.pouls} ${elistData.saturation} ${elistData.tension_diastolique} ${elistData.tension_systolique} ${elistData.qualite_sommeil} ${elistData.temps_sommeil}");
    });


    final Workbook workbook = Workbook();
    Worksheet sheet = workbook.worksheets[0];
    sheet.showGridlines = true;
    sheet.name = "${wApi_Patient.nom} ${wApi_Patient.prenom}";
    sheet.enableSheetCalculations();
    sheet.getRangeByName('A4').setText('Nom du patient');
    sheet.getRangeByName('A5').setText('Date de naissance');
    sheet.getRangeByName('A1').columnWidth = 20;
    sheet.getRangeByName('A4:A6').cellStyle.fontSize = 14;
    sheet.getRangeByName('A4:A6').cellStyle.backColor = '#6cc96b';
    sheet.getRangeByName('A4:A6').cellStyle.fontColor = '#FFFFFF';
    sheet.getRangeByName('B4').setText("${wApi_Patient.nom} ${wApi_Patient.prenom}");
    sheet.getRangeByName('B5').setText("${wApi_Patient.dateNaissance}");
    sheet.getRangeByName('A1').columnWidth = 20;
    sheet.getRangeByName('A4:A6').cellStyle.fontSize = 14;
    sheet.getRangeByName('A4:A6').cellStyle.backColor = '#6cc96b';
    sheet.getRangeByName('A4:A6').cellStyle.fontColor = '#FFFFFF';
    sheet.getRangeByName('B4:J6').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('B4:J4').merge();
    sheet.getRangeByName('B5:J5').merge();
    sheet.getRangeByName('B6:J6').merge();
    sheet.getRangeByName('A4:J6').cellStyle.borders.all.lineStyle = LineStyle.thin;

    print("aaaa");
    // PERIODE

    String smDate = "${DateFormat('dd/MM/yyy').format(mDate)}";
    String sMDate = "${DateFormat('dd/MM/yyy').format(MDate)}";

    sheet.getRangeByName('A8').setText('PERIODE DU ${smDate} AU ${sMDate}');
    sheet.getRangeByName('A8:U8').merge();
    sheet.getRangeByName('A8:U8').cellStyle.backColor = '#6cc96b';
    sheet.getRangeByName('A8:U8').cellStyle.fontColor = '#FFFFFF';
    sheet.getRangeByName('A8:U8').cellStyle.borders.all.lineStyle = LineStyle.thin;
    sheet.getRangeByName('A8:U8').cellStyle.hAlign = HAlignType.center;

    // Titre 1
    print("bbbb");

    sheet.getRangeByName('B13').setText('Saturation');
    sheet.getRangeByName('B13:D13').merge();

    sheet.getRangeByName('E13').setText('Tension Diastolique');
    sheet.getRangeByName('E13:G13').merge();

    sheet.getRangeByName('H13').setText('Tension Systolique');
    sheet.getRangeByName('H13:J13').merge();

    sheet.getRangeByName('K13').setText('Pouls');
    sheet.getRangeByName('K13:M13').merge();

    sheet.getRangeByName('N13').setText('Poids');
    sheet.getRangeByName('N13:P13').merge();

    sheet.getRangeByName('Q13').setText('Temps de sommeil');
    sheet.getRangeByName('R13').setText('Qualité du sommeil');

    sheet.getRangeByName('B13:R13').cellStyle.borders.all.lineStyle = LineStyle.thin;
    sheet.getRangeByName('B13:R13').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('B13:R13').cellStyle.rotation = 45;

    sheet.getRangeByName('A13').rowHeight = 90;


    print("ccc");


    // Titre 2
    sheet.getRangeByName('A14').setText('Date');

    sheet.getRangeByName('B14').setText('Min');
    sheet.getRangeByName('C14').setText('Mesure');
    sheet.getRangeByName('D14').setText('Max');

    sheet.getRangeByName('E14').setText('Min');
    sheet.getRangeByName('F14').setText('Mesure');
    sheet.getRangeByName('G14').setText('Max');

    sheet.getRangeByName('H14').setText('Min');
    sheet.getRangeByName('I14').setText('Mesure');
    sheet.getRangeByName('J14').setText('Max');

    sheet.getRangeByName('K14').setText('Min');
    sheet.getRangeByName('L14').setText('Mesure');
    sheet.getRangeByName('M14').setText('Max');

    sheet.getRangeByName('N14').setText('Min');
    sheet.getRangeByName('O14').setText('Mesure');
    sheet.getRangeByName('P14').setText('Max');

    sheet.getRangeByName('Q14').setText('Mesure');
    sheet.getRangeByName('R14').setText('Mesure');

    sheet.getRangeByName('S14').setText('Context');
    sheet.getRangeByName('T14').setText('Valeur');
    sheet.getRangeByName('U14').setText('Moment');


    sheet.getRangeByName('B14:U14').cellStyle.borders.all.lineStyle = LineStyle.thin;
    sheet.getRangeByName('B14:U14').cellStyle.hAlign = HAlignType.center;
    sheet.getRangeByName('B14:P14').cellStyle.rotation = 90;

    // Titre Data

    var today = DateTime.now();
    var First = today.add(const Duration(days: -100));

    listData.forEach((elistData) {
      print("listData ${elistData.date} ${elistData.donneeContexte} ${elistData.valeurDonnee} ${elistData.valeurContexteSecondaire} ${elistData.poids} ${elistData.pouls} ${elistData.saturation} ${elistData.tension_diastolique} ${elistData.tension_systolique} ${elistData.qualite_sommeil} ${elistData.temps_sommeil}");
    });


    for (int i = 0; i < listData.length; i++) {
      gData e = listData[i];
      final d = First.add(Duration(days: i));

      sheet.getRangeByName('A${15 + i}').dateTime = DateTime.tryParse(e.date!);
      sheet.getRangeByName('A${15 + i}').numberFormat = 'dd/mm/yyyy hh:mm';

      int min = e.msaturation!;
      int max = e.Msaturation!;

      sheet.getRangeByName('B${15 + i}').setText('${min}');
      sheet.getRangeByName('C${15 + i}').setText('${e.saturation == null ? "" : e.saturation}');
      sheet.getRangeByName('D${15 + i}').setText('${max}');
      sheet.getRangeByName('C${15 + i}').cellStyle.bold = true;

       min = e.mtension_diastolique!;
       max = e.Mtension_diastolique!;

      sheet.getRangeByName('E${15 + i}').setText('${min}');
      sheet.getRangeByName('F${15 + i}').setText('${e.tension_diastolique == null ? "" : e.tension_diastolique}');
      sheet.getRangeByName('G${15 + i}').setText('${max}');
      sheet.getRangeByName('F${15 + i}').cellStyle.bold = true;

      min = e.mtension_systolique!;
      max = e.Mtension_systolique!;

      sheet.getRangeByName('H${15 + i}').setText('${min}');
      sheet.getRangeByName('I${15 + i}').setText('${e.tension_systolique == null ? "" : e.tension_systolique}');
      sheet.getRangeByName('J${15 + i}').setText('${max}');
      sheet.getRangeByName('I${15 + i}').cellStyle.bold = true;


      min = e.mpouls!;
      max = e.Mpouls!;

      sheet.getRangeByName('K${15 + i}').setText('${min}');
      sheet.getRangeByName('L${15 + i}').setText('${e.pouls == null ? "" : e.pouls}');
      sheet.getRangeByName('M${15 + i}').setText('${max}');
      sheet.getRangeByName('L${15 + i}').cellStyle.bold = true;

      min = e.mpoids!;
      max = e.Mpoids!;

      sheet.getRangeByName('N${15 + i}').setText('${min}');
      sheet.getRangeByName('O${15 + i}').setText('${e.poids == null ? "" : e.poids}');
      sheet.getRangeByName('P${15 + i}').setText('${max}');
      sheet.getRangeByName('O${15 + i}').cellStyle.bold = true;

      sheet.getRangeByName('Q${15 + i}').setText('${e.temps_sommeil == null ? "" : e.temps_sommeil} mn');
      sheet.getRangeByName('R${15 + i}').setText('${e.qualite_sommeil == null ? "" : e.qualite_sommeil}');

      sheet.getRangeByName('S${15 + i}').setText('${e.donneeContexte}');
      sheet.getRangeByName('T${15 + i}').setText('${e.valeurDonnee}');
      sheet.getRangeByName('U${15 + i}').setText('${e.valeurContexteSecondaire}');

      sheet.getRangeByName('Q${15 + i}').cellStyle.bold = true;
      sheet.getRangeByName('R${15 + i}').cellStyle.bold = true;

      sheet.getRangeByName('A${15 + i}:N${15 + i}').cellStyle.hAlign = HAlignType.right;
    }

    sheet.getRangeByName('B1:J1').columnWidth = 8;
    sheet.getRangeByName('K1:O1').columnWidth = 8;
    sheet.getRangeByName('Q1:U1').columnWidth = 16;

    if(listData.length > 0)
      {
        sheet.getRangeByName('A15:U${listData.length+14}').cellStyle.borders.all.lineStyle = LineStyle.thin;
        sheet.getRangeByName('A15:U${listData.length+14}').cellStyle.hAlign = HAlignType.center;
        sheet.getRangeByName('A1:U${listData.length+14}').cellStyle.fontSize = 14;
      }

    workbook.worksheets.add();


    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    var path = await getDatabasesPath();

    final String fileName = '$path/epioneExtract_${wApi_Patient.nom}_${wApi_Patient.prenom}.xlsx';
    final File file = File(fileName);

    print("epioneExtract.xlsx $fileName");

    await file.writeAsBytes(bytes, flush: true);

    print("Fin ${bytes.length}");
  }
}
