
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Widget/Medecin/M_Patients.dart';
import 'package:epionesante/Widget/Medecin/M_Patients_Equip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class M_ListeSel extends StatefulWidget {

  @override
  M_ListeSelState createState() => M_ListeSelState();
}

class M_ListeSelState extends State<M_ListeSel> {


  Future Reload() async {
    await DbTools.ApiSrv_medecin_patients(DbTools.gApiID, DbTools.gApiPassword);
    print(
        "DbTools.medecin_patientsList.length ${DbTools.medecin_patientsList.length}");


  }


  @override
  void initLib() async {
    await DbTools.getAppareilPat(0);
    await Reload();

  }

  @override
  void initState() {
    initLib();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(50),
      color: gColors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 8.0),

          ElevatedButton(
              child:

              Container(

                  padding:
                  EdgeInsets.fromLTRB(40, 30, 40, 30),
                  child:
                  Text(
                "LISTE DES PATIENTS",
                style: gColors.bodyTitle1_B_W,
                textAlign: TextAlign.center,
              ),
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(gColors.primary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(12.0),
                          ),

                      )
                  )
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => M_Patients()));


              },

          ),


          ElevatedButton(
              child:

              Container(

                padding:
                EdgeInsets.fromLTRB(40, 30, 40, 30),
                child:
                Text(
                  "PATIENTS EQUIPÉS",
                  style: gColors.bodyTitle1_B_W,
                  textAlign: TextAlign.center,
                ),
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(gColors.secondary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),

                      )
                  )
              ),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => M_Patients_Equip()));


              },



          ),








          SizedBox(height: 8.0),

        ],
      ),
    );
  }

}