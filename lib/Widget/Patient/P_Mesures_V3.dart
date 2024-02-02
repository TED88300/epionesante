import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gNewWidget.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

class P_Mesures_V3 extends StatefulWidget {
  @override
  P_Mesures_V3State createState() => P_Mesures_V3State();
}

class P_Mesures_V3State extends State<P_Mesures_V3> {
  List<Widget> listBtnMenu = [];

  int Page = 0;
  int PageSommeil = 0;
  int PageSommeil2 = 0;
  String Error = "";

  final _cardNumberFocus = FocusNode();
  final _cardNumberFocus2 = FocusNode();
  DateTime now = DateTime.now();

  List<Label_TextField> listLabel_TextField = [];
  List<Widget> listTF_Context = [];
  List<TextEditingController> listTEC_Context = [];
  int indContextTF = 0;

  List<String> listContextesToggleSwitch = [];
  List<String> listContextesToggleSwitchVal = [];
  List<Widget> listContextesToggleSwitchWidget = [];
  List<bool> listContextesToggleSwitchbool = [];

  List<String> sBtnMenuData = [];
  List<String> sBtnMenuContextData = [];

  List<String> ResultLib = [];
  List<String> ResultVal = [];

  String validationTxt = "";
  double fontSize = 18;

  var wControllerTS1 = TextEditingController();
  var wControllerTS2 = TextEditingController();
  var wControllerTS3 = TextEditingController();

  var wControllerTD1 = TextEditingController();
  var wControllerTD2 = TextEditingController();
  var wControllerTD3 = TextEditingController();

  var wControllerP1 = TextEditingController();
  var wControllerP2 = TextEditingController();
  var wControllerP3 = TextEditingController();

  var wControllerS = TextEditingController();
  var wControllerP = TextEditingController();
  var wControllerK = TextEditingController();

