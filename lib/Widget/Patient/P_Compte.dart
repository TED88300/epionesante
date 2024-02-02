import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/LaunchUrl.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class P_Compte extends StatefulWidget {
  @override
  P_CompteState createState() => P_CompteState();
}

class P_CompteState extends State<P_Compte> {
  List<Widget> listApp = [];
  List<Widget> listMes = [];
  List<String> listMesURL = [];

  @override
  void initLib() async {
    await DbTools.ApiSrv_User_Info(DbTools.gApiID, DbTools.gApiPassword);
    await DbTools.ApiSrv_Patient_Contact(DbTools.gApiID, DbTools.gApiPassword);
    await DbTools.ApiSrv_patient_appareils(DbTools.api_User_Info.idPatient!);

    if (DbTools.patient_appareilsList.length > 0) {
      List<Appareils>? appareils = DbTools.patient_appareilsList;
      appareils.forEach((item) {
        if (item.paramMobile == null) {
          listApp.add(gColors.wAppareil(
              "${item.imageUrl}",
              "${item.libelle}",
              "Durée : Auto",
              "https://www.synapse-sante.fr/wp-content/uploads/MANUEL-UTILISATEUR-PRISMA.pdf"));
        } else {
          listMes.add(gColors.wMesure(
              "",
              "${item.libelle}",
              "${item.paramMobile!.libelleFamille}",
              "https://www.synapse-sante.fr/wp-content/uploads/MANUEL-UTILISATEUR-PRISMA.pdf"));
          listMesURL.add(
              "https://www.synapse-sante.fr/wp-content/uploads/MANUEL-UTILISATEUR-PRISMA.pdf");
        }
      });
    }

    print("listApp ${listApp.length}");
    setState(() {});
  }

  void initState() {
    initLib();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: gColors.white,
      child: Column(
        children: <Widget>[
          SizedBox(height: 8.0),

          SizedBox(height: 8.0),
//              SingleChildScrollView(child:

          wLabels(),

          listApp.length == 0 ? Container() : wListApps(),
          listApp.length == 0 ? Container() : gColors.wDoubleLigne(),
          listMes.length == 0 ? Container() : wListMess(),
          listMes.length == 0 ? Container() : gColors.wDoubleLigne(),

          Spacer(),

          wFooter(),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text("Ref ${DbTools.api_User_Info.numeroSs} ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  )),
              Spacer(),
              Text(DbTools.gVersion,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                  )),
            ],
          ),
          SizedBox(height: 8.0),
        ],
      ),
    );
  }

  Widget wLabels() {
    return Column(
      children: [
        gColors.wLabel(null, "Nom",
            "${DbTools.api_User_Info.prenom} ${DbTools.api_User_Info.nom}"),
        SizedBox(height: 4.0),
        Container(
          height: 1,
          color: gColors.primary,
        ),
        SizedBox(height: 8.0),
        gColors.wLabel(
            Icons.calendar_month, "Naissance", "01/01/1959 (63 ans)•"),
        gColors.wLabel(Icons.mail, "Mail", "KARIMA@gmail.com•"),
        gColors.wLabel(Icons.phone, "Téléphone", "07.81.31.24.14•"),
        SizedBox(height: 4.0),
        Container(
          height: 1,
          color: gColors.primary,
        ),
        SizedBox(height: 38.0),
      ],
    );
  }

  Widget wFooter() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: ElevatedButton(
            onPressed: () async {
              await _showMyDialog();
            },
style: ElevatedButton.styleFrom(           backgroundColor: gColors.primary,           padding: const EdgeInsets.all(12),         ),            child: Text('Contacter Epione Santé',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Image.asset(
                  "assets/images/Ico.png",
                  height: 25,
                ),
              ),
              Text('Contacter Epione Santé'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gColors.primary,
                        padding: const EdgeInsets.all(12),
                      ),

                      child: Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text('Mail à Epione Santé',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gColors.primary,
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text('Appeller votre technicien',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
                Container(
                  height: 10,
                ),
                Container(
                  width: 300,
                  child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: gColors.primary,
                        padding: const EdgeInsets.all(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          Container(
                            width: 10,
                          ),
                          Text('Appeller notre pharmacien',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      )),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget wListApps() {
    print("wListApps ${listApp.length}");

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listApp.length,
      itemBuilder: (context, index) {
        final item = listApp[index];

        return ListTile(
          onTap: () {},
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: item,
        );
      },
    );
  }

  Widget wListMess() {
    print("wListApps ${listMes.length}");

    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listMes.length,
      itemBuilder: (context, index) {
        final item = listMes[index];

        return ListTile(
          onTap: () {
            print("tap ");
            launchURL(listMesURL[index]);
          },
          dense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: item,
        );
      },
    );
  }
}
