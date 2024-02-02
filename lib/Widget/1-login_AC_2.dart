import 'package:epionesante/Tools/gNewWidget.dart';
import 'package:epionesante/Widget/1-login.dart';
import 'package:epionesante/Widget/Patient/P_IntroMes.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/shared_pref.dart';
import 'package:url_launcher/url_launcher.dart';

enum LoginError { PENDING, EMAIL_VALIDATE, WAITING_CONFIRMATION, DISABLE, ERROR_USER_NOT_FOUND, WRONG_PASSWORD }

enum AuthStatus { NOT_LOG, SIGNED_IN_PRO, SIGNED_IN_PATIENT }

class Login_AC_2 extends StatefulWidget {
  @override
  _Login_AC_2State createState() => _Login_AC_2State();
}

class _Login_AC_2State extends State<Login_AC_2> {
  bool isChecked = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool wpc = false;

  void initLib() async {}

  @override
  void initState() {
    super.initState();
    initLib();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Container(
          color: Colors.white,
          child: Image.asset(
            "assets/images/Icot.png",
            fit: BoxFit.fitHeight,
            height: 50,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () async {
              await SharedPref.setStrKey("username", "");
              await SharedPref.setStrKey("password", "");
              await SharedPref.setBoolKey("IsRememberLogin", false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
        backgroundColor: gColors.white,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
        color: gColors.white,
        child: Column(
          children: <Widget>[
            Spacer(),
            Text(
              "Vous êtes intéressé par une solution alternative",
              textAlign: TextAlign.center,
              style: gColors.bodyTitle1_B_Pr,
            ),
            Spacer(),

            Container(
              width: MediaQuery.of(context).size.width - 60,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                    border: Border.all(
                      color: gColors.secondary,
                    ),
                    color: gColors.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Text(
                  "Prenez rendez-vous\navec docteur :\n${DbTools.api_User_Info.medecinNom}",
                  style: gColors.bodySaisie_B_W,
                  textAlign: TextAlign.center,
                ),
            ),

            Spacer(),
            Text(
              "Ils témoignent pour nous :",
              textAlign: TextAlign.center,
              style: gColors.bodyText_N_G,
            ),
            SizedBox(height: 12.0),
            GestureDetector(
                onTap: () async {
                  _launchVideo();
                },
                child: Image(
                  image: AssetImage('assets/images/icoVideo.png'),
                  height: 120,
                )),
            Spacer(),
            RoundedButton(
              Title: "ACCEDER A L’APPLICATION",
              backgroundColor: gColors.secondary,
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => P_IntroMes()));

              },
              width: MediaQuery.of(context).size.width - 60,
            ),




            Spacer(),
            RichText(
              text: TextSpan(
                  text: 'En continuant sur cette application vous acceptez notre politique de confidentialité , consultez-la en cliquant   ',
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
            SizedBox(height: 18.0),
            Text(DbTools.gVersion,
                style: TextStyle(
                  fontSize: 12,
                )),
          ],
        ),
      ),
    );
  }

  Future<void> _launchVideo() async {
    final Uri _url = Uri.parse('https://www.youtube.com/watch?v=k9HVhVZrbgo');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://epioneweb.fr/epione/public/fr/politique-confidentialite-patient-epione-mobile');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> login(String emailController_text, String passwordController_text) async {}
}
