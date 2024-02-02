import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:gradient_colored_slider/gradient_colored_slider.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import 'package:syncfusion_flutter_core/theme.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:epionesante/Tools/gNewWidget.dart';

import 'ApiData.dart';

class gColors {
  static String RetMailDem = "";


  static double MediaQuerysizewidth = 0;

  static const Color primaryTr = Color(0x5566a7f9);
  static const Color secondaryTr = Color(0x556cc96b);

  static const Color primary = Color(0xFF66a7f9);
  static const Color secondary = Color(0xFF6cc96b);
  static const Color secondaryF = Color(0xFF0c5302);
  static const Color secondaryF2 = Color(0xFF0a4702);
  static const Color LinearGradient1 = Color(0xFFaaaaaa);
  static const Color LinearGradient2 = Color(0xFFf6f6f6);
  static const Color LinearGradient3 = Color(0xFFe6e6e6);
  static const Color TextColor1 = Color(0xFF222222);
  static const Color TextColor2 = Color(0xFF555555);
  static const Color TextColor3 = Color(0xFFFFFFFF);
  static const Color white = Colors.white;
  static const Color grey = Colors.black;
  static const Color transparent = Colors.transparent;

  static const Color tks = Color(0xFFEE4444);

  static Random random = new Random();
  static int ImageRandom = random.nextInt(10444) + 1;
  static TextEditingController wControllerMoment = TextEditingController();
  static TextEditingController wControllerMail = TextEditingController();
  static Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;
    final lowDivisor = 6;
    final highDivisor = 5;
    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }

  static TextStyle get bodyTitle1_B_P => TextStyle(
        color: primary,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get bodyTitle1_B_Pr => TextStyle(
        color: primary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyTitle1_B_S => TextStyle(
        color: secondary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get bodyTitle1_B_W => TextStyle(
        color: white,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyTitle_B_P => TextStyle(
        color: primary,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyTitle1_B_Sr => TextStyle(
        color: secondary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyTitle1_B_Wr => TextStyle(
        color: white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyTitle1_B_G => TextStyle(
        color: grey,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get bodyTitle1_B_Gr => TextStyle(
        color: Colors.grey,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodySaisie_N_G => TextStyle(
        color: grey,
        fontSize: 24,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get bodySaisie_B_G => TextStyle(
        color: grey,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodySaisie_B_P => TextStyle(
        color: primary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );


  static TextStyle get bodySaisie_B_P20 => TextStyle(
    color: primary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get bodySaisie_B_W => TextStyle(
        color: white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodySaisie_B_S => TextStyle(
        color: secondary,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get ObjText_B_G => TextStyle(
        color: grey,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get ObjText_B_N => TextStyle(
    color: grey,
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );


  static TextStyle get ObjText_S_B => TextStyle(
        color: secondary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyText_B_G => TextStyle(
        color: grey,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get bodyText_B_S => TextStyle(
    color: secondary,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static TextStyle get bodyText_B_W => TextStyle(
        color: white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyText_N_G => TextStyle(
        color: grey,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyText_B_B => TextStyle(
        color: primary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get bodyText_N_B => TextStyle(
        color: primary,
        fontSize: 16,
      );

  static TextStyle get bodyText_S_B => TextStyle(
        color: secondary,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyText_S_N => TextStyle(
        color: secondary,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      );

  static TextStyle get bodyText_S_O => TextStyle(
        color: Colors.deepOrangeAccent,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get bodyText_B_R => TextStyle(
        color: tks,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

  static Widget wLabel(var aIcon, String aLabel, String aData) {
    return Row(
      children: [
        aIcon == null
            ? Container()
            : Icon(
                aIcon,
                color: Colors.grey,
              ),
        SizedBox(
          width: 2,
        ),
        Container(
          child: Text(
            aLabel,
            style: bodyText_N_G,
          ),
        ),
        Expanded(
          child: Text(
            aData,
            textAlign: TextAlign.right,
            style: bodyText_B_B,
          ),
        ),
      ],
    );
  }

  static Widget wLabelTitle(var aIcon, String aLabel, String aData) {
    return Row(
      children: [
        aIcon == null
            ? Container()
            : Icon(
                aIcon,
                color: Colors.grey,
              ),
        SizedBox(
          width: 2,
        ),
        Container(
          child: Text(
            aLabel,
            style: bodyText_B_B,
          ),
        ),
        Expanded(
          child: Text(
            aData,
            textAlign: TextAlign.right,
            style: bodyText_B_B,
          ),
        ),
      ],
    );
  }

  static Widget wLabel2(var aIcon, String aLabel, String aData) {
    return Row(
      children: [
        aIcon == null
            ? Container()
            : Icon(
                aIcon,
                color: Colors.grey,
              ),
        SizedBox(
          width: 2,
        ),
        Container(
          child: Text(
            aLabel,
            style: bodyTitle1_B_Pr,
          ),
        ),
      ],
    );
  }

  static Widget wNumber(String aLabel, String aData) {
    return Row(
      children: [
        SizedBox(
          width: 50,
        ),
        Icon(
          Icons.local_offer,
          color: Colors.grey,
        ),
        SizedBox(
          width: 2,
        ),
        Container(
          width: 60,
          child: Text(
            aLabel,
            style: gColors.bodyText_N_G,
          ),
        ),
        Expanded(
          child: Text(
            aData,
            textAlign: TextAlign.right,
            style: gColors.bodyText_B_B,
          ),
        ),
      ],
    );
  }

  static Widget wAppareil(var aImg, String aLabel, String aParam, String aWww) {
    return Row(
      children: [
        aImg == "" ? Container() : AppImg(aImg),
        SizedBox(
          width: 2,
        ),
        Expanded(
            child: Column(
          children: [
            Text(
              aLabel,
              textAlign: TextAlign.right,
              style: gColors.bodyText_B_B,
            ),
            Text(
              aParam,
              textAlign: TextAlign.right,
              style: gColors.bodyText_N_G,
            ),
          ],
        )),
      ],
    );
  }

  static Widget wMesure(var aImg, String aLabel, String aParam, String aWww) {
    return Row(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${aParam}",
              textAlign: TextAlign.left,
              style: gColors.bodyText_B_G,
            ),
            /*           Text(
              aLabel,
              textAlign: TextAlign.left,
              style: gColors.bodyText_B_B,
            ),
            Text(
              aParam,
              textAlign: TextAlign.left,
              style: gColors.bodyText_N_G,
            ),*/
          ],
        )),
      ],
    );
  }

  static Widget wAppareilBtn(
      var aImg, String aLabel, String aParam, String aWww) {
    return OutlinedButton(
        onPressed: () async {
          if (!await launchUrl(Uri.parse(aWww))) throw 'Could not launch $aWww';
        },
        child: Row(
          children: [
            AppImg(aImg),
            SizedBox(
              width: 2,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  aLabel,
                  textAlign: TextAlign.right,
                  style: gColors.bodyText_B_B,
                ),
                Text(
                  aParam,
                  textAlign: TextAlign.right,
                  style: gColors.bodyText_N_G,
                ),
              ],
            )),
          ],
        ));
  }

  static Widget AppImg(String wImgPath) {
    print(wImgPath + "?v=${gColors.ImageRandom}");
    return Container(
      width: 50,
      height: 50,
      child: CachedNetworkImage(
        imageUrl: wImgPath + "?v=${gColors.ImageRandom}",
        errorWidget: (context, url, error) => Container(),
      ),
    );
  }

  static Widget wDoubleLigne() {
    return Column(
      children: [
        SizedBox(height: 8.0),
        Container(
          height: 1,
          color: gColors.primary,
        ),
        Container(
          height: 2,
        ),
        Container(
          height: 1,
          color: gColors.primary,
        ),
        SizedBox(height: 8.0),
      ],
    );
  }

  static Widget wLabelMesure(String aFamText, String aLibText) {
    return Column(
      children: [
        SizedBox(height: 8.0),
        gColors.wLabel2(null, "", aLibText),
        SizedBox(height: 8.0),
      ],
    );
  }

  static Widget wTextFieldMesureRow(TextEditingController aController,
      String ahintText, String atitletText, int min, int max) {
    return Row(
      children: [
        Container(
          width: gColors.MediaQuerysizewidth / 3,
          child: Text(
            atitletText,
            style: gColors.bodyText_B_G,
          ),
        ),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            style: gColors.bodyText_N_G,
            controller: aController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (newValue) {
              if (newValue == '') {
                return null;
              } else if (int.parse(newValue!) < min) {
                return 'inférieure à la limite : $min';
              } else if (int.parse(newValue) > max) {
                return 'inférieure à la limite : $max';
              } else {
                return null;
              }
            },
            autofocus: false,
            decoration: InputDecoration(
              hintText: "$ahintText ($min - $max)",
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            ),
          ),
        ),
      ],
    );
  }









  static Widget wObj(
      String Lib, String Val, TextStyle bodyText1, TextStyle bodyText2) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 180,
          child: Text(
            '$Lib',
            style: bodyText1,
            textAlign: TextAlign.left,
          ),
        ),
        Container(
          width: 80,
          child: Text(
            '$Val',
            style: bodyText2,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ));
  }


  static Widget wTextFieldMesureContext(
      TextEditingController aController,
      String ahintText,
      String atitletText,
      int min,
      int max,
      String aObj,
      String aPrec,
      FocusNode _nameFocus) {
    int prec = 0;
    int obj = 0;

    var wtime = DateTime.now();
    wtime = new DateTime(wtime.year, wtime.month, wtime.day, 8, 0, 0, 0, 0);

    if (aObj != "") obj = int.parse(aObj);

    if (aPrec != "") prec = int.parse(aPrec);

    if (atitletText == "Escalier") atitletText = "Etages";

    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0), // TED
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: atitletText == "Etages"
                      ? CupertinoPickerStateful(
                          aController: aController,
                          amin: 0,
                          amax: 10,
                          aprec: 0,
                          ahintText: "étages")
                      : CupertinoTimerStateful(
                          aController: aController,
                          minInterv: 1,
                        ),
                ),
              ),
              Container(width: 20),
            ],
          ),
          Container(height: 20),
          prec == 0
              ? Container()
              : Container(
                  width: 140,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: ElevatedButton(
                        onPressed: () async {
                          int newValue = prec;
                          aController.text = "${newValue}";
                        },
//                  padding: EdgeInsets.all(12),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: gColors.primary)))),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text('Prec : ${prec}',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: gColors.primary,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ),
                ),
        ],
      ),
    );
  }

  static Widget wTextFieldMesureContextV3(
      TextEditingController aController,
      String ahintText,
      String atitletText,
      int min,
      int max,
      String aObj,
      String aPrec,
      FocusNode _nameFocus) {
    int prec = 0;
    int obj = 0;

    var wtime = DateTime.now();
    wtime = new DateTime(wtime.year, wtime.month, wtime.day, 8, 0, 0, 0, 0);
    if (aObj != "") obj = int.parse(aObj);
    if (aPrec != "") prec = int.parse(aPrec);
    if (atitletText == "Escalier") atitletText = "Etages";

    print("atitletText ${atitletText}");

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: atitletText == "Etages"
                      ? CupertinoPickerStateful(
                          aController: aController,
                          amin: 0,
                          amax: 10,
                          aprec: 0,
                          ahintText: "étages")
                      : atitletText.contains("Marche")
                          ? TimerStateful(
                              aController: aController, minInterv: 1, aIcon: 1)
                          : TimerStateful(
                              aController: aController, minInterv: 1, aIcon: 2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static Widget wTextFieldMesureV3(
      TextEditingController aController,
      TextEditingController aController2,
      String ahintText,
      String atitletText,
      int min,
      int max,
      int seuilmin,
      int seuilmax,
      String aObj,
      String aPrec,
      FocusNode _nameFocus,
      BuildContext context) {
    int prec = 0;
    int obj = 0;
    double SliderVal = 0;

    if (aObj != "") obj = int.parse(aObj);

    if (aPrec != "") prec = double.parse(aPrec).toInt();

    if (atitletText.contains("Temps de sommeil")) prec = 0;
    if (atitletText.contains("Temps de sommeil")) aController.text = "480";
    if (atitletText.contains("Qualité du sommeil")) prec = 0;
    if (atitletText.contains("Qualité du sommeil")) aController.text = "5";


    print("ZZZZZZZZZZZ wTextFieldMesureV3 ${atitletText} ${ahintText} m ${seuilmin} M ${seuilmax}");


//    seuilmin = -1;
  //  seuilmax = -1;

    String wtitletText = atitletText;

    var wtime = DateTime.now();
    wtime = new DateTime(wtime.year, wtime.month, wtime.day, 8, 0, 0, 0, 0);

    Duration aDur = Duration(hours: 22);
    Duration bDur = Duration(hours: 7);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 12,),
          atitletText.contains("Qualité du sommeil")
              ? Container()
              : atitletText.contains("Temps de sommeil")
                  ? NuitStatefulV3(
                      aDur: aDur, bDur: bDur, aController: aController)
                  : Container(),
          Container(height: 10,),
          atitletText.contains("Temps de sommeil")
              ? Container()
              : atitletText.contains("Qualité du sommeil")
                  ? SliderStateful(aController: aController)
              : atitletText.contains("Nombre de réveils") ?
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CupertinoPickerStateful(
                aController: aController,
                amin: 0,
                amax: 10,
                aprec: prec,
                ahintText: atitletText.replaceAll("Nombre de réveils", "Nombre d’éveils")),
          )

              : atitletText.contains("Durée d'insomnie") ?
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CupertinoPickerStateful(
                aController: aController,
                amin: 0,
                amax: 120,
                aprec: prec,
                ahintText: atitletText.replaceAll("Durée d'insomnie", "Durée de l’éveil")),
          ) :
          Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: CupertinoPickerStateful(
                          aController: aController,
                          amin: min,
                          amax: max,
                          aprec: prec,
                          ahintText: ahintText),
                    ),



        ],
      ),
    );
  }
}

