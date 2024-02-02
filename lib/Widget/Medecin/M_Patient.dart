import 'package:auto_size_text/auto_size_text.dart';
import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class M_Patient extends StatefulWidget {
  @override
  M_PatientState createState() => M_PatientState();
}

class M_PatientState extends State<M_Patient> {
  bool val = false;

  bool wTRV_OXYMETRE = false;
  bool wTRV_TENSIOMETRE = false;

  List<Widget> listApp = [];

  List<Widget> listMes = [];
  List<Appareils> listApp_Mesure = [];
  List<String> listApp_MessNOTUSED = [];
  List<String> listApp_MessNOTUSEDSeuil = [];

  List<bool> blistApp_MessNOTUSED = [];
  List<int> ilistApp_MessNOTUSED_Period = [];
  final List<String> listApp_Period = ['1 Semaine', '15 jours', '30 jours', '2 Mois', '3 Mois'];

  int Seuil_Systm = 0;
  int Seuil_SystM = 0;

  int Seuil_Diam = 0;
  int Seuil_DiaM = 0;

  int Seuil_Sat = 0;


  bool wsel = false;

  @override
  void initLib() async {
    await DbTools.getAppareilPat(0);
    await DbTools.ApiSrv_patient_appareils(DbTools.medecin_patients.cryptedId!);

    print("DbTools.gApiID ${DbTools.gApiID}");
    print("DbTools.gApiPassword ${DbTools.gApiPassword}");
    print("DbTools.cryptedId ${DbTools.medecin_patients.cryptedId}");

    if (DbTools.patient_appareilsList.length > 0) {
      List<Appareils>? appareils = DbTools.patient_appareilsList;

      appareils.forEach((item) async {
        print("@@@@@@@@@@@@@ medecin_patients ${item.libelle} ${item.paramMobile!.libelleFamille}");

        if (!item.libelle!.contains("APPRÉCIATION")) {
          if (item.libelle!.contains("OXYMETRE")) {
            wTRV_OXYMETRE = true;
          }
          if (item.libelle!.contains("TENSIOMETRE")) {
            wTRV_TENSIOMETRE = true;
          }

          if (item.paramMobile == null) {
            listApp.add(gColors.wAppareil("${item.imageUrl}", "${item.libelle}", "Durée : Auto", "https://www.synapse-sante.fr/wp-content/uploads/MANUEL-UTILISATEUR-PRISMA.pdf"));
          } else {
            listMes.add(gColors.wMesure("", "${item.libelle}", "${item.paramMobile!.libelleFamille}", "https://www.synapse-sante.fr/wp-content/uploads/MANUEL-UTILISATEUR-PRISMA.pdf"));

            listApp_Mesure.add(item);
          }
        }
      });
    }

    listApp_MessNOTUSED.clear();
    blistApp_MessNOTUSED.clear();
    ilistApp_MessNOTUSED_Period.clear();
    listApp_MessNOTUSEDSeuil.clear();

    if (!wTRV_OXYMETRE) {
      listApp_MessNOTUSED.add("OXYMETRE");
      blistApp_MessNOTUSED.add(false);
      ilistApp_MessNOTUSED_Period.add(2);
      listApp_MessNOTUSEDSeuil.add("Seuil saturation");
    }

    if (!wTRV_TENSIOMETRE) {
      listApp_MessNOTUSED.add("TENSIOMETRE");
      blistApp_MessNOTUSED.add(false);
      ilistApp_MessNOTUSED_Period.add(2);
      listApp_MessNOTUSEDSeuil.add("Seuil systolique,Seuil diastolique");
    }

    await DbTools.ApiSrv_medecin_patient_getNotification(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!);
    val = DbTools.api_Notification.notification!;
    setState(() {});
    LoadDonnees();
  }