  @override
  Future initLib() async {
    listLabel_TextField.clear();
    listTF_Context.clear();
    listTEC_Context.clear();

    sBtnMenuData.clear();
    sBtnMenuContextData.clear();
    listBtnMenu.clear();

    await DbTools.ApiSrv_patient_appareils(DbTools.api_User_Info.idPatient!);

    print(">>>>>>>>> DbTools.ApiSrv_patient_appareils ${DbTools.api_User_Info.idPatient!}");

    String wContextesUsed = "";

    List<DonneesUserMedecinPatient> wDonneesUserMedecinPatientList = DbTools.patient_donneesUserMedecinPatientList;

    if (DbTools.patient_appareilsList.length > 0) {
      List<Appareils>? appareils = DbTools.patient_appareilsList;

      appareils.forEach((item) {
        if (item.libelle == "APPRÉCIATION DU SOMMEIL") {
          int cptFocus = 0;
          if (item.paramMobile != null) {
            if (item.paramMobile?.donnees != null) {
              List<Donnees> listDonnees = [];
              List<Widget> listTF = [];
              List<TextEditingController> listTEC = [];

              listTF.clear();
              listDonnees.clear();
              listTEC.clear();

              print("ADS libelleFamille ${item.libelle} ${item.paramMobile?.donnees!.length} ${item.famille} ${item.code}");

              for (int i = 0; i < 2; i++) {
//              item.paramMobile?.donnees!.forEach((donnee) async {
                Donnees donnee = item.paramMobile!.donnees![i];

                Donnees wDonnee = donnee;

                if (wDonnee.derniereValeur == null) {
                  wDonnee.derniereValeur = "";
                }

                var wController = TextEditingController();
                var wController2 = TextEditingController();

                donnee.medMini = "";
                donnee.medMaxi = "";
                donnee.medObj = "";

                item.paramMobile?.donnees!.forEach((donnee) async {
                  if (DbTools.patient_appareilsList.length > 0) {
                    wDonneesUserMedecinPatientList.forEach((donneesUserMedecinPatient) {
                      String codeDonneeReference = donneesUserMedecinPatient.codeDonneeReference!.toLowerCase();
                      String code = donnee.code!.toLowerCase();
                      if (codeDonneeReference.compareTo(code) == 0) {
                        if (donneesUserMedecinPatient.codeDonnee == "objectif") {
                          donnee.medObj = donneesUserMedecinPatient.valeurDonnee!;
                        }
                        if (donneesUserMedecinPatient.codeDonnee == "seuilmini") {
                          donnee.medMini = donneesUserMedecinPatient.valeurDonnee!;
                        }
                        if (donneesUserMedecinPatient.codeDonnee == "seuilmaxi") {
                          donnee.medMaxi = donneesUserMedecinPatient.valeurDonnee!;
                        }
                      }
                    });
                  }
                });

                if (donnee.medMaxi.length == 0) donnee.medMaxi = "0";
                if (donnee.medMini.length == 0) donnee.medMini = "0";

                print("AAAAAAAAAAAAA m ${donnee.medMini} M ${donnee.medMaxi}");

                listTEC.add(wController);
                var wTF = gColors.wTextFieldMesureV3(wController, wController2, "${wDonnee.unite}", "${wDonnee.libelle}", wDonnee.seuilMini!, wDonnee.seuilMaxi!, int.parse(wDonnee.medMini), int.parse(wDonnee.medMaxi), donnee.medObj, wDonnee.derniereValeur!, cptFocus == 0 ? _cardNumberFocus : _cardNumberFocus2, context);
                listTF.add(wTF);
                cptFocus++;
                listDonnees.add(wDonnee);
                wContextesUsed += ",${wDonnee.contexte}";
              }
              Widget wLabelMesure = gColors.wLabelMesure(item.paramMobile!.libelleFamille!, item.libelle!);
              Label_TextField wLabel_TextField = Label_TextField("${item.famille}", "${item.code}", wLabelMesure, item.paramMobile!.libelleFamille!, listTF, listDonnees, listTEC);
              listLabel_TextField.add(wLabel_TextField);
            }

            if (item.paramMobile?.donnees != null) {
              List<Donnees> listDonnees = [];
              List<Widget> listTF = [];
              List<TextEditingController> listTEC = [];

              listTF.clear();
              listDonnees.clear();
              listTEC.clear();

              print("ADS libelleFamille ${item.libelle} ${item.paramMobile?.donnees!.length} ${item.famille}2 ${item.code}2");

              for (int i = 2; i < item.paramMobile!.donnees!.length; i++) {
                Donnees donnee = item.paramMobile!.donnees![i];

                Donnees wDonnee = donnee;

                if (wDonnee.derniereValeur == null) {
                  wDonnee.derniereValeur = "";
                }

                var wController = TextEditingController();
                var wController2 = TextEditingController();

                donnee.medMini = "";
                donnee.medMaxi = "";
                donnee.medObj = "";

                item.paramMobile?.donnees!.forEach((donnee) async {
                  if (DbTools.patient_appareilsList.length > 0) {
                    wDonneesUserMedecinPatientList.forEach((donneesUserMedecinPatient) {
                      String codeDonneeReference = donneesUserMedecinPatient.codeDonneeReference!.toLowerCase();
                      String code = donnee.code!.toLowerCase();
                      if (codeDonneeReference.compareTo(code) == 0) {
                        if (donneesUserMedecinPatient.codeDonnee == "objectif") {
                          donnee.medObj = donneesUserMedecinPatient.valeurDonnee!;
                        }
                        if (donneesUserMedecinPatient.codeDonnee == "seuilmini") {
                          donnee.medMini = donneesUserMedecinPatient.valeurDonnee!;
                        }
                        if (donneesUserMedecinPatient.codeDonnee == "seuilmaxi") {
                          donnee.medMaxi = donneesUserMedecinPatient.valeurDonnee!;
                        }
                      }
                    });
                  }
                });

                if (donnee.medMaxi.length == 0) donnee.medMaxi = "0";
                if (donnee.medMini.length == 0) donnee.medMini = "0";

                print("BBBBBBBB m ${donnee.medMini} M ${donnee.medMaxi}");

                listTEC.add(wController);
                var wTF = gColors.wTextFieldMesureV3(wController, wController2, "${wDonnee.unite}", "${wDonnee.libelle}", wDonnee.seuilMini!, wDonnee.seuilMaxi!, int.parse(wDonnee.medMini), int.parse(wDonnee.medMaxi), donnee.medObj, wDonnee.derniereValeur!, cptFocus == 0 ? _cardNumberFocus : _cardNumberFocus2, context);
                listTF.add(wTF);
                cptFocus++;
                listDonnees.add(wDonnee);
                wContextesUsed += ",${wDonnee.contexte}";

                print("cptFocus ${wDonnee.libelle} ${i} ${wDonnee.libelle}");
              }
              Widget wLabelMesure = gColors.wLabelMesure(item.paramMobile!.libelleFamille!, item.libelle!);
              Label_TextField wLabel_TextField = Label_TextField("${item.famille}", "${item.code}", wLabelMesure, item.paramMobile!.libelleFamille!, listTF, listDonnees, listTEC);
              listLabel_TextField.add(wLabel_TextField);
            }
          }
        } else {
          if (item.paramMobile != null) {
            if (item.paramMobile?.donnees != null) {
              print("libelleFamille ${item.libelle}");
              int cptFocus = 0;
              item.paramMobile?.donnees!.forEach((donnee) async {
                List<Donnees> listDonnees = [];
                List<Widget> listTF = [];
                List<TextEditingController> listTEC = [];

                listTF.clear();
                listDonnees.clear();
                listTEC.clear();

                Donnees wDonnee = donnee;
                var wController = TextEditingController();
                var wController2 = TextEditingController();

                if (wDonnee.derniereValeur == null) {
                  wDonnee.derniereValeur = "";
                }

                donnee.medMini = "";
                donnee.medMaxi = "";
                donnee.medObj = "";
                item.paramMobile?.donnees!.forEach((donnee) async {

                  if (DbTools.patient_appareilsList.length > 0) {
                    wDonneesUserMedecinPatientList.forEach((donneesUserMedecinPatient) {



                      String codeDonneeReference = donneesUserMedecinPatient.codeDonneeReference!.toLowerCase();
                      String code = donnee.code!.toLowerCase();
                      if (codeDonneeReference.compareTo(code) == 0) {
                        if (donneesUserMedecinPatient.codeDonnee == "objectif") {
                          donnee.medObj = donneesUserMedecinPatient.valeurDonnee!;
                        }
                        if (donneesUserMedecinPatient.codeDonnee == "seuilmini") {
                          donnee.medMini = donneesUserMedecinPatient.valeurDonnee!;
                        }
                        if (donneesUserMedecinPatient.codeDonnee == "seuilmaxi") {
                          donnee.medMaxi = donneesUserMedecinPatient.valeurDonnee!;
                        }
                      }
                    });
                  }
                });

                if (donnee.medMaxi.length == 0) donnee.medMaxi = "0";
                if (donnee.medMini.length == 0) donnee.medMini = "0";
                print("CCCCCCCC m ${donnee.medMini} M ${donnee.medMaxi}");

                listTEC.add(wController);
                var wTF = gColors.wTextFieldMesureV3(wController, wController2, "${wDonnee.unite}", "${wDonnee.libelle}", wDonnee.seuilMini!, wDonnee.seuilMaxi!, int.parse(wDonnee.medMini), int.parse(wDonnee.medMaxi), donnee.medObj, wDonnee.derniereValeur!, cptFocus == 0 ? _cardNumberFocus : _cardNumberFocus2, context);
                listTF.add(wTF);
                cptFocus++;
                listDonnees.add(wDonnee);
                wContextesUsed += ",${wDonnee.contexte}";
                Widget wLabelMesure = gColors.wLabelMesure(item.paramMobile!.libelleFamille!, item.libelle!);
                Label_TextField wLabel_TextField = Label_TextField("${item.famille}", "${item.code}", wLabelMesure, item.paramMobile!.libelleFamille!, listTF, listDonnees, listTEC);
                listLabel_TextField.add(wLabel_TextField);
              });
            }
          }
        }
      });
    }

    String sBtnMenu = "";
    int i = 0;
    int wMarge = 60;
    listLabel_TextField.forEach((item) {
      sBtnMenu = "${sBtnMenu}, ${item.sLabel}";

      print(">>>> sBtnMenu $i ${item.sLabel}");
      item.listDonnees.forEach((item2) {
        print(">>>> ${item2.libelle}");

        if (item.sLabel == "TENSIOMÈTRE" && item2.libelle == "Pouls") {
          sBtnMenuData.add("Pouls2");
        } else
          sBtnMenuData.add(item2.libelle!);
      });

      i++;
    });

    print(">>>> sBtnMenu ${sBtnMenu}");
    print(">>>> sBtnMenuData ${sBtnMenuData}");

    if (sBtnMenu.contains("OXYMÈTRE")) {
      listBtnMenu.add(RoundedButton(
        Title: "MA SATURATION",
        backgroundColor: gColors.primary,
        onPressed: AffMessageSat,
        width: MediaQuery.of(context).size.width - wMarge,
      ));

//      if (!sBtnMenu.contains("TENSIOMÈTRE")) {
/*
        listBtnMenu.add(RoundedButton(
          Title: "MON POULS",
          backgroundColor: gColors.primary,
          onPressed: PressPouls1,
          width: MediaQuery.of(context).size.width - wMarge,
        ));
*/
//      }
    }
    if (sBtnMenu.contains("TENSIOMÈTRE")) {
      listBtnMenu.add(RoundedButton(
        Title: "MA TENSION",
        backgroundColor: gColors.primary,
        onPressed: PressTension,
        width: MediaQuery.of(context).size.width - wMarge,
      ));
    }
    if (sBtnMenu.contains("PÈSE-PERSONNE")) {
      listBtnMenu.add(RoundedButton(
        Title: "MON POIDS",
        backgroundColor: gColors.primary,
        onPressed: PressPoids,
        width: MediaQuery.of(context).size.width - wMarge,
      ));
    }

    print(">>>> listBtnMenu len ${listBtnMenu.length}");

/*
    listLabel_TextField.forEach((item) {
      item.listDonnees!.forEach((item2) {

        print(">>>> listTF ${item.sLabel} ${item2.libelle}");
      });
    });
*/

    if (DbTools.patient_contextesList.length > 0) {
      List<Contextes>? contextes = DbTools.patient_contextesList;

      contextes.forEach((contexte) {
        print("contexte code ${contexte.code}");

        if (contexte.actif!) {
          String contextecode = contexte.code!.replaceAll(":", "");
          print("contextesA lenght ${wContextesUsed} ${contextecode}");

          if (wContextesUsed.contains(",${contextecode}")) {
            print("contextesB lenght ${contextes.length}");
            if (contexte.donneesContexte != null) {
              print("contextesC lenght ${contextes.length}");
              contexte.donneesContexte!.forEach((donneesContexte) {
                DonneesContexte wDonneesContexte = donneesContexte;

                if (wDonneesContexte.libelle! == "Escalier")
                  listContextesToggleSwitch.add("Nombre d'étages".toUpperCase());
                else if (wDonneesContexte.libelle! == "Marche")
                  listContextesToggleSwitch.add("Temps de marche".toUpperCase());
                else if (wDonneesContexte.libelle! == "Vélo")
                  listContextesToggleSwitch.add("Temps de Vélo".toUpperCase());
                else
                  listContextesToggleSwitch.add(wDonneesContexte.libelle!.toUpperCase());

                listContextesToggleSwitchVal.add(wDonneesContexte.code!);
                listContextesToggleSwitchWidget.add(Text(wDonneesContexte.libelle!));
                listContextesToggleSwitchbool.add(false);
                var wController = TextEditingController();
                wController.text = "0";
                listTEC_Context.add(wController);

                var wTF = wDonneesContexte.unite == null
                    ? Container(
                        height: 48,
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                        child: gColors.wTextFieldMesureContextV3(wController, "${wDonneesContexte.unite}", "${wDonneesContexte.libelle}", 0, wDonneesContexte.seuilMaxi!, "", "", _cardNumberFocus),
                      );

                listTF_Context.add(wTF);
              });
            }
          }
        }
      });
    }

    print(">>>> listContextesToggleSwitch ${listContextesToggleSwitch}");
    print(">>>> listContextesToggleSwitchVal ${listContextesToggleSwitchVal}");
    print(">>>> listContextesToggleSwitchbool ${listContextesToggleSwitchbool}");

    setState(() {});
  }