class Label_TextField {
  String? familleAppareil;
  String? codeAppareil;

  Widget? wLabel;
  String? sLabel;
  List<Widget>? listTF = [];
  List<Donnees> listDonnees = [];
  List<TextEditingController> listTEC = [];

  Label_TextField(
    this.familleAppareil,
    this.codeAppareil,
    this.wLabel,
    this.sLabel,
    this.listTF,
    this.listDonnees,
    this.listTEC,
  );
}

class SliderStateful extends StatefulWidget {
  const SliderStateful({Key? key, required this.aController}) : super(key: key);

  final TextEditingController aController;
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<SliderStateful> {
  double _value = 0.5;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Column(
          children: [
            gNewWidget.RoundedTitleSmall(context, "MA QUALITÉ DE SOMMEIL"),
            Container(
              height: 8,
            ),
            Text(
              '${(_value * 10).round()}',
              style: gColors.bodyTitle1_B_P,
            ),
            GradientColoredSlider(
              value: _value,
              barWidth: 1,
              barSpace: 0,
              onChanged: (double value) {
                setState(() {
                  _value = value;
                  double wTmp = value * 10.0;
                  print("$wTmp ${wTmp.round()}");
                  widget.aController.text = "${wTmp.round()}";
                });
              },
            ),
          ],
        ));
  }
}

