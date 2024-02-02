import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/LaunchUrl.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/gNewWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class P_Notifications extends StatefulWidget {
  @override
  P_NotificationsState createState() => P_NotificationsState();
}

class P_NotificationsState extends State<P_Notifications> {
  TextEditingController sujetController = TextEditingController();
  TextEditingController contController = TextEditingController();
  String Error = "";
  void initLib() async {}

  void initState() {
    initLib();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print("build");
    print("Tel Technicien ${DbTools.api_Patient_Contact.telephoneTechnicien} ${DbTools.api_Patient_Contact.telephoneTechnicien!.isEmpty}");

    return Container(
      padding: EdgeInsets.all(8),
      color: gColors.white,
      child: Column(
        children: <Widget>[
          SizedBox(height: 8.0),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await MailDialog();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: gColors.secondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                    border: Border.all(
                      color: gColors.secondary,
                    ),
                  ),
                  width: 120,
                  height: 120,
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/imail.png'),
                      height: 110,
                    ),
                  ),
                ),
              ),
              Container(width: 20),
              GestureDetector(
                onTap: () async {
                  if (!DbTools.api_Patient_Contact.telephoneAgence!.isEmpty) {
                    print("Tel Agence ${DbTools.api_Patient_Contact.telephoneAgence}");
                    launchPhoneDialer(DbTools.api_Patient_Contact.telephoneAgence!);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: (DbTools.api_Patient_Contact.telephoneAgence!.isEmpty) ? Colors.black26 : gColors.secondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                    border: Border.all(
                      color: (DbTools.api_Patient_Contact.telephoneAgence!.isEmpty) ? Colors.black26 : gColors.secondary,
                    ),
                  ),
                  width: 120,
                  height: 120,
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/iagence.png'),
                      height: 110,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  if (!DbTools.api_Patient_Contact.telephoneTechnicien!.isEmpty) {
                    print("Tel Tech ${DbTools.api_Patient_Contact.telephoneTechnicien}");
                    launchPhoneDialer(DbTools.api_Patient_Contact.telephoneTechnicien!);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: (DbTools.api_Patient_Contact.telephoneTechnicien!.isEmpty) ? Colors.black26 : gColors.secondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                    border: Border.all(
                      color: (DbTools.api_Patient_Contact.telephoneTechnicien!.isEmpty) ? Colors.black26 : gColors.secondary,
                    ),
                  ),
                  width: 120,
                  height: 120,
                  child: Center(
                    child: Image(
                      image: AssetImage(
                        'assets/images/itechni.png',
                      ),
                      height: 110,
                    ),
                  ),
                ),
              ),
              Container(width: 20),
              GestureDetector(
                onTap: () async {
                  if (!DbTools.api_Patient_Contact.telephonePharmacien!.isEmpty) {
                    print("Tel Ph ${DbTools.api_Patient_Contact.telephonePharmacien}");
                    launchPhoneDialer(DbTools.api_Patient_Contact.telephonePharmacien!);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: (DbTools.api_Patient_Contact.telephonePharmacien!.isEmpty) ? Colors.black26 : gColors.secondary,
                    borderRadius: BorderRadius.all(
                      Radius.circular(24.0),
                    ),
                    border: Border.all(
                      color: (DbTools.api_Patient_Contact.telephonePharmacien!.isEmpty) ? Colors.black26 : gColors.secondary,
                    ),
                  ),
                  width: 120,
                  height: 120,
                  child: Center(
                    child: Image(
                      image: AssetImage('assets/images/ipharma.png'),
                      height: 110,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),



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


  Future<void> MailDialog() async {
    print("Error $Error");
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Dialog(
            insetPadding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
            child: Container(
              height: 430,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Text(
                          "Contacter epione santé".toUpperCase(),
                          style: gColors.bodySaisie_B_P20.copyWith(color: gColors.secondary),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: TextFormField(
                        controller: sujetController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Sujet",
                        ),
                      )),
                  Container(
                    height: 200,
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child:  TextFormField(
                        controller: contController,
                        maxLines: 10,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Message",
                        ),
                      ),
                    ),

                  Text(Error, style: gColors.bodyText_B_R),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RoundedButton(
                        Title: "Annuler",
                        backgroundColor: gColors.secondary,
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      SizedBox(width: 8.0),
                      RoundedButton(
                        Title: "Envoyer",
                        backgroundColor: gColors.secondary,
                        onPressed: () async {
                          String wSujet = "${sujetController.text}";
                          String wCont = "${contController.text}";

                          if (wSujet.isEmpty || wCont.isEmpty) {
                            Error = "Sujet ou message vide";
                            setState(() {});
                          } else {
                            await DbTools.ApiSrv_User_sendMail(DbTools.gApiID, DbTools.gApiPassword, wSujet, wCont, "");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("votre mail a bien été envoyée"),
                            ));
                            Navigator.pop(context);

                          }
                        },
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
