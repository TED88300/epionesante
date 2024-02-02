import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/LaunchUrl.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/gNewWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class P_Contact extends StatefulWidget {
  @override
  P_ContactState createState() => P_ContactState();
}

class P_ContactState extends State<P_Contact> {
  TextEditingController sujetController = TextEditingController();
  TextEditingController contController = TextEditingController();
  String Error = "";
  void initLib() async {}

  void initState() {
    initLib();
    gColors.RetMailDem = "demande_administrative";

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

            ],
          ),

          Spacer(),

          RichText(
            text: TextSpan(
                text: 'Consultez notre politique de confidentialité en cliquant ',
                style: const TextStyle(
                  color: Colors.black,
                ),
                children:  <TextSpan>[
                  TextSpan(
                    text: "ici",
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _launchUrl();                      },
                    style: const TextStyle(
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ]),
          ),

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


  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://epioneweb.fr/epione/public/fr/politique-confidentialite-patient-epione-mobile');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> MailDialog() async {
    print("Error $Error");
    return showDialog(

      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return SimpleDialog(
//            insetPadding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            insetPadding: EdgeInsets.zero,
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,            children: [

             Container(
              height: 485,
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child:
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: CupertinoPickerMailStateful(
                          wControllerMail: sujetController,
                        ),
                      ),

                  ),



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
                          String wSujet = gColors.RetMailDem;// "${sujetController.text}";
                          String wCont = "${contController.text}";

                          if (wSujet.isEmpty || wCont.isEmpty) {
                            Error = "Sujet ou message vide";
                            setState(() {});
                          } else {


                            print("wSujet $wSujet");
                            await DbTools.ApiSrv_Patient_sendMail(DbTools.gApiID, DbTools.gApiPassword, wSujet, wCont);
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
            ],

          );
        });
      },
    );
  }
}