  void LoadDonnees() async {
    for (int i = 0; i < listApp_Mesure.length; i++) {
      Appareils item = listApp_Mesure[i];

      for (int j = 0; j < item.paramMobile!.donnees!.length; j++) {
        Donnees donnee = item.paramMobile!.donnees![j];
        await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "objectif", donnee.code!);
        donnee.medObj = "";
        if (DbTools.api_Donnee_Patient.valeurDonnee != null) donnee.medObj = DbTools.api_Donnee_Patient.valeurDonnee!;
        await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "seuilmini", donnee.code!);

        donnee.medMini = "";
        if (DbTools.api_Donnee_Patient.valeurDonnee != null) donnee.medMini = DbTools.api_Donnee_Patient.valeurDonnee!;

        await DbTools.ApiSrv_medecin_patient_getDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "seuilmaxi", donnee.code!);

        donnee.medMaxi = "";
        if (DbTools.api_Donnee_Patient.valeurDonnee != null) donnee.medMaxi = DbTools.api_Donnee_Patient.valeurDonnee!;
      }
    }

    setState(() {});
  }

  @override
  void initState() {
    initLib();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //    endDrawer: DbTools.gIsMedecinLogin! ? C_SideDrawer() : I_SideDrawer(),

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: AutoSizeText(
            "Fiche Patient",
            maxLines: 1,
          ),
          backgroundColor: gColors.primary,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          color: gColors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0),
              wLabels(),
              SizedBox(height: 8.0),
              wListMess(),
              wAppAdd(),
              wNotif(),

              SizedBox(height: 10.0),
              Text(
                "Contacter le patient",
                style: gColors.bodyText_B_G,
              ),
//              SizedBox(height: 10.0),
  Spacer(),
              wBtnCall(),
