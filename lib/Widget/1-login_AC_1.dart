import 'package:epionesante/Widget/1-login.dart';
import 'package:epionesante/Widget/1-login_AC_2.dart';
import 'package:epionesante/Widget/Patient/P_IntroMes.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/shared_pref.dart';
import 'package:epionesante/Widget/2-home.dart';
import 'package:url_launcher/url_launcher.dart';

enum LoginError { PENDING, EMAIL_VALIDATE, WAITING_CONFIRMATION, DISABLE, ERROR_USER_NOT_FOUND, WRONG_PASSWORD }

enum AuthStatus { NOT_LOG, SIGNED_IN_PRO, SIGNED_IN_PATIENT }

class Login_AC_1 extends StatefulWidget {
  @override
  _Login_AC_1State createState() => _Login_AC_1State();
}

class _Login_AC_1State extends State<Login_AC_1> {
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
//              "Savez-vous qu’il existe\nune solution alternative à la PPC ?",
              textAlign: TextAlign.center,
              style: gColors.bodyTitle1_B_Pr,
            ),
            Spacer(),
            GestureDetector(
                onTap: () async {
                  _launchVideo();
                },
                 child: Image(
                  image: AssetImage('assets/images/icoPlay.png'),
                  height: 100,
                )),
            SizedBox(height: 8.0),
            Text(
              "Cliquez pour visionner la vidéo",
              textAlign: TextAlign.center,
              style: gColors.bodyText_B_G,
            ),
            Spacer(),
            Text(
              "Seriez-vous intéressé ?",
              textAlign: TextAlign.center,
              style: gColors.bodyTitle1_B_Pr,
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login_AC_2()));
                        },
                    child: Image(
                      image: AssetImage('assets/images/icoOk.png'),
                      height: 50,
                    )),
                SizedBox(width: 38.0),
                GestureDetector(
                    onTap: () async {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => P_IntroMes()));
                    },
                    child: Image(
                      image: AssetImage('assets/images/icoCancel.png'),
                      height: 50,
                    )),
              ],
            ),
            Spacer(),
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
    final Uri _url = Uri.parse('https://www.youtube.com/watch?v=sT0Fx3sGO8Y');
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