class SliderStatefulV3 extends StatefulWidget {
  const SliderStatefulV3(
      {Key? key, required this.aController, required this.aCoucher})
      : super(key: key);

  final TextEditingController aController;
  final bool aCoucher;
  @override
  _State8 createState() => new _State8();
}

//State is information of the application that can change over time or when some actions are taken.
class _State8 extends State<SliderStatefulV3> {
  DateTime _value = DateTime(2000, 12, 01);

  @override
  Widget build(BuildContext context) {
    if (_value == DateTime(2000, 12, 01)) {
      _value = DateTime(2000, 01, 01, 8);
      if (widget.aCoucher) _value = DateTime(2000, 01, 01, 20);
    }

    return Padding(
        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Expanded(
              child: Container(
//            color: Colors.greenAccent,
                child: SfSliderTheme(
                  data: SfSliderThemeData(
                    activeTrackHeight: 2.0,
                    inactiveTrackHeight: 2.0,
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Colors.grey,
                    thumbColor: gColors.transparent,
                    tooltipBackgroundColor: gColors.primary,
                    tooltipTextStyle: TextStyle(
                      color: gColors.white,
                    ),
                  ),
                  child: SfSlider(
                    min: DateTime(2000, 01, 01, 00),
                    max: DateTime(2000, 01, 01, 24),
                    value: _value,
                    interval: 20,
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: true,
                    shouldAlwaysShowTooltip: true,
                    thumbIcon: Icon(
                      widget.aCoucher ? Icons.nightlight : Icons.light_mode,
                      color: Colors.amberAccent,
                      size: 20.0,
                    ),
                    dateFormat: DateFormat.Hm(),
                    dateIntervalType: DateIntervalType.years,
                    onChanged: (dynamic value) {
                      setState(() {
                        _value = value;
                        widget.aController.text = "${_value}";
                      });
                    },
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Icon(
                widget.aCoucher ? Icons.light_mode : Icons.nightlight,
                color: Colors.black,
                size: 20.0,
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Icon(
                widget.aCoucher ? Icons.nightlight : Icons.light_mode,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ],
        ));
  }
}

class CupertinoPickerStateful extends StatefulWidget {
  const CupertinoPickerStateful(
      {Key? key,
      required this.aController,
      required this.amin,
      required this.amax,
      required this.aprec,
      required this.ahintText})
      : super(key: key);

  final TextEditingController aController;
  final int amin;
  final int amax;
  final int aprec;

  final String ahintText;

  @override
  _State2 createState() => new _State2();
}

//State is information of the application that can change over time or when some actions are taken.
class _State2 extends State<CupertinoPickerStateful> {
  int _value = 0;
  int initvalue = 0;

  List<Widget> valList = <Widget>[];
  List<String> svalList = <String>[];

  bool init = false;

  @override
  Widget build(BuildContext context) {
//    _value =  int.parse(widget.aController.text);

//  print("CupertinoPickerStateful CupertinoPickerStateful CupertinoPickerStateful CupertinoPickerStateful");

    if (!init) {
      int iPos = 0;
      for (int i = widget.amin; i <= widget.amax; i++) {
        valList.add(Text("$i"));
        svalList.add("$i");
        if (i == widget.aprec) initvalue = iPos;
        iPos++;
      }

      _value = initvalue;

      print("a initvalue $initvalue   ${valList[initvalue]}  widget.aprec ${widget.aprec} ${widget.ahintText}");
      widget.aController.text = "${svalList[_value]}";

      init = true;
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 10),
          widget.ahintText.contains("réveils") || widget.ahintText.contains("insomnie") ?
          Text(
            '${widget.ahintText}',
            style: gColors.bodyTitle1_B_P,
          )
              :          Text(
            '${widget.aController.text} ${widget.ahintText}',
            style: gColors.bodyTitle1_B_P,
          ),
          Container(height: 10),
          (widget.ahintText.contains("étage"))
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      Container(width: 0),
                      Image.asset(
                        'assets/images/Cont3.png',
                        height: 150,
                        width: 75,
                      ),
                      Container(
                        width: 150,
                        height: 100,
                        child: CupertinoPicker(
                          scrollController: FixedExtentScrollController(
                              initialItem: initvalue),
                          backgroundColor: Colors.white,
                          itemExtent: 30,
                          children: valList,
                          onSelectedItemChanged: (value) {
                            setState(() {
                              _value = value;
                              widget.aController.text = "${svalList[value]}";
                            });
                          },
                        ),
                      ),
                    ]) :
            (widget.ahintText.contains("réveils"))
              ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                width: 50,),
                Container(
                  width: 150,
                  height: 100,
                  child: CupertinoPicker(
                    scrollController: FixedExtentScrollController(
                        initialItem: initvalue),
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    children: valList,
                    onSelectedItemChanged: (value) {
                      setState(() {
                        _value = value;
                        widget.aController.text = "${svalList[value]}";
                      });
                    },
                  ),
                ),
                Container(
                  width: 50,),
              ]):
              (widget.ahintText.contains("Durée de l’éveil"))
                ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,),
                  Container(
                    width: 150,
                    height: 100,
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: initvalue),
                      backgroundColor: Colors.white,
                      itemExtent: 30,
                      children: valList,
                      onSelectedItemChanged: (value) {
                        setState(() {
                          _value = value;
                          widget.aController.text = "${svalList[value]}";
                        });
                      },
                    ),
                  ),
                  Text(
                    ' min',
                    style: gColors.bodyTitle1_B_Pr,
                  ),
                ])
              : Container(
                  width: 300,
                  height: 100,
                  child: CupertinoPicker(
                    scrollController:
                        FixedExtentScrollController(initialItem: initvalue),
                    backgroundColor: Colors.white,
                    itemExtent: 30,
                    children: valList,
                    onSelectedItemChanged: (value) {
                      setState(() {
                        _value = value;
                        widget.aController.text = "${svalList[value]}";
                      });
                    },
                  ),
                ),
          Container(height: 10),
        ]);
  }
}

