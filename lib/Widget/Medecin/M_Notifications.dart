
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class M_Notifications extends StatefulWidget {

  @override
  M_NotificationsState createState() => M_NotificationsState();
}

class M_NotificationsState extends State<M_Notifications> {



  @override
  void initLib() async {
    await DbTools.getAppareilPat(0);

  }

  @override
  void initState() {
    initLib();

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
          gColors.wLabel(null, "Nom", "${DbTools.api_User_Info.prenom} ${DbTools.api_User_Info.nom}" ),
          SizedBox(height: 4.0),
          Container(height: 1, color: gColors.primary,),
          SizedBox(height: 8.0),
/*
          Expanded(
            child: ListView.builder(
              itemCount: DbTools.ListAppareil.length,
              itemBuilder: (context, index) {
                final item = DbTools.ListAppareil[index];

                return ListTile(
                  onTap: () {
                  },
                  dense: true,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                  visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                  title: Column(
                    children: [
                      Row(
                        children: [

                          Text("${item.Nom}",
                              style: gColors.bodyText_N_G),

                        ],
                      ),

                      Row(
                        children: [

                          Text("${item.Famille}",
                              style: gColors.bodyText_B_B),





                        ],
                      ),
                      Container(
                        height: 1, color: gColors.primary,
                      ),

                    ],
                  ),


                )
                ;
              },
            ),
          ),*/
          SizedBox(height: 8.0),

        ],
      ),
    );
  }

}