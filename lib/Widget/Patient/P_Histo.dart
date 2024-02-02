import 'dart:math';

//import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toggle_switch/toggle_switch.dart';

class P_Histo extends StatefulWidget {
  @override
  P_HistoState createState() => P_HistoState();
}

class P_HistoState extends State<P_Histo> {
  late TooltipBehavior _tooltipBehavior;

  late GlobalKey<State> chartKey;

  late List<String> _zoomModeTypeList;
  late String _selectedModeType;
  late ZoomMode _zoomModeType;
  late bool _enableAnchor;

  bool contextVal = false;

  DateTime cData1_dt = DateTime.now();

  List<String> listDatesToggleSwitch = [];
  int indDateTF = 0;

  List<String> listDatasToggleSwitch = [];
  int indDataTF = 0;

  List<String> tags = [];

  // list of string options
  List<String> options = [];

  List<List<ChartData>> cDataAll = [];
  List<String> cDataAllLib = [];
  List<String> cDataAllUnit = [];
  List<double> cDataAllMin = [];
  List<double> cDataAllMax = [];

  List<ChartData> cData1 = [];
  List<ChartData> cData2 = [];
  List<ChartData> cDataC = [];

  String cData1Lib = "";
  String cData2Lib = "";
  String cData1Unit = "";
  String cData2Unit = "";

  double cData1_Min = 0;
  double cData1_Max = 0;
  double cData2_Min = 0;
  double cData2_Max = 0;
  double cDataC_Min = 0;
  double cDataC_Max = 0;

  late ZoomPanBehavior _zoomPan;

  String chartData4Unit = "---";

  final List<ChartData> chartData4 = [];

  dynamic wSeries = <ChartSeries<ChartData, DateTime>>[];

  @override
  void initLib() async {
    print("ApiSrv_patient_getdonnees>");

    tags.add("Saturation");
    tags.add("Poids");

    await DbTools.ApiSrv_patient_getdonnees(DbTools.api_User_Info.idPatient!);
/*
    DbTools.patient_donneesList.forEach((item) {
      print(       "patient_donneesList ${item.date} ${item.codeDonnee}   ${item.valeurDonnee}");
    });
*/
    await alimData();
    setData();
    print("cData1 ${cData1.length}");
    if(cData1.length >= 5)
      cData1_dt = cData1[cData1.length - 5].x;
    else if(cData1.length > 0)
      cData1_dt = cData1[0].x;



    setState(() {});
  }

  Future alimData() async {
    cDataAll.clear();
    cDataAllLib.clear();
    cDataAllUnit.clear();
    cDataAllMin.clear();
    cDataAllMax.clear();
    options.clear();

    chartData4.clear();

    await DbTools.ApiSrv_patient_appareils(DbTools.api_User_Info.idPatient!);

    List<DonneesContexte>? donneesContexte;

    DbTools.patient_contextesList.forEach((element) {
      donneesContexte = element.donneesContexte!;
    });

    if (DbTools.patient_appareilsList.length > 0) {
      List<Appareils>? appareils = DbTools.patient_appareilsList;

      appareils.forEach((item) {
        if (item.paramMobile != null) {
          if (item.paramMobile?.donnees != null) {
            item.paramMobile?.donnees!.forEach((donnee) {
              print("donnee ${donnee.code}");

              List<ChartData> cDataTmp = [];

              cData1_Min = 999999;
              cData1_Max = -999999;

              DbTools.patient_donneesList.forEach((item) {
                if (donnee.code == item.codeDonnee && double.parse(item.valeurDonnee!) > 0) {

                  print("DateTime.parse(item.date!) ${DateTime.parse(item.date!)}");
                  ChartData ChartDataTmp = ChartData(DateTime.parse(item.date!),
                      double.parse(item.valeurDonnee!));
                  cData1_Min =
                      min(cData1_Min, double.parse(item.valeurDonnee!));
                  cData1_Max =
                      max(cData1_Max, double.parse(item.valeurDonnee!));
                  cDataTmp.add(ChartDataTmp);

                  if (item.valeurContexte! != "") {
                    donneesContexte!.forEach((edonneesContexte) {
                      if (item.donneeContexte!
                              .compareTo(edonneesContexte.code!) ==
                          0) {
                        double valeurContexte =
                            double.parse(item.valeurContexte!);
                        double wdVC =
                            valeurContexte * edonneesContexte.coefMet!;
                        item.valeurContexte = "${wdVC}";
                        //    print("donnee contexte ${edonneesContexte.code} $valeurContexte ${item.valeurContexte} ${edonneesContexte.coefMet}");
                      }
                    });

                    ChartData ChartData4Tmp = ChartData(
                        DateTime.parse(item.date!),
                        double.parse(item.valeurContexte!));
                    chartData4.add(ChartData4Tmp);
                  }
                }
              });

              cData1_Min -= cData1_Min / 50;
              cData1_Max += cData1_Max / 50;

              cData1_Min = cData1_Min.roundToDouble();
              cData1_Max = cData1_Max.roundToDouble();

              cDataAll.add(cDataTmp);
              cDataAllLib.add(donnee.libelle!);
              cDataAllUnit.add(donnee.unite!);

              cDataAllMin.add(cData1_Min);
              cDataAllMax.add(cData1_Max);

              options.add(donnee.libelle!);
            });
          }
        }
      });
    }
  }


