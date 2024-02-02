import 'dart:convert';

import 'package:azlistview/azlistview.dart';
import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class M_Patients_Notif extends StatefulWidget {
  @override
  M_Patients_NotifState createState() => M_Patients_NotifState();
}

class M_Patients_NotifState extends State<M_Patients_Notif> {
  TextEditingController searchController = TextEditingController();
  bool valAlert = false;

  List<Patients> ListPatients = [];
  List<patientModel> PatientList = [];
  late Future<List<Patients>> lfPatients;

  //*********************
  //********** OK *******
  //*********************

  List<Widget> normalList = [];

  Future Reload() async {
    await DbTools.ApiSrv_Patient_Alerte(DbTools.gApiID, DbTools.gApiPassword);
    for (int i = 0; i < DbTools.api_Patient_Alerte.patients!.length; i++) {
      Patients wPatients = DbTools.api_Patient_Alerte.patients![i];
      print("wPatients ${wPatients.nom}");
    }

    await DbTools.ApiSrv_Patient_Alerte_Reset(DbTools.gApiID, DbTools.gApiPassword);

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

  Future<List<Patients>> filterList() async {
    PatientList.clear();
    normalList.clear();

    ListPatients.clear();
    ListPatients.addAll(DbTools.api_Patient_Alerte.patients!);

    if (searchController.text.isNotEmpty) {
      ListPatients.retainWhere((api_Patient) => "${api_Patient.prenom!.toLowerCase()} ${api_Patient.nom!.toLowerCase()}".contains(searchController.text.toLowerCase()));
    }

    ListPatients.forEach((item) {
      String tag = item.nom![0];
      patientModel model = patientModel(name: '${item.nom}', tagIndex: tag);
      PatientList.add(model);

      List<Widget> colData = [];

      for (int i = 0; i < item.donneesEnAlerte!.length; i++) {
        DonneesEnAlerte wDonneesEnAlerte = item.donneesEnAlerte![i];
        if (wDonneesEnAlerte.codeDonnee!.contains('pouls')) continue;

        String wData = "";
        if (wDonneesEnAlerte.codeDonnee!.contains('saturation')) wData = "Sat.";
        if (wDonneesEnAlerte.codeDonnee!.contains('tension_systolique')) wData = "Syst.";
        if (wDonneesEnAlerte.codeDonnee!.contains('tension_diastolique')) wData = "Dia.";

        var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
        var inputDate = inputFormat.parse(wDonneesEnAlerte.date!);
        var outputFormat = DateFormat('dd/MM/yyyy HH:mm');
        var outputDate = outputFormat.format(inputDate);

        print("wDonneesEnAlerte ${wDonneesEnAlerte.toJson()}");
        colData.add(Row(
          children: [
            Container(width: 180, child: Text("  - ${outputDate}", style: gColors.bodyText_N_G)),
            Container(width: 80, child: Text("${wData} = ", style: gColors.bodyText_N_G)),
            Container(
              width: 80,
              child: Text("${wDonneesEnAlerte.valeurDonnee}", textAlign: TextAlign.right, style: gColors.bodyText_N_G),
            ),
          ],
        ));
      }

      normalList.add(ListTile(
        onTap: () {},
        dense: true,
        contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 40.0, 0.0),
        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        title: Column(
          children: [
            Row(
              children: [
                Text("${item.nom} ${item.prenom}", style: gColors.bodyText_B_B),
              ],
            ),
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: colData,
                ),
              ],
            ),
            Container(height: 10),
            Container(color: Colors.grey, height: 1.0),
          ],
        ),
      ));
    });
    print(">>>>>>>>>>>>> ListPatients ${ListPatients.length}");

    return ListPatients;
  }

  Widget ListeWidget() {
    print(">>>>>>>>>>>>> ListeWidget  lfPatients >>> ${lfPatients.asStream().length}");
    print(">>>>>>>>>>>>> ListeWidget normalList >>> ${normalList.length}");

    return FutureBuilder<List<Patients>>(
      future: lfPatients,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Patients>? data = snapshot.data;
          return PatientListView();
        } else if (snapshot.hasError) {
          return Text("Liste vide");
        } else {
          print("data " + snapshot.connectionState.toString());
        }
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
          SizedBox(height: 8.0),
          RichText(
            text: TextSpan(
                text: 'Consultez notre politique de confidentialité en cliquant ',
                style: const TextStyle(
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "ici",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchUrl();
                      },
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ]),
          ),
          SizedBox(height: 8.0),
        ],
      ),
    ));
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://epioneweb.fr/epione/public/fr/politique-confidentialite-medecin-epione-mobile');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
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