class CupertinoPickerStatefulTension extends StatefulWidget {
  const CupertinoPickerStatefulTension(
      {Key? key,
      required this.aController,
      required this.amin,
      required this.amax,
      required this.aprec,
      required this.ahintText,
      required this.update,

      })
      : super(key: key);

  final ValueChanged<int> update;
  final TextEditingController aController;
  final int amin;
  final int amax;
  final int aprec;

  final String ahintText;

  @override
  _State11 createState() => new _State11();
}

//State is information of the application that can change over time or when some actions are taken.
class _State11 extends State<CupertinoPickerStatefulTension> {
  int _value = 0;
  int initvalue = 0;

  List<Widget> valList = <Widget>[];
  List<String> svalList = <String>[];

  bool init = false;

  @override
  Widget build(BuildContext context) {
//    print("CupertinoPickerStatefulTension");

    //    _value =  int.parse(widget.aController.text);

    if (!init) {
      int iPos = 0;
      for (int i = widget.amin; i <= widget.amax; i++) {
        valList.add(Text("$i"));
        svalList.add("$i");
        if (i == widget.aprec) initvalue = iPos;
        iPos++;
      }

      _value = initvalue;

      print(
          "initvalue $initvalue   ${valList[initvalue]}  widget.aprec ${widget.aprec}");
      widget.aController.text = "${svalList[_value]}";

      init = true;
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 75,
                height: 100,
              ),
              Container(
                width: 150,
                height: 100,
                child: CupertinoPicker(
                  scrollController:
                      FixedExtentScrollController(initialItem: initvalue),
                  backgroundColor: Colors.white,
                  itemExtent: 30,
                  children: valList,
                  onSelectedItemChanged: (value) {
                    setState(() {
                      _value = value;
                      widget.update(value);
                      widget.aController.text = "${svalList[value]}";

                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 36, 0, 0),
                width: 75,
                height: 100,
                child: Text(
                  '${widget.ahintText}',
                  style: gColors.ObjText_B_N,
                ),
              ),
            ],
          ),
          Container(height: 10),
        ]);
  }
}



