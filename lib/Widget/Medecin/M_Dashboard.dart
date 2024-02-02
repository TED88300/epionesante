
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class M_DashBoard extends StatefulWidget {

  @override
  M_DashBoardState createState() => M_DashBoardState();
}

class M_DashBoardState extends State<M_DashBoard> {


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

          gColors.wLabel(null, "Nom", "Dr OUMAMA *BADARANI*"),
          SizedBox(height: 4.0),
          Container(height: 1, color: gColors.primary,),



          Spacer(),



          SizedBox(height: 8.0),
        ],
      ),
    );
  }


}