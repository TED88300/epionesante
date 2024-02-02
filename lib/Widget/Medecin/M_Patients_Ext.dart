import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:azlistview/azlistview.dart';
import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/Excel.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Widget/Medecin/M_Patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class M_Patients_Ext extends StatefulWidget {
  @override
  M_Patients_ExtState createState() => M_Patients_ExtState();
}

class M_Patients_ExtState extends State<M_Patients_Ext> {
  TextEditingController searchController = TextEditingController();
  bool valAlert = false;

  List<Api_Patient> ListPatients = [];

  List<patientModel> PatientList = [];

  late Future<List<Api_Patient>> lfPatients;

  List<String> strList = [];
  List<Widget> normalList = [];

  Future Reload() async {
    await DbTools.ApiSrv_medecin_patients(DbTools.gApiID, DbTools.gApiPassword);
    print(
        "DbTools.medecin_patientsList.length ${DbTools.medecin_patientsList.length}");

    setState(() {
      lfPatients = filterList();
    });
  }

  void initLib() async {
    lfPatients = filterList();

    print(">>>>>>>>>>>>> initLib Mag");
    await Reload();

    searchController.text = "";
    searchController.addListener(() {
      setState(() {
        lfPatients = filterList();
      });
    });
  }

  @override
  void initState() {
    searchController.text = "";
    initLib();

    super.initState();
  }

  Future<List<Api_Patient>> filterList() async {
    strList.clear();
    PatientList.clear();
    normalList.clear();

    ListPatients.clear();
    ListPatients.addAll(DbTools.medecin_patientsList);

    if (searchController.text.isNotEmpty) {
      ListPatients.retainWhere((api_Patient) =>
          "${api_Patient.prenom!.toLowerCase()} ${api_Patient.nom!.toLowerCase()}"
              .contains(searchController.text.toLowerCase()));
    }

//    ListPatients.forEach((item) {

    for (int i = 0; i < ListPatients.length; i++) {
      var item = ListPatients[i];

      var Nais_Age = "";
      if (item.dateNaissance!.length > 0) {
        final date_naissance = DateTime.parse(item.dateNaissance!);
        DateDuration duration;
        duration = AgeCalculator.age(date_naissance);
        Nais_Age = "${DateFormat('dd/MM/yyy').format(date_naissance)}";
      }

      {
        String tag = item.nom![0];
        patientModel model = patientModel(name: '${item.nom}', tagIndex: tag);
        PatientList.add(model);

      print ("item.sel ${item.sel}");


      normalList.add(CheckboxListTile(
          checkColor: gColors.white,
          activeColor: gColors.secondary,
          controlAffinity: ListTileControlAffinity.leading,
          selectedTileColor: gColors.secondary,
          value: item.sel,

/*
          onTap: () {
            DbTools.medecin_patients = item;
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => M_Patient()));
          },
*/
          onChanged: (bool? value) {
            item.sel = value!;

            print ("value $value");
            setState(() {});
          },
          dense: true,
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 40.0, 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Column(
            children: [
              Row(
                children: [
                  Text("${item.nom} ${item.prenom} ${item.sel}",
                      style: gColors.bodyText_B_B),
                ],
              ),
              Row(
                children: [
                  Text(Nais_Age, style: gColors.bodyText_N_G),
                ],
              ),
              Container(height: 10),
              Container(color: Colors.grey, height: 1.0),
            ],
          ),
        ));
      }
    }
    ;
    print(">>>>>>>>>>>>> ListPatients ${ListPatients.length}");

    return ListPatients;
  }

