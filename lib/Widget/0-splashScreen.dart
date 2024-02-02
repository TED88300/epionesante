import 'dart:async';


import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/shared_pref.dart';
import 'package:epionesante/Widget/1-login.dart';
import 'package:epionesante/Widget/2-home.dart';
import 'package:epionesante/Widget/Patient/P_IntroMes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  var IsRememberLogin = false;
  var milliseconds = 2000;

  late AnimationController animationController;
  late Animation<double> animation;

  startTime() async
    {
    var _duration = new Duration(milliseconds: milliseconds);  //SetUp duration here
    return new Timer(_duration, navigationPage);
    }

  void navigationPage() async
    {
      DbTools.gPatientRGPD =  await SharedPref.getBoolKey("PatientRGPD", false);

      DbTools.gIsRememberLogin =  await SharedPref.getBoolKey("IsRememberLogin", false);
      DbTools.gIsMedecinLogin =  await SharedPref.getBoolKey("IsMedecinLogin", false);
      DbTools.gUsername = await SharedPref.getStrKey("username", "");
      DbTools.gPassword = await SharedPref.getStrKey("password", "");


      DbTools.gApiID = await SharedPref.getStrKey("ApiID", "");
      DbTools.gApiPassword = await SharedPref.getStrKey("ApiPassword", "");


      print(">>>>> ${DbTools.gIsRememberLogin} ${DbTools.gUsername} ${DbTools.gPassword} ");

      if (DbTools.gIsRememberLogin)
         DbTools.gIsRememberLogin = await DbTools.ApiSrv_User_Info(DbTools.gApiID, DbTools.gApiPassword);


      if (DbTools.gIsRememberLogin)
        if (DbTools.gIsMedecinLogin)
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
        else
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => P_IntroMes()));

      else
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
    }

  void initLib() async
    {
      print("DbTools.gVersion ${DbTools.gVersion}");
      DbTools.AffIntro = false;
      DbTools.packageInfo = await PackageInfo.fromPlatform();
      DbTools.gVersion = "V${DbTools.packageInfo.version} b${DbTools.packageInfo.buildNumber}";
      print("DbTools.gVersion ${DbTools.gVersion}");
      await DbTools.initSqlite();
    }

@override
  void initState() {
    super.initState();
    initLib();

    if (DbTools.gTED)
      {
        milliseconds = 800;
      }

    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();

    SystemChannels.textInput.invokeMethod('TextInput.hide');


    final double width = MediaQuery.of(context).size.width * 0.9;
    final double height = MediaQuery.of(context).size.height * 0.9;

    double w = animation.value * 700;
    double h = animation.value * 700;

    if (w > width) w = width;
    if (h > height) h = height;


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[

          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/images/AppIco.png',
                width: w,
                height: h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "EPIONE",
                    style: gColors.bodyTitle1_B_P,),
                  Text(
                    "Santé",
                    style: gColors.bodyTitle1_B_S,),

                ],),

            ],
          ),
        ],
      ),
    );
  }
}