//              gColors.wDoubleLigne(),
//              listApp.length > 0 ? wListApps() : Container(),
//              listApp.length > 0 ? gColors.wDoubleLigne() : Container(),

              SizedBox(height: 20.0),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(child: wBtnValidation()));
  }

  void sending_SMS(String msg, List<String> list_receipents) async {
    String send_result = await sendSMS(message: msg, recipients: list_receipents).catchError((err) {
      print(err);
    });
    print(send_result);
  }

  Widget wAppAdd() {
    if (listApp_MessNOTUSED.length == 0) return Container();

    return Container(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 8), // TED

        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Text(
            "Appareils à Ajouter",
            style: gColors.bodyText_B_B,
          ),
          wListMessNOTUSED()
        ]));
  }

  Widget wNotif() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Notifications",
              style: gColors.bodyText_B_G,
            ),
            Spacer(),
            Switch(
              value: val,
              onChanged: (value) {
                setState(() async {
                  val = value;
                  await DbTools.ApiSrv_medecin_patient_setNotification(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, val);
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget wLabels() {
    var Nais_Age = "";
    if (DbTools.medecin_patients.dateNaissance!.length > 0) {
      final date_naissance = DateTime.parse(DbTools.medecin_patients.dateNaissance!);
      Nais_Age = "   ${DateFormat('dd/MM/yyy').format(date_naissance)} ";
    }

    return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
      Text(
        "${DbTools.medecin_patients.prenom} ${DbTools.medecin_patients.nom}",
        style: gColors.bodyText_B_B,
      ),
/*
          SizedBox(height: 8.0),
          Text(
            "${Nais_Age}",
            style: gColors.bodyText_N_B,
          ),
*/
    ]);
  }

  Widget wBtnCall() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () async {
            if (DbTools.medecin_patients.email!.length > 0) {
              final Email send_email = Email(
                subject: 'AIRSENSE 10 AUTOSET',
                body: 'Bonjour Madame Aarab,\nJe pense que vous devriez utiliser un peu plus souvent cet appareil\nCordialement\nDr OUMAMA *BADARANI*',
                recipients: [DbTools.medecin_patients.email!],
                isHTML: false,
              );
              await FlutterEmailSender.send(send_email);
            }
          },
          child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.mail,
                color: DbTools.medecin_patients.email!.length == 0 ? Colors.grey : gColors.secondary,
                size: 35,
              )),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: Colors.white,
            elevation: 4,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (DbTools.medecin_patients.telephone!.length > 0) {
              if (!await launchUrl(Uri.parse('tel:${DbTools.medecin_patients.telephone}'))) throw 'Could not launch tel';
            }
          },
          child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.phone,
                color: DbTools.medecin_patients.telephone!.length == 0 ? Colors.grey : gColors.secondary,
                size: 35,
              )),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: Colors.white,
            elevation: 4,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            if (DbTools.medecin_patients.telephone!.length > 0) {
              sending_SMS(
                'Bonjour Madame Aarab,\nJe pense que vous devriez utiliser un peu plus souvent cet appareil\nCordialement\nDr OUMAMA *BADARANI*',
                ['${DbTools.medecin_patients.telephone}'],
              );
            }
          },
          child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.message,
                color: DbTools.medecin_patients.telephone!.length == 0 ? Colors.grey : gColors.secondary,
                size: 35,
              )),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            primary: Colors.white,
            elevation: 4,
          ),
        ),
      ],
    );
  }

  Widget wBtnValidation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 20), // TED
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                bool Trv = false;
                print("repss ${blistApp_MessNOTUSED}");
                for (int i = 0; i < blistApp_MessNOTUSED.length; i++) {
                  if (blistApp_MessNOTUSED[i]) {
                    Trv = true;
                    break;
                  }
                }
                if (Trv) {
                  DateTime now = DateTime.now();
                  String formattedDate = DateFormat('dd/MM/yyyy à kk:mm').format(now);

                  String wSujet = "Demande d’ajout d'appareil ${DbTools.medecin_patients.nom} ${DbTools.medecin_patients.prenom}";
                  String wCont = "Date : ${formattedDate} \n\n";
                  wCont = wCont + "Médecin demandeur : ${DbTools.api_User_Info.nom} ${DbTools.api_User_Info.prenom} \n";
                  wCont = wCont + "${DbTools.api_User_Info.email} (Orthop : ${DbTools.api_User_Info.numeroOrthop} - Rpps :${DbTools.api_User_Info.numeroRpps} - Ameli : ${DbTools.api_User_Info.numeroAmeli} ) \n\n";
                  wCont = wCont + "Patient : ${DbTools.medecin_patients.nom} ${DbTools.medecin_patients.prenom}\n";
                  wCont = wCont + "${DbTools.medecin_patients.email} ${DbTools.medecin_patients.dateNaissance} (Orthop : ${DbTools.medecin_patients.numeroOrthop})\n\n";
                  wCont = wCont + "Appareil demandé : \n";

                  for (int i = 0; i < blistApp_MessNOTUSED.length; i++) {
                    if (blistApp_MessNOTUSED[i]) {
                      String App = listApp_MessNOTUSED[i];
                      wCont = wCont + "-> ${App} pour ${listApp_Period[ilistApp_MessNOTUSED_Period[i]]}\n";
                    }
                  }
                  await DbTools.ApiSrv_User_sendMail(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, wSujet, wCont);

                  print("${wCont}");
                }

                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("votre demande a bien été prise en compte."),
                ));

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gColors.secondary,
                padding: const EdgeInsets.all(12),
              ),
              child: Text('VALIDER', style: gColors.bodyTitle1_B_Wr),
            )),
      ],
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
    print("wListMess  ${listMes.length}");
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // TED
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0), // TED


      decoration: BoxDecoration(
        color: gColors.white,
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),

      child: Container(
        height: listApp_MessNOTUSED.length == 0 ? 400 :210,
        child: ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: listMes.length,
          itemBuilder: (context, index) {
            final item = listMes[index];
            final itemlistApp = listApp_Mesure[index];

            return Container(

                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), // TED
                color: Colors.white,

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    item,
                    wListMesures(itemlistApp),

                    /*
                    ListTile(
                      onTap: () {},
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: item,
                      subtitle: wListMesures(itemlistApp),
                    ),


                     */
                  ],
                ));
          },
        ),
      ),
    );
  }

  Widget wListMessNOTUSED() {
    print("listApp_MessNOTUSED  ${listApp_MessNOTUSED.length}");
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0), // TED
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0), // TED

      //color: gColors.white,

      decoration: BoxDecoration(
        color: gColors.white,
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listApp_MessNOTUSED.length,
        itemBuilder: (context, index) {
          final item = listApp_MessNOTUSED[index];
          final Seuils = listApp_MessNOTUSEDSeuil[index];

          var tSeuils = Seuils.split(',');
          String sSeuil_Systm = Seuil_Systm == 0 ? "--": "${Seuil_Systm}";;
          String sSeuil_SystM = Seuil_SystM == 0 ? "--": "${Seuil_SystM}";;

          String sSeuil_DiaM = Seuil_DiaM == 0 ? "--": "${Seuil_DiaM}";;
          String sSeuil_Diam = Seuil_Diam == 0 ? "--": "${Seuil_Diam}";;



          String sSeuil_Sat = Seuil_Sat == 0 ? "--": "${Seuil_Sat}";;



          return Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Column(


              children: [

                Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Checkbox(                          value: blistApp_MessNOTUSED[index],
                          onChanged: (bool? value) async {
                            blistApp_MessNOTUSED[index] = value!;

                            if (tSeuils.length > 0) await SaisieAddDialog(tSeuils[0]);
                            if (tSeuils.length > 1) await SaisieAddDialog(tSeuils[1]);

                            setState(() {});
                          },
                        ),


                          Text(
                              item,
                              textAlign: TextAlign.left,
                              style: gColors.bodyText_B_G,
                            ),


                        Spacer(),
                        Container(
                          width: 160,
                          height: 80,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(initialItem: 2),
                            backgroundColor: Colors.white,
                            onSelectedItemChanged: (value) {
                              setState(() {
                                ilistApp_MessNOTUSED_Period[index] = value;
                              });
                            },
                            itemExtent: 28.0,
                            children: [
                              Text(listApp_Period[0]),
                              Text(listApp_Period[1]),
                              Text(listApp_Period[2]),
                              Text(listApp_Period[3]),
                              Text(listApp_Period[4]),
                            ],
                          ),
                        ),
                      ],
                    ),

              ],
            ),
          );
        },
      ),
    )
        //,)
        ;
  }

  Future<void> SaisieAddDialog(String tSeuils) async {
    print("tSeuils $tSeuils ${tSeuils.contains("Tension systolique")}");
    Donnees aDonnees = Donnees();

    if (tSeuils.contains("systolique")) {
      aDonnees = Donnees.fromJson({
        "code": "tension_systolique",
        "libelle": "Tension systolique",
        "unite": "mmHg",
        "format": "int",
        "format_affichage": "",
        "valeurs_for_fixtures": [0],
        "seuil_mini": Seuil_Systm,
        "seuil_maxi": Seuil_SystM
      });
      aDonnees.medMini = "${Seuil_Systm}";
      aDonnees.medMaxi = "${Seuil_SystM}";
    }

    if (tSeuils.contains("diastolique")) {
      aDonnees = Donnees.fromJson({
        "code": "tension_diastolique",
        "libelle": "Tension diastolique",
        "unite": "mmHg",
        "format": "int",
        "format_affichage": "",
        "valeurs_for_fixtures": [0],
        "seuil_mini": Seuil_Diam,
        "seuil_maxi": Seuil_DiaM
      });
      aDonnees.medMini = "${Seuil_Diam}";
      aDonnees.medMaxi = "${Seuil_DiaM}";
    }

    if (tSeuils.contains("saturation")) {
      aDonnees = Donnees.fromJson({
        "code": "saturation",
        "libelle": "saturation",
        "unite": "%",
        "format": "int",
        "format_affichage": "",
        "valeurs_for_fixtures": [0],
        "seuil_mini": Seuil_Sat,
        "seuil_maxi": 0
      });
      aDonnees.medMini = "${Seuil_Sat}";
      aDonnees.medMaxi = "${Seuil_Sat}";
    }

    TextEditingController seuilMiniController = TextEditingController();
    TextEditingController seuilMaxiController = TextEditingController();
    TextEditingController seuilObjController = TextEditingController();

    print("SaisieAddDialog aDonnees ${aDonnees.toJson()}");
    print("SaisieAddDialog medMini ${aDonnees.medMini}");
    print("SaisieAddDialog medMaxi ${aDonnees.medMaxi}");

    seuilMiniController.text = aDonnees.medMini;
    seuilMaxiController.text = aDonnees.medMaxi;
    seuilObjController.text = aDonnees.medObj;

    String wTitre = "";
    if (aDonnees.code!.contains("syst") || aDonnees.code!.contains("dias")) {
      aDonnees.medObj = "";
      if (aDonnees.medMini == "") aDonnees.medMini = "--";
      if (aDonnees.medMaxi == "") aDonnees.medMaxi = "--";
      wTitre = "Saisie Seuils";
    }

    if (aDonnees.code!.contains("saturation")) {
      wTitre = "Saisie Seuil";
    }

    if (aDonnees.code!.contains("poids")) {
      wTitre = "Saisie Objectif";
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: 300,
                color: gColors.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(wTitre, style: gColors.bodyTitle1_B_Wr),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 25),
                    width: 300,
                    color: gColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${aDonnees.libelle} ", style: gColors.bodyTitle1_B_Pr),

                      ],
                    ),
                  ),
                  !aDonnees.code!.contains("tension") && !aDonnees.code!.contains("saturation")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text("Seuil Mini :", style: gColors.bodyText_B_G),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: gColors.bodyText_N_G,
                                  controller: seuilMiniController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (newValue) {
                                    return null;
                                  },
                                  autofocus: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !aDonnees.code!.contains("tension")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text("Seuil Maxi :", style: gColors.bodyText_B_G),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: gColors.bodyText_N_G,
                                  controller: seuilMaxiController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (newValue) {
                                    return null;
                                  },
                                  autofocus: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !aDonnees.code!.contains("poids")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text("Objectif :", style: gColors.bodyText_B_G),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: gColors.bodyText_N_G,
                                  controller: seuilObjController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (newValue) {
                                    return null;
                                  },
                                  autofocus: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              Container(
                height: 10,
              ),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Valider'),
              onPressed: () async {
                await DbTools.ApiSrv_medecin_patient_setDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "objectif", aDonnees.code!, seuilObjController.text);
                await DbTools.ApiSrv_medecin_patient_setDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "seuilmini", aDonnees.code!, seuilMiniController.text);
                await DbTools.ApiSrv_medecin_patient_setDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "seuilmaxi", aDonnees.code!, seuilMaxiController.text);

                Navigator.of(context).pop();
              },
            ),
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


