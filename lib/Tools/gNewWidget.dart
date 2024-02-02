
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/material.dart';

class gNewWidget {
  static  Widget RoundedTitle(context, Title) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: gColors.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          width: MediaQuery.of(context).size.width - 20,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Text(
            "${Title}",
            style: gColors.bodyTitle1_B_W,
            textAlign: TextAlign.center,
          ),
        ),      ],
    );
  }

  static  Widget RoundedTitleSmall(context, Title) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: gColors.primary,
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
          width: MediaQuery.of(context).size.width - 20,
          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            "${Title}",
            style: gColors.bodyTitle1_B_Wr,
            textAlign: TextAlign.center,
          ),
        ),      ],
    );
  }



}

class RoundedButton extends StatelessWidget {

  final String Title;
  final Color backgroundColor;

  final Function() onPressed;

  final double width;



  const RoundedButton({required this.Title, required this.backgroundColor, required this.onPressed, required this.width});

  @override
  Widget build(BuildContext context) {
    return     Column(
      children: [
        Container(height: 8),
         Container(
            width: width ,
            child: ElevatedButton(
              onPressed: () async {
                await onPressed();
              },


              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),

                backgroundColor: backgroundColor,
                padding: const EdgeInsets.all(12),
              ),

              child: Text("${Title}",
                style: gColors.bodySaisie_B_W,
                textAlign: TextAlign.center,),
            )),
      ],
    );
  }




}


class ContButton extends StatelessWidget {

  final String Img;
  final Color backgroundColor;

  final Function() onPressed;

  final double width;



  const ContButton({required this.Img, required this.backgroundColor, required this.onPressed, required this.width});

  @override
  Widget build(BuildContext context) {
    return     Column(
      children: [

        Container(
            padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
            width: width ,
            child: ElevatedButton(
              onPressed: () async {
                await onPressed();
              },

              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: Size.zero, // Set this
                padding: EdgeInsets.zero, // and this
                backgroundColor: Colors.white,

              ),


              child:
              new Image.asset('assets/images/${Img}.png',height: 100,width: 100,),

            )),
      ],
    );
  }




}