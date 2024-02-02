import 'dart:math';

import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class M_PatientMesures extends StatefulWidget {
  @override
  M_PatientMesuresState createState() => M_PatientMesuresState();
}

class M_PatientMesuresState extends State<M_PatientMesures> {
  late TooltipBehavior _tooltipBehavior;

  late GlobalKey<State> chartKey;
  bool contextVal = false;
  DateTime cData1_dt = DateTime.now();

  bool loadedData = false;

  int tag = 0;

  // list of string options
  List<String> options = [];

  List<List<ChartData>> cDataAll = [];
  List<String> cDataAllLib = [];
  List<String> cDataAllUnit = [];
  List<double> cDataAllMin = [];
  List<double> cDataAllMax = [];

  List<String> cDataAllSeuilMax = [];
  List<String> cDataAllSeuilMin = [];
  List<String> cDataAllObj = [];

  String chartData4Unit = "---";

  final List<ChartData> chartData4 = [];

  dynamic wSeries = <ChartSeries<ChartData, DateTime>>[];

  List<Appareils> listApp_Mess = [];

  @override
  void initLib() async {
    print("ApiSrv_patient_getdonnees>");

    await DbTools.ApiSrv_patient_getdonnees(
        DbTools.medecin_patients.cryptedId!);

    await alimData();

    setState(() {});

    LoadDonnees();
  }

  Future alimData() async {
    cDataAll.clear();
    cDataAllLib.clear();
    cDataAllUnit.clear();
    cDataAllMin.clear();
    cDataAllMax.clear();

    cDataAllSeuilMax.clear();
    cDataAllSeuilMin.clear();
    cDataAllObj.clear();

    options.clear();

    chartData4.clear();

    double cData1_Min = 0;
    double cData1_Max = 0;

    await DbTools.ApiSrv_patient_appareils(DbTools.medecin_patients.cryptedId!);

    if (DbTools.patient_appareilsList.length > 0) {
      List<Appareils>? appareils = DbTools.patient_appareilsList;

      appareils.forEach((item) {
        if (item.paramMobile != null) {
          if (item.paramMobile?.donnees != null) {
            item.paramMobile?.donnees!.forEach((donnee) async {
              print("donnee ${donnee.code}");

              List<ChartData> cDataTmp = [];

              cData1_Min = 999999;
              cData1_Max = -999999;

              DbTools.patient_donneesList.reversed.toList().forEach((item) {
                if (donnee.code == item.codeDonnee) {
                  double valeurContexte = 0;
                  if (item.valeurContexte! != "") {
                    valeurContexte = double.parse(item.valeurContexte!);
                  }

                  ChartData ChartDataTmp = ChartData(DateTime.parse(item.date!),
                      double.parse(item.valeurDonnee!), valeurContexte);
                  cData1_Min =
                      min(cData1_Min, double.parse(item.valeurDonnee!));
                  cData1_Max =
                      max(cData1_Max, double.parse(item.valeurDonnee!));
                  cDataTmp.add(ChartDataTmp);
                }
              });

              cData1_Min -= cData1_Min / 50;
              cData1_Max += cData1_Max / 50;

              cData1_Min = cData1_Min.roundToDouble();
              cData1_Max = cData1_Max.roundToDouble();

              print(
                  "donnee.code ${donnee.code} => ${cDataTmp.length} / ${chartData4.length}");

              await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(
                  DbTools.gApiID,
                  DbTools.gApiPassword,
                  DbTools.medecin_patients.cryptedId!,
                  "objectif",
                  donnee.libelle!);
              cDataAllObj.add(DbTools.api_Donnee_Patient.valeurDonnee!);

              await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(
                  DbTools.gApiID,
                  DbTools.gApiPassword,
                  DbTools.medecin_patients.cryptedId!,
                  "seuilmini",
                  donnee.libelle!);
              cDataAllSeuilMin.add(DbTools.api_Donnee_Patient.valeurDonnee!);

              donnee.medMini = DbTools.api_Donnee_Patient.valeurDonnee!;
              await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(
                  DbTools.gApiID,
                  DbTools.gApiPassword,
                  DbTools.medecin_patients.cryptedId!,
                  "seuilmaxi",
                  donnee.libelle!);
              cDataAllSeuilMax.add(DbTools.api_Donnee_Patient.valeurDonnee!);

              cDataAll.add(cDataTmp);
              cDataAllLib.add(donnee.libelle!);
              cDataAllUnit.add(donnee.unite!);

              cDataAllMin.add(cData1_Min);
              cDataAllMax.add(cData1_Max);

              options.add(donnee.libelle!);
            });
          }
        }
      });
    }
    loadedData = true;
  }