  Future<void> PrintData() async {
    Label_TextField lTF = listLabel_TextField[Page];
    if (lTF.listTF!.length > 0) {
      int i = 0;
      lTF.listTF!.forEach((tF) {
        var t = lTF.listTEC[i];
        var d = lTF.listDonnees[i];
        print("PrintData $i ${d.libelle} ${t.text}");
        i++;
      });
    }
  }

  PressSat() async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Saturation") {
        Page = i;
      }
      i++;
    });
    print("Sat ${Page}");
    await AffMessage("MA SATURATION", "bbb");

    await PrintData();
  }

  PressPouls1() async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Pouls") {
        Page = i;
      }
      i++;
    });

    print("Pouls1 ${Page}");
    await AffMessage("MON POULS 1", "bbb");
    print("Pouls1");
    await PrintData();
  }

  PressTension() async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Tension systolique") {
        Page = i;
      }
      i++;
    });

    print("Tension S ${Page}");
    await AffMessageTension();
    print("Tension S");
    await PrintData();
  }

  PressPouls2() {
    print("Pouls2");
  }

  PressPoids() async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Poids") {
        Page = i;
      }
      i++;
    });

    print("Poids ${Page}");
    await AffMessagePoids("MON POIDS", "bbb");

    print("Poids");
    await PrintData();
  }