class CupertinoPickerContextStateful extends StatefulWidget {

  final TextEditingController wControllerMoment;

  const CupertinoPickerContextStateful({
    Key? key,
    required this.wControllerMoment,
  }) : super(key: key);

  @override
  _State5 createState() => new _State5();
}

//State is information of the application that can change over time or when some actions are taken.
class _State5 extends State<CupertinoPickerContextStateful> {
  int _value = 0;
  int initvalue = 0;

  List<Widget> valList = <Widget>[];
  List<String> svalList = <String>[];
  List<String> tvalList = <String>[];

  bool init = false;

  @override
  Widget build(BuildContext context) {
    valList.clear();
    svalList.clear();
    tvalList.clear();

    valList.add(Text("avant effort", style: gColors.bodySaisie_N_G,));
    tvalList.add("avant effort");
    svalList.add("0");
    valList.add(Text("après effort", style: gColors.bodySaisie_N_G,));
    tvalList.add("après effort");
    svalList.add("1");
    valList.add(Text("au réveil", style: gColors.bodySaisie_N_G,));
    tvalList.add("au réveil");
    svalList.add("2");
    valList.add(Text("au coucher", style: gColors.bodySaisie_N_G,));
    tvalList.add("au coucher");
    svalList.add("3");
    valList.add(Text("à mi-journée", style: gColors.bodySaisie_N_G,));
    tvalList.add("à mi-journée");
    svalList.add("4");

    _value = initvalue;

    widget.wControllerMoment.text = "${tvalList[_value]}";

    init = true;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 140,
            child: CupertinoPicker(
              //magnification: 1.22,
              //squeeze: 1.2,
              //useMagnifier: true,

              scrollController:
                  FixedExtentScrollController(initialItem: initvalue),
              backgroundColor: Colors.white,
              itemExtent: 30,
              children: valList,
              onSelectedItemChanged: (value) {
                setState(() {
                  _value = value;
                  widget.wControllerMoment.text = "${tvalList[value]}";
                  print("widget.wControllerMoment.text ${widget.wControllerMoment.text }");
                });
              },
            ),
          ),
          Container(height: 10),
        ]);
  }
}




class CupertinoPickerMailStateful extends StatefulWidget {

  final TextEditingController wControllerMail;

  const CupertinoPickerMailStateful({
    Key? key,
    required this.wControllerMail,
  }) : super(key: key);

  @override
  _PikerMail createState() => new _PikerMail();
}


class _PikerMail extends State<CupertinoPickerMailStateful> {
  int _value = 0;
  int initvalue = 0;

  List<Widget> valList = <Widget>[];
  List<String> svalList = <String>[];
  List<String> tvalList = <String>[];

  bool init = false;

  @override
  Widget build(BuildContext context) {
    valList.clear();
    svalList.clear();
    tvalList.clear();

    valList.add(Text("Demande administrative", style: gColors.bodySaisie_N_G,));
    tvalList.add("demande_administrative");
    svalList.add("0");
    valList.add(Text("Demande technique", style: gColors.bodySaisie_N_G,));
    tvalList.add("demande_technique");
    svalList.add("1");
    valList.add(Text("Réclamation", style: gColors.bodySaisie_N_G,));
    tvalList.add("reclamation");
    svalList.add("2");


    _value = initvalue;

    widget.wControllerMail.text = "${tvalList[_value]}";

    init = true;

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 100,
            child: CupertinoPicker(
              //magnification: 1.22,
              //squeeze: 1.2,
              //useMagnifier: true,

              scrollController:
              FixedExtentScrollController(initialItem: initvalue),
              backgroundColor: Colors.white,
              itemExtent: 30,
              children: valList,
              onSelectedItemChanged: (value) {
                setState(() {
                  _value = value;
                  widget.wControllerMail.text = "${tvalList[value]}";
                  gColors.RetMailDem  = "${tvalList[value]}";
                  print("widget.wControllerMail.text ${widget.wControllerMail.text }");
                });
              },
            ),
          ),
          Container(height: 10),
        ]);
  }
}

