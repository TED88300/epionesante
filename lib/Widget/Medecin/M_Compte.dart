import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class M_Compte extends StatefulWidget {
  @override
  M_CompteState createState() => M_CompteState();
}

class M_CompteState extends State<M_Compte> {

  bool NotifVal = false;

  void initState() {
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
          SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    children: [
                      wLabels(),


                    ],
                  ))),




          Row(
            children: [
              Text("Notifications des patients souhaitées",
                style: gColors.bodyText_B_G,
              ),
              Spacer(),
              Switch(
                value: NotifVal,
                onChanged: (value) {
                  setState(() {
                    NotifVal = value;
                  });
                },
              ),
            ],
          ),


          Spacer(),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text("Ref : ${DbTools.api_User_Info.numeroRpps}",
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
        gColors.wLabel(null, "Nom", "${DbTools.api_User_Info.prenom} ${DbTools.api_User_Info.nom}" ),
        SizedBox(height: 4.0),
        Container(height: 1, color: gColors.primary,),
        SizedBox(height: 8.0),


      ],
    );
  }






}
