import 'package:auto_size_text/auto_size_text.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class M_PatientMesures_vp extends StatefulWidget {
  @override
  M_PatientMesures_vpState createState() => M_PatientMesures_vpState();
}

class M_PatientMesures_vpState extends State<M_PatientMesures_vp> {
  @override
  void initLib() async {
    await DbTools.getMesurePat(0);
  }

  @override
  void initState() {
    initLib();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //    endDrawer: DbTools.gIsMedecinLogin! ? C_SideDrawer() : I_SideDrawer(),

        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: AutoSizeText(
            "Mesures Patient",
            maxLines: 1,
          ),
          backgroundColor: gColors.primary,
        ),
        body: Container(
          padding: EdgeInsets.all(8),
          color: gColors.white,
          child: Column(
            children: <Widget>[
              SizedBox(height: 8.0),
              wLabels(),
              Expanded(
                child: ListView.builder(
                  itemCount: DbTools.ListMesure.length,
                  itemBuilder: (context, index) {
                    final item = DbTools.ListMesure[index];

                    return ListTile(
                      onTap: () {},
                      dense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      title: Column(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.warning, color: item.id %3 == 0 ? gColors.tks : Colors.transparent,) ,

                            Text("  ${item.Date}", style: gColors.bodyText_N_G),
                              Spacer(),
                              Text("${item.Value}",
                                  style: gColors.bodyText_B_B),
                            ],
                          ),
                          Container(
                            height: 1,
                            color: gColors.primary,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),
            ],
          ),
        ));
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
