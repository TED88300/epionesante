import 'package:epionesante/Widget/1-login_AC_1.dart';
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

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isChecked = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool wpc = false;

  void initLib() async {}

  @override
  void initState() {
    super.initState();
    initLib();
    if (DbTools.gTED) {
      emailController.text = "contact@epionesante.fr";
      passwordController.text = "Test0001";
    }
  }

  @override
  Widget build(BuildContext context) {
    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Mail',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final password = TextField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Mot de passe',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      ),
    );

    final loginButton_Med = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        onPressed: () async {
          emailController.text = "medecin.testapple.epione@gmail.com";
          passwordController.text = "Test0001";
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: gColors.primary,
          padding: const EdgeInsets.all(12),
        ),
        child: Text('Login Med', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final loginButton_Pat = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        onPressed: () async {
          emailController.text = "contact@epionesante.fr";
          //         emailController.text = "t.apple3@epionesante.fr";
          //       emailController.text = "n.chaste@sfmedicale.fr";
          passwordController.text = "Test0001";
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: gColors.primary,
          padding: const EdgeInsets.all(12),
        ),
        child: Text('Login Pat', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final loginButton = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        onPressed: () async {
          DbTools.gIsMedecinLogin = true;
          if (emailController != null && passwordController != null) {
            if (await DbTools.ApiSrv_Login(emailController.text, passwordController.text)) {
              print("User OK ApiID = ${DbTools.api_login.cryptedId}");
              await SharedPref.setStrKey("username", emailController.text);
              await SharedPref.setStrKey("password", passwordController.text);

              DbTools.gApiID = DbTools.api_login.cryptedId;
              DbTools.gApiPassword = DbTools.api_login.password;

              await SharedPref.setStrKey("ApiID", DbTools.api_login.cryptedId);
              await SharedPref.setStrKey("ApiPassword", DbTools.api_login.password);

              print("loginButton: ${DbTools.api_login.cryptedId} password: ${DbTools.api_login.password}");
              await SharedPref.setBoolKey("IsRememberLogin", true);
              await SharedPref.setBoolKey("IsMedecinLogin", DbTools.api_login.role == "MEDECIN");
              DbTools.gUsername = emailController.text;
              DbTools.gPassword = passwordController.text;
              DbTools.gIsMedecinLogin = DbTools.api_login.role == "MEDECIN";
              print("Login \n\n${DbTools.api_User_Info.nom}");

              if (DbTools.gIsMedecinLogin)
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
              else
                {
                  if (DbTools.gIsAC)
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login_AC_1()));
                  else
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => P_IntroMes()));

                }
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: gColors.secondary,
          padding: const EdgeInsets.all(12),
        ),
        child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final loginButtonGris = Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: ElevatedButton(
        onPressed: () async {

        },
        style: ElevatedButton.styleFrom(
          backgroundColor: gColors.LinearGradient3,
          padding: const EdgeInsets.all(12),
        ),
        child: Text('Login', style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    return Scaffold(
      backgroundColor: gColors.primary,
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
        color: gColors.white,
        child: Column(
          children: <Widget>[
            SizedBox(height: 8.0),
            Expanded(
              child: new Image.asset(
                'assets/images/AppIco.png',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "EPIONE",
                  style: gColors.bodyTitle1_B_P,
                ),
                Text(
                  "Santé",
                  style: gColors.bodyTitle1_B_S,
                ),
              ],
            ),
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 12.0),
            Row(
              children: [
                Spacer(),
                wpc
                    ? loginButton : loginButtonGris,
                Spacer(),
              ],
            ),
            SizedBox(height: 8.0),
            CheckboxListTile(

              title: RichText(
                text: TextSpan(
                    text: 'En continuant sur cette application vous acceptez notre politique de confidentialité , consultez-la en cliquant   ',
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

//              Text("En continuant sur cette application vous acceptez notre politique de confidentialité , consultez-la en cliquant ici"),

              value: wpc,
              onChanged: (newValue) {
                wpc = newValue!;
                setState(() {});
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),



            !DbTools.gTED
                ? Container()
                : Row(
                    children: [
                      Spacer(),
                      loginButton_Med,
                      SizedBox(width: 24.0),
                      loginButton_Pat,
                      Spacer(),
                    ],
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


  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse('https://epioneweb.fr/epione/public/fr/politique-confidentialite-patient-epione-mobile');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }


  Future<void> login(String emailController_text, String passwordController_text) async {}
}
