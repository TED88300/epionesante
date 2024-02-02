import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/gNewWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class P_Rec extends StatefulWidget {
  @override
  P_RecState createState() => P_RecState();
}

class P_RecState extends State<P_Rec> {
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
          SizedBox(height: 28.0),
          gNewWidget.RoundedTitle(context, "MES RECOMPENSES"),

          SizedBox(height: 28.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [




            Column(
              children: [
                Image.asset(
                  'assets/images/star.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(height: 8.0),
                Text(
                  "25% de\nl'objectif",
                  style: gColors.ObjText_B_G,
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/star.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(height: 8.0),
                Text(
                  "50% de\nl'objectif",
                  style: gColors.ObjText_B_G,
                ),
              ],
            ),
            Column(
              children: [
                Image.asset(
                  'assets/images/star.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(height: 8.0),
                Text(
                  "75% de\nl'objectif",
                  style: gColors.ObjText_B_G,
                ),
              ],
            )


          ],),
          SizedBox(height: 38.0),

          Text(
            "Récompense à venir",
            style: gColors.bodyTitle1_B_Pr,
          ),
          SizedBox(height: 18.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

            children: [




              Column(
                children: [
                  Image.asset(
                    'assets/images/3star.png',
                    height: 90,
                    width: 90,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "Objectif atteint",
                    style: gColors.ObjText_B_G,
                  ),
                ],
              ),



            ],),

        ],
      ),
    );
  }
}