/*
  PressTempsdesommeil() async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Temps de sommeil") {
        Page = i;
      }
      i++;
    });

    print("Temps de sommeil ${Page}");
    await AffMessage("Temps de sommeil", "bbb");

    print("Temps de sommeil");
    await PrintData();
  }
*/

  PressCont1() async {
    indContextTF = 1;
    print("PressCont ${indContextTF}");
    await AffMessageContext(listContextesToggleSwitch[indContextTF], "bbb");
    print("PressCont");
    await PrintData();
  }

  PressCont2() async {
    indContextTF = 2;
    print("PressCont ${indContextTF}");
    await AffMessageContext(listContextesToggleSwitch[indContextTF], "bbb");
    print("PressCont");
    await PrintData();
  }

  PressCont3() async {
    indContextTF = 3;
    print("PressCont ${indContextTF}");
    await AffMessageContext(listContextesToggleSwitch[indContextTF], "bbb");
    print("PressCont");
    await PrintData();
  }

  void initState() {
    wControllerTS1.text = "120";
    wControllerTS2.text = "120";
    wControllerTS3.text = "120";
    wControllerTD1.text = "80";
    wControllerTD2.text = "80";
    wControllerTD3.text = "80";
    wControllerP1.text = "80";
    wControllerP2.text = "80";
    wControllerP3.text = "80";

    wControllerS.text = "68";
    wControllerP.text = "69";
    wControllerK.text = "67";

    initLib();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("build ${Page} ${listBtnMenu.length} wControllerMoment ${gColors.wControllerMoment.text}");

    print("build validationTxt ${validationTxt} ${Page}");
    String tmpvalidationTxt = "";

    ResultLib.clear();
    ResultVal.clear();

    bool wP = false;
    listLabel_TextField.forEach((lTF) {
      int i = 0;

      lTF.listTF!.forEach((tF) {
        var d = lTF.listDonnees[i];
        var t = lTF.listTEC[i];

        if (t.text.isNotEmpty) {
          if (d.libelle!.contains("Pouls")) {
            if (!wP) {
              ResultLib.add(d.libelle!);
              ResultVal.add(t.text);
            }
            wP = true;
          } else {
            ResultLib.add(d.libelle!);
            ResultVal.add(t.text);
          }
        }
        i++;
      });
    });

//    List<String> ResultLib = [];
//    List<String> ResultVal = [];

    return (Page == 0 || Page < listBtnMenu.length)
        ? Container(
            padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
            color: gColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                gNewWidget.RoundedTitle(context, "MOMENT DU RELEVÉ"),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: CupertinoPickerContextStateful(
                    wControllerMoment: gColors.wControllerMoment,
                  ),
                ),
                Spacer(),
                listBtnMenu.length >= 1 ? listBtnMenu[0] : Container(),
                Spacer(),
                listBtnMenu.length >= 2 ? listBtnMenu[1] : Container(),
                Spacer(),
                listBtnMenu.length >= 3 ? listBtnMenu[2] : Container(),
                Spacer(),
                listBtnMenu.length >= 4 ? listBtnMenu[3] : Container(),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedButton(
                      Title: "Suivant",
                      backgroundColor: gColors.secondary,
                      onPressed: () async {
                        print("wControllerMoment ${gColors.wControllerMoment.text} ");

                        int p = 0;
                        listLabel_TextField.forEach((lTF) {
                          if (lTF.listTF!.length > 0) {
                            int i = 0;
                            lTF.listTF!.forEach((tF) {
                              var t = lTF.listTEC[i];
                              var d = lTF.listDonnees[i];
                              print("Suivant PageSommeil $p ${d.libelle} ${t.text}");
                              PageSommeil = p;
                              i++;
                            });
                          }
                          p++;
                        });
                        Page = listBtnMenu.length;
                        setState(() {});
                      },
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                  ],
                ),
                SizedBox(height: 8.0),
              ],
            ),
          )
        : Page == listBtnMenu.length
            ? Container(
                padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                color: gColors.white,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
                  gNewWidget.RoundedTitle(context, "MON EFFORT"),
                  Spacer(),
                  ContButton(
                    Img: "Cont1",
                    backgroundColor: gColors.primary,
                    onPressed: PressCont1,
                    width: 120,
                  ),
                  Spacer(),
                  ContButton(
                    Img: "Cont2",
                    backgroundColor: gColors.primary,
                    onPressed: PressCont2,
                    width: 120,
                  ),
                  Spacer(),
                  ContButton(
                    Img: "Cont3",
                    backgroundColor: gColors.primary,
                    onPressed: PressCont3,
                    width: 120,
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedButton(
                        Title: "Précédent",
                        backgroundColor: gColors.secondary,
                        onPressed: () async {
                          Page--;
                          setState(() {});
                        },
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      SizedBox(width: 8.0),
                      RoundedButton(
                        Title: "Suivant",
                        backgroundColor: gColors.secondary,
                        onPressed: () async {
                          listLabel_TextField.forEach((lTF) {
                            if (lTF.listTF!.length > 0) {
                              int i = 0;
                              lTF.listTF!.forEach((tF) {
                                var t = lTF.listTEC[i];
                                var d = lTF.listDonnees[i];
                                print("d ${d.libelle} ${t.text}");
                                i++;
                              });
                            }
                          });
                          Page++;
                          setState(() {});
                        },
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                ]),
              )
            : Page == listBtnMenu.length + 1
                ? Container(
                    color: gColors.white,
                    child: Column(children: <Widget>[
                      wListLTF2(PageSommeil - 1),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RoundedButton(
                            Title: "Précédent",
                            backgroundColor: gColors.secondary,
                            onPressed: () async {
                              Page--;
                              setState(() {});
                            },
                            width: MediaQuery.of(context).size.width / 2.5,
                          ),
                          SizedBox(width: 8.0),
                          RoundedButton(
                            Title: "Suivant",
                            backgroundColor: gColors.secondary,
                            onPressed: () async {
                              Page--;
                              Label_TextField lTF = listLabel_TextField[Page];

                              int cptSaide = 0;
                              if (lTF.listTF!.length > 0) {
                                int i = 0;
                                lTF.listTF!.forEach((tF) {
                                  var t = lTF.listTEC[i];

                                  if (t.text.length > 0) cptSaide++;
                                  print("t.text ${t.text}");

                                  i++;
                                });
                              }
                              print("cptSaide  ${cptSaide} ${lTF.listTF!.length} ");
                              if (cptSaide > 0 && cptSaide != lTF.listTF!.length) {
                                Error = "Toutes les valeurs doivent être Saisies";
                                Page++;
                                setState(() {});
                                return;
                              }
                              validationTxt += " <div><Center><table>";

                              Page++;

                              if (listLabel_TextField.length > 0 && Page <= listLabel_TextField.length) {
                                int cptSaide = 0;

                                int wPage = 0;
                                bool add = false;
                                listLabel_TextField.forEach((lTF) {
                                  if (lTF.listTF!.length > 0) {
                                    wPage++;
                                    int i = 0;
                                    lTF.listTF!.forEach((tF) {
                                      var t = lTF.listTEC[i];
                                      var d = lTF.listDonnees[i];

                                      if (d.libelle!.contains("Qualité du sommeil")) d.unite = " / 10";

                                      String wColor = ' style="color: black;"';

                                      String wText = "";
                                      if (d.libelle!.contains("Temps de sommeil")) {
                                        int w = int.parse(t.text);
                                        Duration duration = Duration(hours: 0, minutes: w);
                                        wText = "${duration.inHours}h${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}";
                                        cptSaide++;
                                        tmpvalidationTxt += '<tr><td><h1>${d.libelle}</h1></td><td><h2><p style="text-align: right;"><span $wColor>${wText}</span></p></h2></td></tr>';
                                        print("tmpvalidationTxt ${tmpvalidationTxt}");

                                        add = true;
                                      }
//                                      else if (t.text.length > 0)
                                      else if (d.libelle!.contains("Qualité du sommeil")) {
                                        cptSaide++;

                                        if (d.seuilMaxi == 99) wColor = ' style="color: red;"';
                                        if (d.seuilMaxi == 260) wColor = ' style="color: orange;"';
                                        if (d.seuilMaxi == 199) wColor = ' style="color: green;"';

                                        tmpvalidationTxt += '<tr><td><h1>${d.libelle}</h1></td><td><h2><p style="text-align: right;"><span $wColor>${t.text} ${d.unite}</span></p></h2></td></tr>';
                                        print("tmpvalidationTxt ${tmpvalidationTxt}");

                                        add = true;
                                      }

                                      i++;
                                    });
                                  }
                                });

                                print("cptSaide  ${cptSaide} ");
                                if (cptSaide == 0) {
//                  Error = "Aucune saisie à enregistrer!";
                                  validationTxt += "<h2>Aucune saisie à enregistrer!</h2>";
                                }
                              }
                              validationTxt += tmpvalidationTxt;
                              validationTxt += "</table></Center></div>";
                              print("validationTxt  ${validationTxt} ");

                              Page++;
                              setState(() {});
                            },
                            width: MediaQuery.of(context).size.width / 2.5,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                    ]),
                  )
                : Page == listBtnMenu.length + 2
                    ? Container(
                        color: gColors.white,
                        child: Column(children: <Widget>[
                          wListLTF2(PageSommeil),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RoundedButton(
                                Title: "Précédent",
                                backgroundColor: gColors.secondary,
                                onPressed: () async {
                                  Page--;
                                  setState(() {});
                                },
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                              SizedBox(width: 8.0),
                              RoundedButton(
                                Title: "Suivant",
                                backgroundColor: gColors.secondary,
                                onPressed: () async {
                                  Page--;
                                  Label_TextField lTF = listLabel_TextField[Page];

                                  int cptSaide = 0;
                                  if (lTF.listTF!.length > 0) {
                                    int i = 0;
                                    lTF.listTF!.forEach((tF) {
                                      var t = lTF.listTEC[i];

                                      if (t.text.length > 0) cptSaide++;
                                      print("t.text ${t.text}");

                                      i++;
                                    });
                                  }
                                  print("cptSaide  ${cptSaide} ${lTF.listTF!.length} ");
                                  if (cptSaide > 0 && cptSaide != lTF.listTF!.length) {
                                    Error = "Toutes les valeurs doivent être Saisies";
                                    Page++;
                                    setState(() {});
                                    return;
                                  }
                                  validationTxt += " <div><Center><table>";
                                  String tmpvalidationTxt = "";

                                  Page++;

                                  if (listLabel_TextField.length > 0 && Page <= listLabel_TextField.length) {
                                    int cptSaide = 0;

                                    int wPage = 0;
                                    bool add = false;
                                    listLabel_TextField.forEach((lTF) {
                                      if (lTF.listTF!.length > 0) {
                                        wPage++;
                                        int i = 0;
                                        lTF.listTF!.forEach((tF) {
                                          var t = lTF.listTEC[i];
                                          var d = lTF.listDonnees[i];

                                          String wColor = ' style="color: black;"';

                                          String wText = "";
                                          if (d.libelle!.contains("réveils")) {
                                            int w = int.parse(t.text);
                                            Duration duration = Duration(hours: 0, minutes: w);
                                            wText = "${duration.inHours}h${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}";
                                            cptSaide++;
                                            //      tmpvalidationTxt += '<tr><td><h1>${d.libelle}</h1></td><td><h2><p style="text-align: right;"><span $wColor>${wText}</span></p></h2></td></tr>';
                                            print("tmpvalidationTxt ${tmpvalidationTxt}");

                                            add = true;
                                          }
//                                      else if (t.text.length > 0)
                                          else if (d.libelle!.contains("insomnie")) {
                                            cptSaide++;

                                            if (d.seuilMaxi == 99) wColor = ' style="color: red;"';
                                            if (d.seuilMaxi == 260) wColor = ' style="color: orange;"';
                                            if (d.seuilMaxi == 199) wColor = ' style="color: green;"';

                                            //  tmpvalidationTxt += '<tr><td><h1>${d.libelle}</h1></td><td><h2><p style="text-align: right;"><span $wColor>${t.text} ${d.unite}</span></p></h2></td></tr>';
                                            print("tmpvalidationTxt ${tmpvalidationTxt}");

//                              '<tr><td><h1>${d.libelle}</h1></td><td><h2><p style="text-align: right;"><span $wColor>${t.text} ${d.unite}<span></p><h2></td></tr>';

                                            add = true;
                                          }

                                          i++;
                                        });
                                      }
                                    });

                                    print("cptSaide  ${cptSaide} ");
                                    if (cptSaide == 0) {
//                  Error = "Aucune saisie à enregistrer!";
                                      validationTxt += "<h2>Aucune saisie à enregistrer!</h2>";
                                    }
                                  }
                                  validationTxt += tmpvalidationTxt;

                                  validationTxt += "</table></Center></div>";

                                  Page++;
                                  setState(() {});
                                },
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                        ]),
                      )
                    : Container(
                        padding: EdgeInsets.fromLTRB(8, 20, 8, 8),
                        color: gColors.white,
                        child: Column(children: <Widget>[
                          gNewWidget.RoundedTitle(context, "MES RÉSULTATS"),
                          SizedBox(height: 8.0),
                          SingleChildScrollView(
                            child: Container(
//                          color: Colors.pink,
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),

                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: ResultLib.length,
                                itemBuilder: (context, index) {
                                  final resultLib = ResultLib[index];
                                  final resultVal = ResultVal[index];

                                  return ListTile(
                                    dense: true,
                                    onTap: () {},
                                    title: Row(
                                      children: [
                                        Text(
                                          "${resultLib.replaceAll("Nombre de réveils", "Nombre d’éveils").replaceAll("Durée d'insomnie", "Durée de l’éveil")}",
                                          style: gColors.bodySaisie_B_P,
                                        ),
                                        Spacer(),
                                        Text(
                                          "${resultVal}",
                                          style: gColors.bodyTitle1_B_Sr,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),


                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              RoundedButton(
                                Title: "Précédent",
                                backgroundColor: gColors.secondary,
                                onPressed: () async {
                                  Page--;
                                  setState(() {});
                                },
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                              SizedBox(width: 8.0),
                              RoundedButton(
                                Title: "Valider",
                                backgroundColor: gColors.secondary,
                                onPressed: () async {
                                  String formattedDate = DateFormat('yyyy-MM-dd kk:mm:ss').format(now);
                                  List<DonneesSet> listDonneesSet = [];

                                  bool Alerte = false;

                                  listLabel_TextField.forEach((lTF) {
                                    int i = 0;

                                    // seuil
                                    print("lTF.listTF ${lTF.listTF!.length} lTF.listDonnees ${lTF.listDonnees.length} lTF.listTEC ${lTF.listTEC.length}");

                                    lTF.listTF!.forEach((tF) {
                                      var d = lTF.listDonnees[i];
                                      var t = lTF.listTEC[i];

                                      print("d ${d.code} ${t.text} ${d.medObj}");
                                      bool donnee_en_alerte = false;
                                      i++;
                                      if (t.text.length > 0) {
                                        int valeurDonnee = int.parse(t.text);
                                        if (d.code!.contains("tension")) {
                                          if (valeurDonnee < int.parse(d.medMini)) {
                                            Alerte = true;
                                            donnee_en_alerte = true;
                                          }
                                          if (valeurDonnee > int.parse(d.medMaxi)) {
                                            Alerte = true;
                                            donnee_en_alerte = true;
                                          }
                                        }

                                        if (d.code!.contains("saturation")) {
                                          if (valeurDonnee < int.parse(d.medMini)) {
                                            Alerte = true;
                                            donnee_en_alerte = true;
                                          }
                                        }

                                        DonneesSet WDonneesSet =
                                            DonneesSet(date: formattedDate, familleAppareil: lTF.familleAppareil, codeAppareil: lTF.codeAppareil, codeDonnee: d.code, valeurDonnee: t.text, seuilMiniDonnee: "${d.seuilMini}", seuilMaxiDonnee: "${d.seuilMaxi}", codeContexte: d.contexte, donneeContexte: listContextesToggleSwitchVal[indContextTF], valeurContexte: listTEC_Context[indContextTF].text, codeContexteSecondaire: "moment", donneeContexteSecondaire: "moment", valeurContexteSecondaire: "${gColors.wControllerMoment.text}", donnee_en_alerte: donnee_en_alerte);
                                        print("lTF.familleAppareil ${lTF.familleAppareil}");
                                        print("WDonneesSet ${WDonneesSet.toJson()}");
                                        listDonneesSet.add(WDonneesSet);
                                      }
                                    });
                                  });

                                  if (listDonneesSet.length > 0) {
                                    if (await DbTools.ApiSrv_patient_setdonnees(DbTools.gApiID, DbTools.gApiPassword, listDonneesSet)) {}
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("Données Envoyées"),
                                    ));

                                    if (Alerte) await AffMessageInfo("Données en alerte", "Vous avez des données qui semblent ne pas être dans la norme. Veuillez contacter ou prendre rendez-vous avec votre médecin");
                                  }
                                  Page = 0;
                                  await initLib();
                                  setState(() {});
                                },
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                        ]),
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

  Future<void> AffMessage(String title, String body) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Text(
                "${title}",
                style: gColors.bodyTitle_B_P,
                textAlign: TextAlign.center,
              ),
              content: Container(
                //              width : MediaQuery.of(context).size.width ,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(),
                      listLabel_TextField.length == 0
                          ? Container()
                          : Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0), // TED
                              child: wListLTF(Page)),
                    ],
                  ),
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
                        backgroundColor: Colors.white,
                        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: Icon(
                        Icons.check,
                        color: gColors.secondary,
                        size: 50,
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

  Future<void> AffMessagePoids(String title, String body) async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Poids") {
        Page = i;
      }
      i++;
    });

    print("listLabel_TextField $Page ${listLabel_TextField.length}");

    var lTFS = listLabel_TextField[Page];
    print("lTF $Page ${lTFS.sLabel}");
    var dS = Donnees();

    if (lTFS.listTF!.length > 0) {
      int i = 0;
      lTFS.listTF!.forEach((tF) {
        wControllerK = lTFS.listTEC[i];
        dS = lTFS.listDonnees[i];
        print("dS ${dS.libelle} ${dS.seuilMini} ${dS.seuilMaxi} ${dS.derniereValeur} ${wControllerK.text}");
        print("dS ${(dS.derniereValeur! != "") ? double.parse(dS.derniereValeur!).toInt() : 0} ");

        wControllerK.text = "${(dS.derniereValeur! != "") ? double.parse(dS.derniereValeur!).toInt() : 0} ";

        i++;
      });
    }

    void _updateK(int val) {
      wControllerK.text = "${val + dS.seuilMini!.toInt()}";
      print("_updateS wControllerS.text");

      _setState(() {});
    }

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Text(
                "${title}",
                style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                textAlign: TextAlign.center,
              ),
              content: Container(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        listLabel_TextField.length == 0
                            ? Container()
                            : Container(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0), // TED
                                child: CupertinoPickerStatefulTension(
                                    aController: wControllerS,
                                    amin: dS.seuilMini == null ? 0 : dS.seuilMini!,
                                    amax: dS.seuilMaxi == null ? 0 : dS.seuilMaxi!,
                                    aprec: dS.derniereValeur == null
                                        ? 0
                                        : (dS.derniereValeur! != "")
                                            ? double.parse(dS.derniereValeur!).toInt()
                                            : 0,
                                    ahintText: "Kg",
                                    update: _updateK),
                              )

//                      wListLTF(Page)),
                      ],
                    ),
                  ),
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
                        backgroundColor: Colors.white,
                        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: Icon(
                        Icons.check,
                        color: gColors.secondary,
                        size: 50,
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

  Future<void> AffMessageSat() async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Saturation") {
        Page = i;
      }
      i++;
    });

    print("listLabel_TextField $Page ${listLabel_TextField.length}");

    var lTFS = listLabel_TextField[Page];
    print("lTF $Page ${lTFS.sLabel}");
    var dS = Donnees();

    var wControllerS1 = TextEditingController();
    if (lTFS.listTF!.length > 0) {
      int i = 0;
      lTFS.listTF!.forEach((tF) {
        wControllerS = lTFS.listTEC[i];
        dS = lTFS.listDonnees[i];
        print("dS ${dS.libelle} ${dS.seuilMini} ${dS.seuilMaxi} ${dS.derniereValeur} ${wControllerS.text}");
        print("dS ${(dS.derniereValeur! != "") ? double.parse(dS.derniereValeur!).toInt() : 0} ");
        wControllerS.text = "${(dS.derniereValeur! != "") ? double.parse(dS.derniereValeur!).toInt() : 0} ";
        i++;
      });
    }

    i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Pouls") {
        Page = i;
      }
      i++;
    });

    var lTFP = listLabel_TextField[Page];
    print("lTF $Page ${lTFP.sLabel}");
    var dP = Donnees();

    var wControllerP1 = TextEditingController();
    if (lTFS.listTF!.length > 0) {
      int i = 0;
      lTFP.listTF!.forEach((tF) {
        wControllerP = lTFP.listTEC[i];
        dP = lTFP.listDonnees[i];
        print("dP ${dP.libelle} ${dP.seuilMini} ${dP.seuilMaxi} ${dP.derniereValeur} ${wControllerP.text}");
        print("dP ${(dP.derniereValeur! != "") ? double.parse(dP.derniereValeur!).toInt() : 0} ");

        wControllerP.text = "${(dP.derniereValeur! != "") ? double.parse(dP.derniereValeur!).toInt() : 0} ";

        i++;
      });
    }

    void _updateS(int val) {
      wControllerS.text = "${val + dS.seuilMini!.toInt()}";
      print("_updateS wControllerS.text");

      _setState(() {});
    }

    void _updateP(int val) {
      wControllerP.text = "${val + dP.seuilMini!.toInt()}";
      print("_updateP wControllerP.text");

      _setState(() {});
    }

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Container(
                //              width : MediaQuery.of(context).size.width ,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 20,
                      ),
                      Text(
                        "Ma saturation".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerS,
                          amin: dS.seuilMini == null ? 0 : dS.seuilMini!,
                          amax: dS.seuilMaxi == null ? 0 : dS.seuilMaxi!,
                          aprec: dS.derniereValeur == null
                              ? 0
                              : (dS.derniereValeur! != "")
                                  ? double.parse(dS.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "%",
                          update: _updateS),
                      Text(
                        "Mon pouls".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerP,
                          amin: dP.seuilMini == null ? 0 : dP.seuilMini!,
                          amax: dP.seuilMaxi == null ? 0 : dP.seuilMaxi!,
                          aprec: dP.derniereValeur == null
                              ? 0
                              : (dP.derniereValeur! != "")
                                  ? double.parse(dP.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "Bpm",
                          update: _updateP),
                    ],
                  ),
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
                        backgroundColor: Colors.white,
                        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: Icon(
                        Icons.check,
                        color: gColors.secondary,
                        size: 50,
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

  late StateSetter _setState;

  Future<void> AffMessageTension() async {
    int i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Tension systolique") {
        Page = i;
      }
      i++;
    });

    var lTFTS1 = listLabel_TextField[Page];
    print("lTF $Page ${lTFTS1.sLabel}");
    var dTS = Donnees();

    var wControllerTS = TextEditingController();
    if (lTFTS1.listTF!.length > 0) {
      int i = 0;
      lTFTS1.listTF!.forEach((tF) {
        wControllerTS = lTFTS1.listTEC[i];
        dTS = lTFTS1.listDonnees[i];
        print("dTS ${dTS.libelle} ${dTS.seuilMini} ${dTS.seuilMaxi} ${dTS.derniereValeur} ${wControllerTS.text}");
        print("dTS ${(dTS.derniereValeur! != "") ? double.parse(dTS.derniereValeur!).toInt() : 0} ");

        wControllerTS1.text = "${(dTS.derniereValeur! != "") ? double.parse(dTS.derniereValeur!).toInt() : 0} ";
        wControllerTS2.text = "${(dTS.derniereValeur! != "") ? double.parse(dTS.derniereValeur!).toInt() : 0} ";
        wControllerTS3.text = "${(dTS.derniereValeur! != "") ? double.parse(dTS.derniereValeur!).toInt() : 0} ";

        i++;
      });
    }

    i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Tension diastolique") {
        Page = i;
      }
      i++;
    });

    var lTFTS2 = listLabel_TextField[Page];
    print("lTF $Page ${lTFTS2.sLabel}");
    var dTD = Donnees();
    var wControllerTD = TextEditingController();

    if (lTFTS2.listTF!.length > 0) {
      int i = 0;
      lTFTS2.listTF!.forEach((tF) {
        wControllerTD = lTFTS2.listTEC[i];
        dTD = lTFTS2.listDonnees[i];
        print("dTD ${dTD.libelle} ${dTD.seuilMini} ${dTD.seuilMaxi} ${dTD.derniereValeur} ${wControllerTD.text}");
        print("dTD ${(dTD.derniereValeur! != "") ? double.parse(dTD.derniereValeur!).toInt() : 0} ");

        wControllerTD1.text = "${(dTD.derniereValeur! != "") ? double.parse(dTD.derniereValeur!).toInt() : 0} ";
        wControllerTD2.text = "${(dTD.derniereValeur! != "") ? double.parse(dTD.derniereValeur!).toInt() : 0} ";
        wControllerTD3.text = "${(dTD.derniereValeur! != "") ? double.parse(dTD.derniereValeur!).toInt() : 0} ";

        i++;
      });
    }

    i = 0;
    sBtnMenuData.forEach((item) {
      if (item == "Pouls2") {
        Page = i;
      }
      i++;
    });

    var lTFTS3 = listLabel_TextField[Page];
    print("lTF ${lTFTS3.sLabel}");
    var dP = Donnees();
    var wControllerP = TextEditingController();

    if (lTFTS3.listTF!.length > 0) {
      int i = 0;
      lTFTS3.listTF!.forEach((tF) {
        wControllerP = lTFTS3.listTEC[i];
        dP = lTFTS3.listDonnees[i];
        print("dP ${dP.libelle} ${dP.seuilMini} ${dP.seuilMaxi} ${dP.derniereValeur} ${wControllerP.text}");
        print("dP ${(dP.derniereValeur! != "") ? double.parse(dP.derniereValeur!).toInt() : 0} ");

        wControllerP1.text = "${(dP.derniereValeur! != "") ? double.parse(dP.derniereValeur!).toInt() : 0} ";
        wControllerP2.text = "${(dP.derniereValeur! != "") ? double.parse(dP.derniereValeur!).toInt() : 0} ";
        wControllerP3.text = "${(dP.derniereValeur! != "") ? double.parse(dP.derniereValeur!).toInt() : 0} ";

        i++;
      });
    }

    void CalculM() {
      print("CalculM()");

      int TS1 = int.parse(wControllerTS1.text);
      int TS2 = int.parse(wControllerTS2.text);
      int TS3 = int.parse(wControllerTS3.text);
      int TST = TS1 + TS2 + TS3;
      double TSM = TST / 3;

      wControllerTS.text = "${TSM.toInt()}";

      int TD1 = int.parse(wControllerTD1.text);
      int TD2 = int.parse(wControllerTD2.text);
      int TD3 = int.parse(wControllerTD3.text);
      int TDT = TD1 + TD2 + TD3;
      double TDM = TDT / 3;
      wControllerTD.text = "${TDM.toInt()}";

      int P1 = int.parse(wControllerP1.text);
      int P2 = int.parse(wControllerP2.text);
      int P3 = int.parse(wControllerP3.text);

      int PT = P1 + P2 + P3;
      double PM = PT / 3;
      wControllerP.text = "${PM.toInt()}";

      print("CalculM() $P1 $P2 $P3 ${wControllerP.text}");
    }

    void _updateTS1(int val) {
      wControllerTS1.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateTS2(int val) {
      wControllerTS2.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateTS3(int val) {
      wControllerTS3.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateTD1(int val) {
      wControllerTD1.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateTD2(int val) {
      wControllerTD2.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateTD3(int val) {
      wControllerTD3.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateP1(int val) {
      wControllerP1.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateP2(int val) {
      wControllerP2.text = "$val";
      CalculM();
      _setState(() {});
    }

    void _updateP3(int val) {
      wControllerP3.text = "$val";
      CalculM();
      _setState(() {});
    }

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          print("CalculM() Alert ${wControllerP.text}");
          return StatefulBuilder(builder: (context, setState) {
            _setState = setState;
            CalculM();
            return AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              content: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0), //apply padding to all four sides
                        child: Text(
                          "Repos de 3 à 5 minutes avant la prise de votre tension".toUpperCase(),
                          style: gColors.bodySaisie_B_P20.copyWith(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "PRISE 1",
                        style: gColors.bodyTitle1_B_P,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "Ma tension systolique".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerTS1,
                          amin: dTS.seuilMini == null ? 0 : dTS.seuilMini!,
                          amax: dTS.seuilMaxi == null ? 0 : dTS.seuilMaxi!,
                          aprec: dTS.derniereValeur == null
                              ? 0
                              : (dTS.derniereValeur! != "")
                                  ? double.parse(dTS.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "mmHg",
                          update: _updateTS1),
                      Text(
                        "Ma tension diastolique".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerTD1,
                          amin: dTD.seuilMini == null ? 0 : dTD.seuilMini!,
                          amax: dTD.seuilMaxi == null ? 0 : dTD.seuilMaxi!,
                          aprec: dTD.derniereValeur == null
                              ? 0
                              : (dTD.derniereValeur! != "")
                                  ? double.parse(dTD.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "mmHg",
                          update: _updateTD1),
                      Text(
                        "Mon pouls".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerP1,
                          amin: dP.seuilMini == null ? 0 : dP.seuilMini!,
                          amax: dP.seuilMaxi == null ? 0 : dP.seuilMaxi!,
                          aprec: dP.derniereValeur == null
                              ? 0
                              : (dP.derniereValeur! != "")
                                  ? double.parse(dP.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "Bpm",
                          update: _updateP1),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "RESPECTER 1 MINUTE D’ATTENTE",
                        style: gColors.bodyTitle_B_P.copyWith(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "PRISE 2",
                        style: gColors.bodyTitle1_B_P,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "Ma tension systolique".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerTS2,
                          amin: dTS.seuilMini == null ? 0 : dTS.seuilMini!,
                          amax: dTS.seuilMaxi == null ? 0 : dTS.seuilMaxi!,
                          aprec: dTS.derniereValeur == null
                              ? 0
                              : (dTS.derniereValeur! != "")
                                  ? double.parse(dTS.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "mmHg",
                          update: _updateTS2),
                      Text(
                        "Ma tension diastolique".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerTD2,
                          amin: dTD.seuilMini == null ? 0 : dTD.seuilMini!,
                          amax: dTD.seuilMaxi == null ? 0 : dTD.seuilMaxi!,
                          aprec: dTD.derniereValeur == null
                              ? 0
                              : (dTD.derniereValeur! != "")
                                  ? double.parse(dTD.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "mmHg",
                          update: _updateTD2),
                      Text(
                        "Mon pouls".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerP2,
                          amin: dP.seuilMini == null ? 0 : dP.seuilMini!,
                          amax: dP.seuilMaxi == null ? 0 : dP.seuilMaxi!,
                          aprec: dP.derniereValeur == null
                              ? 0
                              : (dP.derniereValeur! != "")
                                  ? double.parse(dP.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "Bpm",
                          update: _updateP2),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "RESPECTER 1 MINUTE D’ATTENTE",
                        style: gColors.bodyTitle_B_P.copyWith(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "PRISE 3",
                        style: gColors.bodyTitle1_B_P,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "Ma tension systolique".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerTS3,
                          amin: dTS.seuilMini == null ? 0 : dTS.seuilMini!,
                          amax: dTS.seuilMaxi == null ? 0 : dTS.seuilMaxi!,
                          aprec: dTS.derniereValeur == null
                              ? 0
                              : (dTS.derniereValeur! != "")
                                  ? double.parse(dTS.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "mmHg",
                          update: _updateTS3),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "Ma tension diastolique".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerTD3,
                          amin: dTD.seuilMini == null ? 0 : dTD.seuilMini!,
                          amax: dTD.seuilMaxi == null ? 0 : dTD.seuilMaxi!,
                          aprec: dTD.derniereValeur == null
                              ? 0
                              : (dTD.derniereValeur! != "")
                                  ? double.parse(dTD.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "mmHg",
                          update: _updateTD3),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "Mon pouls".toUpperCase(),
                        style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                        textAlign: TextAlign.center,
                      ),
                      CupertinoPickerStatefulTension(
                          aController: wControllerP3,
                          amin: dP.seuilMini == null ? 0 : dP.seuilMini!,
                          amax: dP.seuilMaxi == null ? 0 : dP.seuilMaxi!,
                          aprec: dP.derniereValeur == null
                              ? 0
                              : (dP.derniereValeur! != "")
                                  ? double.parse(dP.derniereValeur!).toInt()
                                  : 0,
                          ahintText: "Bpm",
                          update: _updateP3),
                      Container(
                        height: 50,
                      ),
                      Text(
                        "Ma tension systolique moyenne\n${wControllerTS.text}".toUpperCase() + " mmHg",
                        style: gColors.bodyText_S_B,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Ma tension diastolique moyenne\n${wControllerTD.text}".toUpperCase() + " mmHg",
                        style: gColors.bodyText_S_B,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Ma tension pouls moyen\n${wControllerP.text}".toUpperCase() + " Bmp",
                        style: gColors.bodyText_S_B,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        height: 50,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          alignment: Alignment.center,
                          backgroundColor: Colors.white,
                          //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        ),
                        child: Icon(
                          Icons.check,
                          color: gColors.secondary,
                          size: 50,
                        ),
                        onPressed: () async {
                          CalculM();
                          setState(() {
                            print("CalculM() set State ${wControllerP.text}");
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  Future<void> AffMessageContext(String title, String body) async {
    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
              insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: Text(
                "${title}",
                style: gColors.bodySaisie_B_P,
                textAlign: TextAlign.center,
              ),
              content: Container(
                  child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    listLabel_TextField.length == 0 ? Container() : Container(child: wContexte()),
                  ],
                ),
              )),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        alignment: Alignment.center,
                        backgroundColor: Colors.white,
                        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      ),
                      child: Icon(
                        Icons.check,
                        color: gColors.secondary,
                        size: 50,
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

  Widget wListTF(List<Widget> alistTF) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: alistTF.length,
      itemBuilder: (context, index) {
        final item = alistTF[index];

        print("item ${item}");

        return ListTile(
          onTap: () {},
//          dense: true,
          contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          title: item,
        );
      },
    );
  }

  Widget wListLTF(int aPage) {
    print("wListLTF page ${aPage}");
    return Container(
//        color: Colors.green,
        width: 300,
        height: 180,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: listLabel_TextField.length + 1,
          itemBuilder: (context, index) {
            if (aPage != index)
              return Container();
            else {
              if (index == listLabel_TextField.length) index--;
              final item = listLabel_TextField[index];

              print("item ${item.sLabel}");

              return ListTile(
                contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
                onTap: () {},
                dense: true,
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                subtitle: wListTF(item.listTF!),
              );
            }
          },
        ));
  }

  Widget wListLTF2(int aPage) {
    print("SOMMEIL page ${aPage}");

    return Container(
        child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listLabel_TextField.length + 1,
      itemBuilder: (context, index) {
        if (aPage != index)
          return Container();
        else {
          if (index == listLabel_TextField.length) index--;
          final item = listLabel_TextField[index];

          print("LABEL ${item.sLabel} ${listLabel_TextField.length}");

          return ListTile(
            contentPadding: EdgeInsets.only(left: 8.0, right: 8.0),
            onTap: () {},
            dense: true,
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            subtitle: wListTF(item.listTF!),
          );
        }
      },
    ));
  }

  Widget wContexte() {
    return Container(
      child: Column(
        children: <Widget>[
          listContextesToggleSwitch.length == 0
              ? Container()
              : indContextTF > 0
                  ? Container()
                  : Container(
                      child: BtnSwitch(),
                    ),
          SizedBox(
            height: 8,
          ),
          listContextesToggleSwitch.length == 0
              ? Container()
              : indContextTF == 0
                  ? Container()
                  : listTF_Context[indContextTF],
        ],
      ),
    );
  }

  Widget BtnSwitch() {
    return Container(
        child: Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                indContextTF = 1;
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gColors.secondary,
                padding: const EdgeInsets.all(12),
              ),
              child: Text(listContextesToggleSwitch[1].toUpperCase(), style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            )),
        Container(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                indContextTF = 2;
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gColors.secondary,
                padding: const EdgeInsets.all(12),
              ),
              child: Text(listContextesToggleSwitch[2].toUpperCase(), style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            )),
        Container(
          height: 10,
        ),
        Container(
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
              onPressed: () async {
                indContextTF = 3;
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: gColors.secondary,
                padding: const EdgeInsets.all(12),
              ),
              child: Text("Etages".toUpperCase(), style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
            )),
      ],
    ));
  }
}
