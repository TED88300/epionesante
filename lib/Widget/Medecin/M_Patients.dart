import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:azlistview/azlistview.dart';
import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Widget/Medecin/M_Patient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class M_Patients extends StatefulWidget {
  @override
  M_PatientsState createState() => M_PatientsState();
}

class M_PatientsState extends State<M_Patients> {
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
    searchController.text ="";
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

      ListPatients.retainWhere((api_Patient) => "${api_Patient.prenom!.toLowerCase()} ${api_Patient.nom!.toLowerCase()}".contains(searchController.text.toLowerCase()));
    }

    ListPatients.forEach((item) {

    var Nais_Age = "";
      if (item.dateNaissance!.length > 0) {
        final date_naissance = DateTime.parse(item.dateNaissance!);
        DateDuration duration;
        duration = AgeCalculator.age(date_naissance);
        Nais_Age =
            "${DateFormat('dd/MM/yyy').format(date_naissance)}";
      }



      String tag = item.nom![0];
      patientModel model = patientModel(name: '${item.nom}', tagIndex: tag);
      PatientList.add(model);
      normalList.add(ListTile(
          onTap: () {
            DbTools.medecin_patients = item;
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => M_Patient()));
          },
          dense: true,
          contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 40.0, 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: Column(
            children: [
              Row(
                children: [
                  Text("${item.nom} ${item.prenom}",
                      style: gColors.bodyText_B_B),
                ],
              ),

              Row(
                children: [
                  Text("$Nais_Age", style: gColors.bodyText_N_G),
                ],
              ),
              Container(height: 10),
              Container(
                  color: Colors.grey, height: 1.0),
            ],
          ),
        ));

    });
    print(">>>>>>>>>>>>> ListPatients ${ListPatients.length}");

    return ListPatients;
  }

  Widget ListeWidget() {
    print(">>>>>>>>>>>>> ListeWidget  lfPatients >>> ${lfPatients.asStream().length}");
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

  Widget PatientListViewvp() {
    print(">>>>>>>>>>>>> alphaAdrListView ");

    return ListView.builder(
      itemCount: normalList.length,
      itemBuilder: (context, index) {
        final item = normalList[index];
        return item;
      },
    );
  }

  Widget PatientListView() {
    return AzListView(
       data: PatientList,
      itemCount: PatientList.length,
      itemBuilder: (BuildContext context, int index) {

        return Column(
          children: [
            normalList[index],
          ],
        );
      },
      physics: BouncingScrollPhysics(),
    );
  }





  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        appBar: AppBar(
          title: AutoSizeText(
            "Liste des patients",
            maxLines: 1,
          ),
          backgroundColor: gColors.primary,
        ),
        body: Container(
      color: gColors.white,
      child: Column(
        children: <Widget>[
      Padding(
      padding: const EdgeInsets.all(16.0),
      child:TextFormField(
            controller: searchController,
            style: TextStyle(color: Colors.black),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              prefixIcon: Icon(
                Icons.search,
                color: gColors.secondary,
              ),

/*              suffixIcon:

              Container(
                width: 130,
                child :
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Alert ",
                      style: gColors.bodyText_B_R,
                    ),
                    Switch(
                      value: valAlert,
                      onChanged: (value) {
                        setState(() {
                          valAlert = value;
                          lfPatients = filterList();
                        });

                      },
                    ),
                  ],
                ),

                color: Colors.transparent,
              ),*/


              labelText: "Recherche",
            ),
          ),),
          SizedBox(height: 8.0),
          Expanded(child:
          ListPatients == null ? Container() : ListeWidget(),
          ),
          SizedBox(height: 8.0),
        ],
      ),
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