  static int xSortComparison(ChartData a, ChartData b) {
    final ChartDataA = a.x;
    final ChartDataB = b.x;
    if (ChartDataA.compareTo(ChartDataB) < 0) {
      return -1;
    } else if (ChartDataA.compareTo(ChartDataB) > 0) {
      return 1;
    } else {
      return 0;
    }
  }


  void setData() {
    wSeries = <ChartSeries<ChartData, DateTime>>[];
    int i = 0;
    tags.forEach((item) {
      print("tags $item");

      List<ChartData> aData = [];
      String aDataLib = "";
      String aDataUnit = "";

      double aDataMin = 0;
      double aDataMax = 0;

      int wSet = 0;
      cDataAllLib.forEach((sLib) {
        if (item == sLib) {
          print("Sel $item");

          aData = cDataAll[wSet];
          aDataLib = cDataAllLib[wSet];
          aDataUnit = cDataAllUnit[wSet];
          aDataMin = cDataAllMin[wSet];
          aDataMax = cDataAllMax[wSet];
        }
        wSet++;
      });

      if (i == 0) {
        setData1(aData, aDataLib, aDataUnit);
        cData1_Min = aDataMin;
        cData1_Max = aDataMax;

        if (cData1Lib.contains("Poids")) {
          var ls = LineSeries<ChartData, DateTime>(
            dataSource: cData1,
            color: gColors.primaryTr,
            animationDuration: 2500,
            name: cData1Lib,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            xAxisName: "Date",
            yAxisName: "yAxis1",
          );
          wSeries.add(ls);
          print("wSeries 1");
        } else {
          var ls = LineSeries<ChartData, DateTime>(
            dataSource: cData1,
            color: gColors.primaryTr,
            animationDuration: 2500,
            name: cData1Lib,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            xAxisName: "Date",
            yAxisName: "yAxis1",
          );
          wSeries.add(ls);
          print("wSeries 1");
        }
      } else if (i == 1) {
        setData2(aData, aDataLib, aDataUnit);
        cData2_Min = aDataMin;
        cData2_Max = aDataMax;

        if (cData2Lib.contains("Poids")) {
          var ls = LineSeries<ChartData, DateTime>(
            dataSource: cData2,
            color: gColors.secondaryTr,
            animationDuration: 2500,
            name: cData2Lib,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            xAxisName: "Date",
            yAxisName: "yAxis2",
          );
          wSeries.add(ls);
          print("wSeries 2");
        } else {
          var ls = LineSeries<ChartData, DateTime>(
            dataSource: cData2,
            color: gColors.secondaryTr,
            animationDuration: 2500,
            name: cData2Lib,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
            xAxisName: "Date",
            yAxisName: "yAxis2",
          );
          wSeries.add(ls);
          print("wSeries 2");
        }
      }

      i++;
    });

    if (contextVal) {
      cDataC_Min = 999999;
      cDataC_Max = -999999;

      cDataC.clear();

      chartData4.forEach((item) {
        cDataC_Min = min(cDataC_Min, item.y);
        cDataC_Max = max(cDataC_Max, item.y);
      });

      cDataC_Min -= cDataC_Min / 50;
      cDataC_Max += cDataC_Max / 50;

      cDataC_Min = cDataC_Min.roundToDouble();
      cDataC_Max = cDataC_Max.roundToDouble();

      print("contextVal cDataC_Min $cDataC_Min $cDataC_Max");

      double d1 = (cData1_Max - cData1_Min);
      double dC = (cDataC_Max - cDataC_Min);

      double v1C = 1;
      if (d1 > 0) v1C = dC / d1 * 2;

      print("contextVal v1C $dC $d1 $v1C");



      chartData4.sort(xSortComparison);

      chartData4.forEach((itemc) {
        ChartData w = ChartData(itemc.x, itemc.y);
//        w.y = itemc.y / v1C + cData1_Min ;
               print("w.y ${w.x} ${w.y}");
        cDataC.add(w);
      });

      var ls = LineSeries<ChartData, DateTime>(
        dataSource: cDataC,
        color: Color(0xFFf9E1f9),
        animationDuration: 2500,
        name: "Effort",
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        xAxisName: "Date",
        yAxisName: "yAxisC",
      );
      wSeries.insert(0, ls);
      print("contextVal");
    }
  }

  void setData1(List<ChartData> aData, String aDataLib, String aDataUnit) {
    cData1_Min = 999999;
    cData1_Max = -999999;

    cData1Lib = aDataLib;
    cData1Unit = aDataUnit;
    cData1.clear();
    cData1.addAll(aData);

    print("cData1_Min $cData1_Min $cData1_Max");
  }