class TimerStateful extends StatefulWidget {
  const TimerStateful(
      {Key? key,
      required this.aController,
      required this.minInterv,
      required this.aIcon})
      : super(key: key);

  final TextEditingController aController;
  final int minInterv;
  final int aIcon;
  @override
  _State9 createState() => new _State9();
}

//State is information of the application that can change over time or when some actions are taken.
class _State9 extends State<TimerStateful> {
  int value = 0;
  DateTime _valueL = DateTime(2000, 01, 01, 0);
  int aIcon = 0;

  @override
  Widget build(BuildContext context) {
    value = int.parse(widget.aController.text);
    aIcon = widget.aIcon;
    Duration duration = Duration(hours: 0, minutes: value);

    return Container(
        child: Column(children: [
      Container(height: 10),
      Text(
        "${duration.inHours} h ${duration.inMinutes.remainder(60)} min",
        style: gColors.bodyTitle1_B_P,
      ),
      Container(
        height: 120,
        child: SfSliderTheme(
          data: SfSliderThemeData(
            overlayColor: Colors.deepPurpleAccent,
            activeTrackHeight: 2.0,
            inactiveTrackHeight: 2.0,
            activeTrackColor: gColors.LinearGradient3,
            inactiveTrackColor: gColors.LinearGradient3,
            thumbColor: gColors.transparent,
            tooltipBackgroundColor: gColors.primary,
            tooltipTextStyle: TextStyle(
              color: gColors.white,
            ),
            thumbRadius: 53,
          ),
          child: SfSlider(
            min: DateTime(2000, 01, 01, 00),
            max: DateTime(2000, 01, 01, 3),
            value: _valueL,
            interval: 20,
            showTicks: false,
            showLabels: false,
            enableTooltip: false,
            shouldAlwaysShowTooltip: false,
            thumbIcon: Column(
              children: [
                Container(height: 1),
                Image.asset(
                  'assets/images/Cont${aIcon}a.png',
                  height: 104,
                  width: 50,
                ),
              ],
            ),
            dateFormat: DateFormat.Hm(),
            dateIntervalType: DateIntervalType.years,
            onChanged: (dynamic value) {
              setState(() {
                _valueL = value;

                Duration bDur =
                    Duration(hours: _valueL.hour, minutes: _valueL.minute);
                widget.aController.text = "${bDur.inMinutes}";

                print("widget.bDur ${bDur.inMinutes}");
              });
            },
          ),
        ),
      ),
    ]));
  }
}

class CupertinoTimerStateful extends StatefulWidget {
  const CupertinoTimerStateful(
      {Key? key, required this.aController, required this.minInterv})
      : super(key: key);

  final TextEditingController aController;
  final int minInterv;
  @override
  _State3 createState() => new _State3();
}

//State is information of the application that can change over time or when some actions are taken.
class _State3 extends State<CupertinoTimerStateful> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    value = int.parse(widget.aController.text);

    Duration duration = Duration(hours: 0, minutes: value);

    return Column(
/*
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
*/
        children: [
          Container(height: 10),
          Text(
            "${duration.inHours} h ${duration.inMinutes.remainder(60)} min",
            style: gColors.bodyTitle1_B_P,
          ),
          Container(height: 10),
          Container(
              height: 100,

//              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                initialTimerDuration: duration,
                minuteInterval: widget.minInterv,
                onTimerDurationChanged: (Duration newDuration) {
                  duration = newDuration;
                  setState(() {
                    widget.aController.text = "${duration.inMinutes}";
                  });
                },
              ))
        ]);
  }
}

class CupertinoTimerStateful2 extends StatefulWidget {
  CupertinoTimerStateful2(
      {Key? key, required this.aController, required this.duration})
      : super(key: key);

  final TextEditingController aController;

  Duration duration;
  @override
  _State4 createState() => new _State4();
}

//State is information of the application that can change over time or when some actions are taken.
class _State4 extends State<CupertinoTimerStateful2> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 10),
          Container(
              height: 100,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                minuteInterval: 15,
                initialTimerDuration: widget.duration,
                onTimerDurationChanged: (Duration newDuration) {
                  setState(() {
                    widget.duration = newDuration;
                    widget.aController.text = "${newDuration.inMinutes}";
                  });
                },
              ))
        ]);
  }
}

class NuitStateful extends StatefulWidget {
  NuitStateful(
      {Key? key,
      required this.aDur,
      required this.bDur,
      required this.aController})
      : super(key: key);

  TextEditingController aController;
  Duration aDur;
  Duration bDur;
  @override
  _State6 createState() => new _State6();
}

//State is information of the application that can change over time or when some actions are taken.
class _State6 extends State<NuitStateful> {
  Duration wDifDur(Duration aDur, Duration bDur) {
    Duration rDur = aDur;

    if (aDur < bDur)
      rDur = bDur - aDur;
    else {
      rDur = Duration(hours: 24) - aDur + bDur;
    }
    return rDur;
  }

