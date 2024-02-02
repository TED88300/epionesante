import 'dart:async';

import 'package:epionesante/Tools/DbTools.dart';
import 'package:epionesante/Tools/gColors.dart';
import 'package:epionesante/Tools/shared_pref.dart';
import 'package:epionesante/Widget/1-login.dart';
import 'package:epionesante/Widget/Medecin/M_Patients.dart';
import 'package:epionesante/Widget/Medecin/M_Patients_Ext.dart';
import 'package:epionesante/Widget/Medecin/M_Patients_Notif.dart';
import 'package:epionesante/Widget/Patient/P_Contact.dart';
import 'package:epionesante/Widget/Patient/P_Histo.dart';
import 'package:epionesante/Widget/Patient/P_Mesures_V3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver
{
  bool isChecked = false;

  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';
  late BuildContext ctx;

  String Alerte_nb = "";

  List<String> P_itemsTitre = <String>[
//    "RECOMPENCES",
    "RELEVE MESURES",
    "HISTORIQUE",
    "NOTIFICATIONS",
  ];

  List<Widget> P_children = [
//    P_Rec(),
    P_Mesures_V3(),
    P_Histo(),
    P_Contact(),
//    P_Compte(),
  ];

  List<BottomNavigationBarItem> P_itemsNav = <BottomNavigationBarItem>[

    BottomNavigationBarItem(
      icon: new Image.asset('assets/images/mnu_add.png',height: 36,width: 36,),
      activeIcon: new Image.asset('assets/images/mnu_add.png',height: 36,width: 36, color: gColors.primary,),
      label: '',

    ),
    BottomNavigationBarItem(
      icon: new Image.asset('assets/images/mnu_histo.png',height: 36,width: 36,),
      activeIcon: new Image.asset('assets/images/mnu_histo.png',height: 36,width: 36, color: gColors.primary,),
      label: '',

    ),
    BottomNavigationBarItem(
      icon: new Image.asset('assets/images/mnu_contact.png',height: 36,width: 36,),
      activeIcon: new Image.asset('assets/images/mnu_contact.png',height: 36,width: 36, color: gColors.primary,),
      label: '',

    ),



  ];

  List<String> M_itemsTitre = <String>[
    "EXTRACTION",
    "LISTE PATIENTS",
    "NOTIFICATIONS",

  ];

  List<Widget> M_children = [

    M_Patients_Ext(),
//    M_ListeSel(),
    M_Patients(),
    M_Patients_Notif(),

  ];

  List<BottomNavigationBarItem> M_itemsNav = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.file_download),
      label: 'Extraction',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.bloodtype),
      label: 'Patients',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list_alt),
      label: 'Patients',
    ),

  ];

  @override
  void initLib() async {
    if (DbTools.gIsMedecinLogin)
      {
        print("------------------ gIsMedecinLogin ------------------------");
      }
    else
      {
        print("------------------ ApiSrv_Patient_Contact ------------------------");
        await DbTools.ApiSrv_Patient_Contact(DbTools.gApiID, DbTools.gApiPassword);
      }

//    final firebaseMessaging = FCM();
/*
    firebaseMessaging.setNotifications();
    WidgetsBinding.instance.addObserver(this);

    firebaseMessaging.MsgNotifCtlr.stream.listen((value) {
      AffMessage(value.title, value.body);
    });

    await FirebaseMessaging.instance.getToken().then((token) {
      DbTools.ApiSrv_User_setNotification_Token(DbTools.gApiID, DbTools.gApiPassword, token!);
      print("Token_FBM $token");
    });

*/

    await reload();
  }

  @override
  Future reload() async {
    if (DbTools.gIsMedecinLogin)
    {
      await DbTools.ApiSrv_user_medecin_get_nb_patients_en_alerte(DbTools.gApiID, DbTools.gApiPassword);
      Alerte_nb = DbTools.nb_Patient_Alerte.nb!;
      FlutterAppBadger.removeBadge();
      int iAlerte_nb = 0;
      iAlerte_nb = int.tryParse(Alerte_nb)!;
      if (iAlerte_nb > 0)
        FlutterAppBadger.updateBadgeCount(iAlerte_nb);

      print(">>>>>>>>>>>>>> nb_Patient_Alerte ${DbTools.nb_Patient_Alerte.nb}");

      M_itemsNav = <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.file_download),
          label: 'Extraction',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bloodtype),
          label: 'Patients',
        ),
        Alerte_nb.length == 0 || Alerte_nb.compareTo("0") == 0 ?
        BottomNavigationBarItem(
          label: 'Patients',
          icon: Icon(Icons.list_alt),
        )
        :
        BottomNavigationBarItem(
          icon: Badge(
            label: Text("${DbTools.nb_Patient_Alerte.nb}"),
            child: Icon(Icons.list_alt),
          ),
          label: 'Notifications',
        ),
      ];

    }

    setState(() {});
  }

 /* @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) await reload();

    //   print(">>>>>>>>>>>>>>>>>>>>>>>>>>>> didChangeAppLifecycleState ${state.toString()}");
  }
*/
  void onBackPress() {
    if (Navigator.of(ctx).canPop()) {
      Navigator.of(ctx).pop();
    }
  }

  @override
  void dispose() {
  //  WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void initState() {

    if (DbTools.gIsMedecinLogin)
      DbTools.gCurrentIndex = 1;
    else
      {
        DbTools.gCurrentIndex = 0;
      }

/*
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    WidgetsBinding.instance!.addObserver(this);

    firebaseMessaging.MsgNotifCtlr.stream.listen((value) {
      AffMessage(value.title, value.body);
    });
*/

    FlutterAppBadger.removeBadge();

    super.initState();
    initLib();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Block_MenuApp(context);
  }

  @override
  Widget Block_MenuApp(BuildContext context) {
    String title_string = DbTools.gIsMedecinLogin
        ? M_itemsTitre[DbTools.gCurrentIndex]
        : P_itemsTitre[DbTools.gCurrentIndex];
    Widget wchildren = DbTools.gIsMedecinLogin
        ? M_children[DbTools.gCurrentIndex]
        : P_children[DbTools.gCurrentIndex];

    print("t : ${DbTools.gIsMedecinLogin} ${title_string}");

    return Scaffold(
      resizeToAvoidBottomInset: false,
      //    endDrawer: DbTools.gIsMedecinLogin! ? C_SideDrawer() : I_SideDrawer(),

      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title:
        Container(
          color: Colors.white,
          child: Image.asset("assets/images/Icot.png", fit: BoxFit.fitHeight,
            height: 50,
          ),
        ),

        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () async {
              await SharedPref.setStrKey("username", "");
              await SharedPref.setStrKey("password", "");
              await SharedPref.setBoolKey("IsRememberLogin", false);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],

        backgroundColor: gColors.white,
      ),
      body: wchildren,
      bottomNavigationBar: BottomAppBar(
        color: gColors.white,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin: 5,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: gColors.primary,
          unselectedItemColor: gColors.TextColor2,

          currentIndex: DbTools.gCurrentIndex,
          onTap: (int index) async{
            FocusScope.of(context).unfocus();
            await reload();
            setState(() {
              DbTools.gCurrentIndex = index;
            });
          },
          items: DbTools.gIsMedecinLogin ? M_itemsNav : P_itemsNav,
        ),
      ),
     /* floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Visibility(
        visible: !DbTools.gIsMedecinLogin,
        child: FloatingActionButton(
          backgroundColor: gColors.primary,
          child:  Icon(Icons.add, color: (DbTools.gCurrentIndex == 2) ? Colors.white : gColors.secondaryF2),
          onPressed: () {
            setState(() { DbTools.gCurrentIndex = 1;});
          },
        ),
      ),*/
    );
  }

  void AffMessage(String title, String body) {
    print('AffMessage');

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: Column(
                  //Slide3
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/AppIco.png'),
                      height: 50,
                    ),
                    SizedBox(height: 8.0),
                    Container(color: Colors.grey, height: 1.0),
                    SizedBox(height: 8.0),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ]),
              content: Text(body),
              actions: <Widget>[
                ElevatedButton(
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  onPressed: () async {
                    await reload();

                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }
}