  void LoadDonnees() async {
    for (int i = 0; i < listApp_Mess.length; i++) {
      Appareils item = listApp_Mess[i];

      for (int j = 0; j < item.paramMobile!.donnees!.length; j++) {
        Donnees donnee = item.paramMobile!.donnees![j];

        await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(
            DbTools.gApiID,
            DbTools.gApiPassword,
            DbTools.medecin_patients.cryptedId!,
            "objectif",
            donnee.libelle!);

        donnee.medObj = DbTools.api_Donnee_Patient.valeurDonnee!;

        await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(
            DbTools.gApiID,
            DbTools.gApiPassword,
            DbTools.medecin_patients.cryptedId!,
            "seuilmini",
            donnee.libelle!);
        donnee.medMini = DbTools.api_Donnee_Patient.valeurDonnee!;
        await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(
            DbTools.gApiID,
            DbTools.gApiPassword,
            DbTools.medecin_patients.cryptedId!,
            "seuilmaxi",
            donnee.libelle!);

        donnee.medMaxi = DbTools.api_Donnee_Patient.valeurDonnee!;
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    chartKey = GlobalKey<State>();

    initLib();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Mesures Patient",
          ),
          backgroundColor: gColors.primary,
        ),
        backgroundColor: Colors.transparent,
        body: Container(
            padding: EdgeInsets.all(8),
            color: gColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                gColors.wLabel(null, "Nom",
                    "${DbTools.medecin_patients.prenom} ${DbTools.medecin_patients.nom}"),
                SizedBox(height: 4.0),
                Container(
                  height: 1,
                  color: gColors.primary,
                ),
                SizedBox(height: 8.0),
                Expanded(
                  child: !loadedData
                      ? Container()
                      : ListView.builder(
                          itemCount: cDataAll[tag].length,
                          itemBuilder: (context, index) {
                            final item = cDataAll[tag][index];

                            String formattedDate =
                                DateFormat('dd/MM/yyyy – HH:mm').format(item.x);

                            if (formattedDate.contains("00:00"))
                              formattedDate =
                                  DateFormat('dd/MM/yyyy').format(item.x);

                            return ListTile(
                              onTap: () {},
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              visualDensity:
                                  VisualDensity(horizontal: 0, vertical: -4),
                              title: Column(
                                children: [
                                  Row(
                                    children: [
//                                Icon(Icons.warning, color: item.id %3 == 0 ? gColors.tks : Colors.transparent,) ,
                                      Text("  ${formattedDate}",
                                          style: gColors.bodyText_N_G),
                                      Spacer(),
                                      Text("(${item.c})",
                                          style: gColors.bodyText_B_B),
                                      Spacer(),

                                      Text("${item.y}",
                                          style: gColors.bodyText_B_B),
                                    ],
                                  ),
                                  Container(
                                    height: 1,
                                    color: gColors.primary,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                SelData(),
                Container(
                  height: 40,
                ),
              ],
            )));
  }

  @override
  Widget SelData() {
    return Container();

/*      ChipsChoice<int>.single(
      value: tag,
      onChanged: (value) {
        setState(() {
          tag = value;

          setState(() {});
        });
      },
      choiceItems: C2Choice.listFrom<int, String>(
        source: options,
        value: (i, v) => i,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(
        color: gColors.primary,
        borderColor: gColors.primary,
      ),
      choiceActiveStyle: C2ChoiceStyle(
        color: gColors.secondary,
        borderColor: gColors.secondary,
      ),
      wrapped: true,
    );*/
  }
}

class ChartData {
  ChartData(this.x, this.y, this.c);
  DateTime x;
  double y;
  double c;
}

class TypeData {
  final int? id;
  final String? name;

  TypeData({
    this.id,
    this.name,
  });
}