  @override
  Widget build(BuildContext context) {
    Duration dDur;

    dDur = wDifDur(widget.aDur, widget.bDur);
    widget.aController.text = "${dDur.inMinutes}";

    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      "HEURE COUCHER",
                      style: gColors.bodyText_B_G,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      TextEditingController aController =
                          TextEditingController();
                      await showTimeDialog(
                          context, "HEURE COUCHER", widget.aDur, aController);
                      widget.aDur =
                          Duration(minutes: int.parse(aController.text));
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: gColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      width: 80,
                      child: Center(
                        child: Text(
                          "${widget.aDur.inHours}h${widget.aDur.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                          style: gColors.bodyText_B_G,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ]),
            Container(
              height: 10,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Text(
                      "HEURE LEVER",
                      style: gColors.bodyText_B_G,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      TextEditingController aController =
                          TextEditingController();
                      await showTimeDialog(
                          context, "HEURE LEVER", widget.bDur, aController);
                      widget.bDur =
                          Duration(minutes: int.parse(aController.text));
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: gColors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                      ),
                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                      width: 80,
                      child: Center(
                        child: Text(
                          "${widget.bDur.inHours}h${widget.bDur.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                          style: gColors.bodyText_B_G,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ]),
            Container(height: 10),
            Text(
              "B Vous avez dormi ${dDur.inHours}h${dDur.inMinutes.remainder(60).toString().padLeft(2, '0')}",
              style: gColors.bodyTitle1_B_Pr,
            ),
            Container(height: 10),
          ]),
    );
  }

  static Future showTimeDialog(BuildContext context, String Titre,
      Duration aDuration, TextEditingController aController) async {
    return await showDialog(
        context: context,
        builder: (context) => Center(
              child: Material(
                color: Colors.white,
                child: Container(
                  width: 300,
                  height: 250,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Titre,
                          style: gColors.bodyText_B_G,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          height: 20,
                        ),
                        CupertinoTimerStateful2(
                          aController: aController,
                          duration: aDuration,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: gColors.secondary,
                            padding: const EdgeInsets.all(12),
                          ),
                          child: Text(
                            "OK",
                            style: gColors.bodyText_B_W,
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () async {
                            print("aController ${aController.text} ");

                            Navigator.pop(context);
                          },
                        )
                      ]),
                ),
              ),
            ));
  }
}

class NuitStatefulV3 extends StatefulWidget {
  NuitStatefulV3(
      {Key? key,
      required this.aDur,
      required this.bDur,
      required this.aController})
      : super(key: key);

  TextEditingController aController;
  Duration aDur;
  Duration bDur;
  @override
  _State7 createState() => new _State7();
}

//State is information of the application that can change over time or when some actions are taken.
class _State7 extends State<NuitStatefulV3> {
  DateTime _valueC = DateTime(2000, 01, 01, 22);
  DateTime _valueL = DateTime(2000, 01, 01, 7);

  Duration wDifDur(Duration aDur, Duration bDur) {
    Duration rDur = aDur;

    if (aDur < bDur)
      rDur = bDur - aDur;
    else {
      rDur = Duration(hours: 24) - aDur + bDur;
    }
    return rDur;
  }

  @override
  Widget build(BuildContext context) {
    Duration dDur;

    if (widget.aDur > Duration(hours: 12))
      {
        print("Adur Soir  ${wDifDur(widget.aDur, Duration(hours: 00))}");
        dDur = wDifDur(widget.aDur, Duration(hours: 00)) + wDifDur(Duration(hours: 00), widget.bDur );
      }
    else {
      print("Adur Nuit");
      dDur = wDifDur(widget.aDur, widget.bDur);
    }


  print("Dur ${dDur.inMinutes} ${dDur.inHours}h${dDur.inMinutes.remainder(60).toString().padLeft(2, '0')} ${widget.aDur} ${widget.bDur}");


  widget.aController.text = "${dDur.inMinutes}";

  return Container(
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          gNewWidget.RoundedTitleSmall(context, "MON TEMPS DE SOMMEIL\n${dDur.inHours}h${dDur.inMinutes.remainder(60).toString().padLeft(2, '0')}"),
          SizedBox(height: 20.0),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: //SliderStatefulV3(aController: widget.aController, aCoucher: true),),
                    Padding(
                        padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
//            color: Colors.greenAccent,
                              child: SfSliderTheme(
                                data: SfSliderThemeData(
                                  activeTrackHeight: 2.0,
                                  inactiveTrackHeight: 2.0,
                                  activeTrackColor: Colors.black,
                                  inactiveTrackColor: Colors.grey,
                                  thumbColor: gColors.transparent,
                                  thumbRadius : 20,

                                  tooltipBackgroundColor: gColors.primary,
                                  tooltipTextStyle: TextStyle(
                                    color: gColors.white,
                                  ),
                                ),
                                child: SfSlider(
                                  min: DateTime(2000, 01, 01, 19),
                                  max: DateTime(2000, 01, 02, 02),
                                  value: _valueC,
                                  stepDuration: SliderStepDuration(minutes: 15),
                                  showTicks: false,
                                  showLabels: false,
                                  enableTooltip: true,
                                  shouldAlwaysShowTooltip: true,
                                  thumbIcon: Icon(
                                    Icons.nightlight,
                                    color: Colors.amberAccent,
                                    size: 40.0,
                                  ),
                                  dateFormat: DateFormat.Hm(),
                                  dateIntervalType:
                                  DateIntervalType.years,
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      _valueC = value;
                                      widget.aDur = Duration(
                                          hours: _valueC.hour,
                                          minutes: _valueC.minute);

                                      print(
                                          "widget.aDur ${widget.aDur.inMinutes}");
                                    });
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Icon(
                                Icons.nightlight,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(
                                Icons.light_mode,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          ],
                        )))
              ]),
          Container(
            height: 30,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(20, 25, 20, 0),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Container(
//            color: Colors.greenAccent,
                              child: SfSliderTheme(
                                data: SfSliderThemeData(
                                  activeTrackHeight: 2.0,
                                  inactiveTrackHeight: 2.0,
                                  activeTrackColor: Colors.black,
                                  inactiveTrackColor: Colors.grey,
                                  thumbColor: gColors.transparent,
                                  thumbRadius : 20,
                                  tooltipBackgroundColor: gColors.primary,
                                  tooltipTextStyle: TextStyle(
                                    color: gColors.white,
                                  ),

                                ),
                                child: SfSlider(
                                  min: DateTime(2000, 01, 01, 03),
                                  max: DateTime(2000, 01, 01, 12),
                                  value: _valueL,
                                  stepDuration: SliderStepDuration(minutes: 15),
                                  showTicks: false,
                                  showLabels: false,
                                  enableTooltip: true,
                                  shouldAlwaysShowTooltip: true,
                                  thumbIcon: Icon(
                                    Icons.light_mode,
                                    color: Colors.amberAccent,
                                    size: 40.0,
                                  ),
                                  dateFormat: DateFormat.Hm(),
                                  dateIntervalType: DateIntervalType.years,
                                  onChanged: (dynamic value) {
                                    setState(() {
                                      _valueL = value;
                                      widget.bDur = Duration(
                                          hours: _valueL.hour,
                                          minutes: _valueL.minute);

                                      print(
                                          "widget.bDur ${widget.bDur.inMinutes}");

                                      //widget.aController.text = "${_valueL}";
                                    });
                                  },
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Icon(
                                Icons.light_mode,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Icon(
                                Icons.nightlight,
                                color: Colors.black,
                                size: 20.0,
                              ),
                            ),
                          ],
                        ))),
              ]),