  Widget ListeWidget() {
    print(
        ">>>>>>>>>>>>> ListeWidget  lfPatients >>> ${lfPatients.asStream().length}");
    print(">>>>>>>>>>>>> ListeWidget strList >>> ${strList.length}");

    print(">>>>>>>>>>>>> ListeWidget normalList >>> ${normalList.length}");





    return FutureBuilder<List<Api_Patient>>(
      future: lfPatients,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Api_Patient>? data = snapshot.data;
          return PatientListView();
        } else if (snapshot.hasError) {
          return Text("Liste vide");
        } else {
          print("data " + snapshot.connectionState.toString());
        }
        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SpinKitThreeBounce(
                color: gColors.primary,
                size: 100.0,
              ),
              Container(
                height: 10,
              ),
              Text(
                "Lecture",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ]);
      },
    );
  }

  Widget PatientListView() {
    return AzListView(
      data: PatientList,
      itemCount: PatientList.length,
      itemBuilder: (BuildContext context, int index) {
        var item = ListPatients[index];

        var Nais_Age = "";
        if (item.dateNaissance!.length > 0) {
          final date_naissance = DateTime.parse(item.dateNaissance!);

          Nais_Age = "${DateFormat('dd/MM/yyy').format(date_naissance)}";
        }


        return Column(
          children: [


            CheckboxListTile(
              checkColor: gColors.white,
              activeColor: gColors.secondary,
              controlAffinity: ListTileControlAffinity.leading,
              selectedTileColor: gColors.secondary,
              value: item.sel,

/*
          onTap: () {
            DbTools.medecin_patients = item;
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => M_Patient()));
          },
*/
              onChanged: (bool? value) {
            item.sel = value!;

            print ("value $value");
            setState(() {});
            },
              dense: true,
              contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 40.0, 0.0),
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              title: Column(
                children: [
                  Row(
                    children: [
                      Text("${item.nom} ${item.prenom} ",
                          style: gColors.bodyText_B_B),
                    ],
                  ),
                  Row(
                    children: [
                      Text(Nais_Age, style: gColors.bodyText_N_G),
                    ],
                  ),
                  Container(height: 10),
                  Container(color: Colors.grey, height: 1.0),
                ],
              ),
            )

//            normalList[index],
          ],
        );
      },
      physics: BouncingScrollPhysics(),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(">>>>>>>>>>>>> build >>>");
    print(">>>>>>>>>>>>> build ${ListPatients.length}");

    return Scaffold(
        body: Container(
      color: gColors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: searchController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                prefixIcon: Icon(
                  Icons.search,
                  color: gColors.secondary,
                ),
                labelText: "Recherche",
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: ListPatients == null ? Container() : ListeWidget(),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    ),

        bottomNavigationBar: BottomAppBar(child: wBtnValidation()));
  }


  Widget wBtnValidation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(

            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),

            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {

                  ListPatients.forEach((element) async{

                    if (element.sel == true)
                      {
                      print(">>>>>>>>>>> ${element.nom}");
                      await Excel.CrtExcelPat(element);
                      print("<<<<<<<<<<< ${element.nom}");
                      }


                  });


                });
                await AffMessageInfo("Extraction de données", "Génération terminée : Tableau Excel disponible dans l'application Fichier");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gColors.secondary,
                padding: const EdgeInsets.all(12),
              ),
              child: Text('VALIDER',
                  style: gColors.bodyTitle1_B_Wr),
            )),
      ],
    );
  }

  Future<void> AffMessageInfo(String title, String body) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          backgroundColor: Colors.grey,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Text(
            "${title}",
            style: gColors.bodyTitle1_B_W,
            textAlign: TextAlign.center,
          ),
          content: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0), // TED
            child: Text(
              "${body}",
              style: gColors.bodyTitle1_B_Wr,
              textAlign: TextAlign.center,
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    alignment: Alignment.center,
                    backgroundColor: Colors.grey,
                    //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  ),
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
          ],
        ));
  }


}

class patientModel extends ISuspensionBean {
  String? name;
  String? tagIndex;
  String? namePinyin;

  patientModel({
    this.name,
    this.tagIndex,
    this.namePinyin,
  });

  patientModel.fromJson(Map<String, dynamic> json) : name = json['name'];

  Map<String, dynamic> toJson() => {
        'name': name,
      };

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String toString() => json.encode(this);
}
