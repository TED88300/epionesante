import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/shared_pref.dart';
import 'package:epionesante/Widget/2-home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class P_IntroMes extends StatefulWidget {
  @override
  P_IntroMesState createState() => P_IntroMesState();
}

class P_IntroMesState extends State<P_IntroMes> {
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gColors.primary,
      body: Container(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        color: gColors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(120.0, 80.0, 120.0, 50.0),
              color: gColors.white,
              width: 350,
              child: new Image.asset(
                'assets/images/AppIco.png',
              ),
            ),
            SizedBox(height: 8.0),
            Center(
              child: Text(
                "Bienvenue\n\n${DbTools.api_User_Info.nom}",
                style: TextStyle(
                  color: gColors.primary,
                  fontSize: 44,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
            height: !DbTools.gPatientRGPD ? 40 : 0
            ),
            !DbTools.gPatientRGPD ? Row(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
              Checkbox(
                value: DbTools.gPatientRGPD,
                onChanged: (bool? value) async {
                  DbTools.gPatientRGPD = value!;
                  await SharedPref.setBoolKey("PatientRGPD", true);
                  setState(() {});
                },
              ),
              Text(
                "En tant que patient,\nj'accepte la collecte\nde mes données de santé\npar Epione Santé",
                textAlign: TextAlign.left,
                style: gColors.bodyText_N_G,
              ),
            ]):



            ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                splashFactory: NoSplash.splashFactory,
                elevation: MaterialStateProperty.resolveWith(
                  (states) {
                    return 0;
                  },
                ),
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return Colors.white;
                  },
                ),
                overlayColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return states.contains(MaterialState.pressed) ? Colors.white : null;
                  },
                ),
                shadowColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return Colors.white;
                  },
                ),
                surfaceTintColor: MaterialStateProperty.resolveWith(
                  (states) {
                    return Colors.white;
                  },
                ),
              ),


              child: Container(
                padding: EdgeInsets.fromLTRB(40.0, 40.0, 20.0, 20.0),
                child: Image.asset(
                  'assets/images/intro.png',
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