/*
  secondList(Appareils aListAppareil) {

    List<Widget> subList = [];
    aListAppareil.paramMobile!.donnees!.forEach((data) {
      subList.add(
        Card(
          child: Container(
            padding: EdgeInsets.all(16.0),
            color: Colors.lightBlueAccent,
            child: Text('$data'),
          ),
        ),
      );
    });
    // Populate Column instead of ListView
    return Column(
      children: subList,
    );
  }
}
*/

  Widget wListMesures(Appareils aListAppareil) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Container(

            color: gColors.white,
            child: Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: aListAppareil.paramMobile!.donnees!.length,
                  itemBuilder: (context, index) {
                    final item = aListAppareil.paramMobile!.donnees![index];
                    print("item ${item.toJson()}");

                    Widget wAff1 = Container();
                    Widget wAff2 = Container();

                    if (item.code!.contains("tension")) {
                      item.medObj = "";
                      if (item.medMini == "") item.medMini = "--";
                      if (item.medMaxi == "") item.medMaxi = "--";
                      item.libelle = item.libelle!.replaceAll("Tension ", "");
                      wAff1 = Text("Seuil ${item.libelle} ", style: gColors.bodyText_B_B);
                      wAff2 = Text(" < ${item.medMini} ou >  ${item.medMaxi}", style: gColors.bodyText_B_S);
                    }

                    if (item.code!.contains("pouls")) {
                      item.medMini = "";
                      item.medMaxi = "";
                      item.medObj = "";
                    }

                    if (item.code!.contains("saturation")) {
                      item.medMaxi = "";
                      item.medObj = "";
                      if (item.medMini == "") item.medMini = "--";
                      wAff1 = Text("Seuil ${item.libelle} ", style: gColors.bodyText_B_B);
                      wAff2 = Text(" < ${item.medMini}", style: gColors.bodyText_B_S);
                    }

                    if (item.code!.contains("poids")) {
                      wAff1 = Text("Objectif : ${item.libelle} ", style: gColors.bodyText_B_B);
                      wAff2 = Text(" ${item.medObj}", style: gColors.bodyText_B_S);
                    }

                    return ListTile(
                      onTap: () async {
                        if (item.code!.contains("pouls")) return;
                        await SaisieDialog(item);
                        LoadDonnees();
                      },
                      dense: true,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [wAff1, wAff2],
                          ),
                        ],
                      ),
                    );
                  },
                ),

              ],
            )));
  }

  Future<void> SaisieDialog(Donnees aDonnees) async {
    TextEditingController seuilMiniController = TextEditingController();
    TextEditingController seuilMaxiController = TextEditingController();
    TextEditingController seuilObjController = TextEditingController();

    print("aDonnees ${aDonnees.toJson()}");

    seuilMiniController.text = aDonnees.medMini;
    seuilMaxiController.text = aDonnees.medMaxi;
    seuilObjController.text = aDonnees.medObj;

    String wTitre = "";
    if (aDonnees.code!.contains("tension")) {
      aDonnees.medObj = "";
      if (aDonnees.medMini == "") aDonnees.medMini = "--";
      if (aDonnees.medMaxi == "") aDonnees.medMaxi = "--";
      wTitre = "Saisie Seuils";
    }

    if (aDonnees.code!.contains("saturation")) {
      wTitre = "Saisie Seuil";
    }

    if (aDonnees.code!.contains("poids")) {
      wTitre = "Saisie Objectif";
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                width: 300,
                color: gColors.secondary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(wTitre, style: gColors.bodyTitle1_B_Wr),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 25),
                    width: 300,
                    color: gColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("${aDonnees.libelle} ", style: gColors.bodyTitle1_B_Pr),
                        Text("(${aDonnees.unite})", style: gColors.bodyTitle1_B_Pr),
                      ],
                    ),
                  ),
                  !aDonnees.code!.contains("tension") && !aDonnees.code!.contains("saturation")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text("Seuil Mini :", style: gColors.bodyText_B_G),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: gColors.bodyText_N_G,
                                  controller: seuilMiniController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (newValue) {
                                    return null;
                                  },
                                  autofocus: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !aDonnees.code!.contains("tension")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text("Seuil Maxi :", style: gColors.bodyText_B_G),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: gColors.bodyText_N_G,
                                  controller: seuilMaxiController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (newValue) {
                                    return null;
                                  },
                                  autofocus: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !aDonnees.code!.contains("poids")
                      ? Container()
                      : Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                child: Text("Objectif :", style: gColors.bodyText_B_G),
                              ),
                              Container(
                                width: 20,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: gColors.bodyText_N_G,
                                  controller: seuilObjController,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  validator: (newValue) {
                                    return null;
                                  },
                                  autofocus: false,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
              Container(
                height: 10,
              ),
            ]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Valider'),
              onPressed: () async {
                await DbTools.ApiSrv_medecin_patient_setDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "objectif", aDonnees.code!, seuilObjController.text);
                await DbTools.ApiSrv_medecin_patient_setDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "seuilmini", aDonnees.code!, seuilMiniController.text);
                await DbTools.ApiSrv_medecin_patient_setDonnee_Patient(DbTools.gApiID, DbTools.gApiPassword, DbTools.medecin_patients.cryptedId!, "seuilmaxi", aDonnees.code!, seuilMaxiController.text);

                Navigator.of(context).pop();
              },
            ),
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
}