  void setData2(List<ChartData> aData, String aDataLib, String aDataUnit) {
    cData2_Min = 999999;
    cData2_Max = -999999;

    cData2Lib = aDataLib;
    cData2Unit = aDataUnit;
    cData2.clear();
    cData2.addAll(aData);

    print("cData2_Min $cData2_Min $cData2_Max");
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(
      enable: true,
    );

    _zoomPan = ZoomPanBehavior(
      enableDoubleTapZooming: true,
      enablePanning: true,
      enablePinching: true,
//      zoomMode: ZoomMode.y,
      enableSelectionZooming: true,
    );

    listDatesToggleSwitch.add("J");
    listDatesToggleSwitch.add("S");
    listDatesToggleSwitch.add("M");

    chartKey = GlobalKey<State>();

    initLib();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            padding: EdgeInsets.all(8),
            color: gColors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
//                BtnTime(),
                Expanded(
                  child: buildchartDate(context),
                ),
                swContext(),
                SelData(),
                Container(
                  height: 40,
                ),
              ],
            )));
  }

  @override
  Widget BtnTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ToggleSwitch(
          initialLabelIndex: indDateTF,
          totalSwitches: listDatesToggleSwitch.length,
          labels: listDatesToggleSwitch,
          activeBgColor: [gColors.secondary],
          inactiveBgColor: gColors.primary,
          onToggle: (index) {
            indDateTF = index!;
            setData();
            setState(() {});
          },
        ),
      ],
    );
  }

  @override
  Widget swContext() {
    return Row(
      children: [
        Text(
          "Effort",
          style: gColors.bodyText_B_G,
        ),
        Spacer(),
        Switch(
          value: contextVal,
          onChanged: (value) {
            setState(() {
              contextVal = value;
              setData();
              setState(() {});
            });
          },
        ),
      ],
    );
  }

  @override
  Widget SelData() {
    return Container();
/*      ChipsChoice<String>.multiple(
      value: tags,
      onChanged: (val) => {
        setState(() {
          if (val.length <= 2) {
            tags = val;
            setData();
          }
        })
      },
      choiceItems: C2Choice.listFrom<String, String>(
        source: options,
        value: (i, v) => v,
        label: (i, v) => v,
      ),
      choiceStyle: C2ChoiceStyle(
        color: gColors.primary,
        borderColor: gColors.primary,
      ),
      choiceActiveStyle: C2ChoiceStyle(
        color: gColors.secondary,
        borderColor: gColors.secondary,
      ),

      wrapped: true,
//    textDirection: TextDirection.rtl,
    );*/
  }

  @override
  Widget buildchartDate(BuildContext context) {
    final double fontSize = 14 / MediaQuery.of(context).textScaleFactor;
    final double size = 13 / MediaQuery.of(context).textScaleFactor;

    final double containerWidth = 70;
    final double containerHeight = 60;

    return Scaffold(
        body: Container(
            height: 400,
            child: SfCartesianChart(
              key: chartKey,
              zoomPanBehavior: _zoomPan,
//                plotAreaBorderWidth: 0,

              primaryXAxis: DateTimeAxis(
                visibleMinimum: cData1_dt,
                name: 'X-Axis',
                majorGridLines: const MajorGridLines(width: 0),
                labelRotation: -45,
                dateFormat: DateFormat('dd/MM/yy HH:mm:ss'),
              ),
              /*primaryYAxis: NumericAxis(
                plotBands: [
                  PlotBand(
                      shouldRenderAboveSeries: true,
                      start: 89.9,
                      end: 90,
                      color: Colors.transparent,
                      opacity: 1,
                      dashArray: <double>[5, 5])
                ],
                name: 'yAxis1',
                numberFormat:
                    NumberFormat.compactCurrency(symbol: '', decimalDigits: 0),
                labelFormat: '{value}${cData1Unit}',
                minimum: cData1_Min,
                maximum: cData1_Max,
                labelPosition: ChartDataLabelPosition.inside,
                labelAlignment: LabelAlignment.center,
                tickPosition: TickPosition.inside,
              ),*/
              axes: <ChartAxis>[
                NumericAxis(
                  name: 'yAxis2',
                  numberFormat: NumberFormat.compactCurrency(
                      symbol: '', decimalDigits: 0),
                  labelFormat: '{value}${cData2Unit}',
                  opposedPosition: true,
                  minimum: cData2_Min,
                  maximum: cData2_Max,
                  labelPosition: ChartDataLabelPosition.inside,
                  labelAlignment: LabelAlignment.center,
                  tickPosition: TickPosition.inside,
                ),
                NumericAxis(
                  isVisible: false,
                  name: 'yAxisC',
                  labelFormat: '{value}',
                  minimum: cDataC_Min,
                  maximum: cDataC_Max,
                ),
              ],

              legend: Legend(
                isVisible: true,
                position: LegendPosition.top,
                offset: Offset(0, 0),
              ),
              series: wSeries,
              tooltipBehavior: _tooltipBehavior,
            )));
  }
}

class ChartData {
  ChartData(this.x, this.y);
  DateTime x;
  double y;
}

class TypeData {
  final int? id;
  final String? name;

  TypeData({
    this.id,
    this.name,
  });
}
