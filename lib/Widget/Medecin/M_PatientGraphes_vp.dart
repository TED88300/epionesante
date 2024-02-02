import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class M_PatientGraphes_vp extends StatefulWidget {
  @override
  M_PatientGraphes_vpState createState() => M_PatientGraphes_vpState();
}

class M_PatientGraphes_vpState extends State<M_PatientGraphes_vp> {


  @override
  void initLib() async {
    await DbTools.getMesurePat(0);

  }

  @override
  void initState() {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    initLib();

    super.initState();
  }


  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
    ]);
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


return new RotatedBox(
    quarterTurns: 3,
    child:  Scaffold(

        appBar: AppBar(
          title: Text(
            "Mesures Patient",
          ),
          backgroundColor: gColors.primary,
        ),
        backgroundColor: Colors.transparent,

        body: Container(
          padding: EdgeInsets.all(8),

          color: gColors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0),
              wLabels(),


              Expanded(
                child: new Image.asset(
                  'assets/images/GraphV.png',
                ),
              ),


              SizedBox(height: 8.0),

            ],
          ),
        )));
  }



  Widget wLabels() {
    return Column(
      children: [
        gColors.wLabel(null, "Nom", "Mme KARIMA AARAB"),
        SizedBox(height: 4.0),
        Container(
          height: 1,
          color: gColors.primary,
        ),

        SizedBox(height: 8.0),
      ],
    );
  }


}