/*
          Container(height: 5),
          Text(
            "Vous avez dormi ${dDur.inHours}h${dDur.inMinutes.remainder(60).toString().padLeft(2, '0')}",
            style: gColors.bodyTitle1_B_Pr,
          ),
*/
          Container(height: 10),
        ]),
  );
}



  }


class SliderContextStatefulV3 extends StatefulWidget {
  SliderContextStatefulV3(
      {Key? key, required this.aDur, required this.aController})
      : super(key: key);

  TextEditingController aController;
  Duration aDur;

  @override
  _State10 createState() => new _State10();
}

//State is information of the application that can change over time or when some actions are taken.
class _State10 extends State<NuitStatefulV3> {
  DateTime _valueC = DateTime(2000, 01, 01, 00);

  Duration wDifDur(Duration aDur, Duration bDur) {
    Duration rDur = aDur;

    if (aDur < bDur)
      rDur = bDur - aDur;
    else {
      rDur = Duration(hours: 24) - aDur + bDur;
    }
    return rDur;
  }

  @override
  Widget build(BuildContext context) {
    Duration dDur;

    dDur = wDifDur(widget.aDur, widget.bDur);
    widget.aController.text = "${dDur.inMinutes}";

    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gNewWidget.RoundedTitleSmall(context, "MON TEMPS DE SOMMEIL"),
            SizedBox(height: 8.0),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: //SliderStatefulV3(aController: widget.aController, aCoucher: true),),
                          Padding(
                              padding: EdgeInsets.fromLTRB(20, 40, 20, 0),
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Expanded(
                                    child: Container(
//            color: Colors.greenAccent,
                                      child: SfSliderTheme(
                                        data: SfSliderThemeData(
                                          activeTrackHeight: 2.0,
                                          inactiveTrackHeight: 2.0,
                                          activeTrackColor: Colors.black,
                                          inactiveTrackColor: Colors.grey,
                                          thumbColor: gColors.transparent,
                                          tooltipBackgroundColor:
                                              gColors.primary,
                                          tooltipTextStyle: TextStyle(
                                            color: gColors.white,
                                          ),
                                        ),
                                        child: SfSlider(
                                          min: DateTime(2000, 01, 01, 00),
                                          max: DateTime(2000, 01, 01, 24),
                                          value: _valueC,
                                          interval: 20,
                                          showTicks: false,
                                          showLabels: false,
                                          enableTooltip: true,
                                          shouldAlwaysShowTooltip: true,
                                          thumbIcon: Icon(
                                            Icons.nightlight,
                                            color: Colors.amberAccent,
                                            size: 20.0,
                                          ),
                                          dateFormat: DateFormat.Hm(),
                                          dateIntervalType:
                                              DateIntervalType.years,
                                          onChanged: (dynamic value) {
                                            setState(() {
                                              _valueC = value;
                                              widget.aDur = Duration(
                                                  hours: _valueC.hour,
                                                  minutes: _valueC.minute);

                                              print(
                                                  "widget.aDur ${widget.aDur.inMinutes}");
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Icon(
                                      Icons.nightlight,
                                      color: Colors.black,
                                      size: 20.0,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerEnd,
                                    child: Icon(
                                      Icons.nightlight,
                                      color: Colors.black,
                                      size: 20.0,
                                    ),
                                  ),
                                ],
                              )))
                ]),
          ]),
    );
  }


}
