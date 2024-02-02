import 'dart:convert';
import 'dart:developer';

import 'package:epionesante/Tools/ApiData.dart';
import 'package:epionesante/Tools/Appareil.dart';
import 'package:epionesante/Tools/Mesure.dart';
import 'package:epionesante/Tools/Patient.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

void prints(var s1) {
  String s = s1.toString();
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(s).forEach((match) => print(match.group(0)));
}

class DbTools {
  DbTools();
  static bool gTED = false;
  static var gVersion = "v1.0.46 b46";
  static bool gPatientRGPD = false;
  static int gCurrentIndex = 1;
  String Token_FBM = "";
  static bool gIsRememberLogin = true;
  static bool gIsMedecinLogin = true;

  static bool gIsAC = false;

  static bool AffIntro = false;
  static var gUsername = "";
  static var gPassword = "";

  static var gApiID = "";
  static var gApiPassword = "";
  static var database;

  static String Url = "185.98.136.238";
  static int gLastID = 0;
  static int gLastIDObj = 0;
  static String SrvUrl = "http://$Url/API_TWERP2.php";
  //  static String SrvUrl = "http://" + Url + "/API_TW2.php";
  static String SrvImg = "http://$Url/Img/";
  static String SrvTokenKey = "Ad2844Ze";
  static String SrvToken = "";

  static PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  static Future initSqlite() async {
//    var wgetDatabasesPath = await getDatabasesPath();

    var wgetDatabasesPath = (await getApplicationSupportDirectory()).path;

    print("getDatabasesPath() $wgetDatabasesPath");
    database = openDatabase(
      join(await getDatabasesPath(), "C22ze44Rdt.db"),
/*
      onCreate: (db, version) {
        print("onCreate $version");
        db.execute(
            "CREATE TABLE Contribuables(contribuableId INTEGER PRIMARY KEY, contribuable_name TEXT, contribuable_id TEXT, contribuable_type TEXT, contribuable_phone TEXT, contribuable_address TEXT, contribuable_mail TEXT, contribuable_natpiece TEXT, contribuable_cni TEXT, contribuable_Nais_Date TEXT, contribuable_Nais_Lieu TEXT, contribuable_Nais_Pays TEXT, contribuable_cniExp TEXT, contribuable_Genre TEXT,contribuable_Nationalite TEXT, contribuable_Tx_Total INTEGER, contribuable_Tx_Paye INTEGER, contribuable_MafaCard TEXT, contribuable_State TEXT, contribuable_Status INTEGER, contribuable_Regime TEXT, contribuable_RCCM TEXT, contribuable_date_validite_piece TEXT, contribuable_terminal TEXT, base64Encode TEXT, templateBytes TEXT)");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        print("onUpgrade $oldVersion $newVersion");

        //       if (newVersion == 2) {db.execute("ALTER TABLE Activites ADD COLUMN activite_type_taxe TEXT");}
      },
*/
      version: 1,
    );
  }

  static Future<bool> getUtilisateur(String aUtilisateur, String aMotdepasse) async {
    return true;
  }

  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  //*********************************************
  //*********************************************
  //*********************************************

  static List<Patient> ListPatient = [];

  static Future<bool> getPatientMed(int MedId) async {
    ListPatient.clear();
    ListPatient.add(Patient(0, "AARAB KARIMA", "259209938008054", "01/01/1959", "COURBEVOIE"));
    ListPatient.add(Patient(1, "AARAB MIMOUN", "140019938167410", "01/01/1940", "BEAUVAIS"));
    ListPatient.add(Patient(2, "AASSIME AMIRA", "280097511520745", "23/09/1980", "LE TILLEUL"));
    ListPatient.add(Patient(3, "ABABSA NOUA", "251039380555611", "21/03/1951", "CACHAN"));
    ListPatient.add(Patient(4, "DAUSSY ROBERT", "132055439510287", "10/05/1932", "L HAY LES ROSES"));
    ListPatient.add(Patient(5, "DAUSTRESIRE MARIE-THERESE", "243077631000630", "17/07/1943", "BIVILLE SUR MER"));
    ListPatient.add(Patient(6, "MEDAUS FRANCK", "160029941008625", "25/02/1960", "VILLETANEUSE"));
    ListPatient.add(Patient(7, "SAHA FARDAUSHI", "291039924600677", "01/03/1991", "LA GARENNE COLOMBES"));

    if (ListPatient == []) {
      return false;
    } else {
      return true;
    }
  }

  //*********************************************
  //*********************************************
  //*********************************************

  static List<Appareil> ListAppareil = [];

  static Future<bool> getAppareilPat(int PatId) async {
    ListAppareil.clear();
    ListAppareil.add(Appareil(0, "Zx80", "Podomètre"));
    ListAppareil.add(Appareil(1, "AS400", "Oxymètre"));
    ListAppareil.add(Appareil(2, "3090", "Pèse personne"));
    ListAppareil.add(Appareil(3, "PS2", "Tensiomètre"));

    if (ListAppareil == []) {
      return false;
    } else {
      return true;
    }
  }

  //*********************************************
  //*********************************************
  //*********************************************

  static List<Mesure> ListMesure = [];

  static Future<bool> getMesurePat(int PatId) async {
    ListMesure.clear();
    ListMesure.add(Mesure(0, "01/06/2022", 12, false));
    ListMesure.add(Mesure(1, "03/06/2022", 22, true));
    ListMesure.add(Mesure(2, "04/06/2022", 34, false));
    ListMesure.add(Mesure(3, "05/06/2022", 12, true));
    ListMesure.add(Mesure(4, "06/06/2022", 23, false));
    ListMesure.add(Mesure(5, "08/06/2022", 18, false));
    ListMesure.add(Mesure(6, "11/06/2022", 12, false));
    ListMesure.add(Mesure(7, "13/06/2022", 22, true));
    ListMesure.add(Mesure(8, "14/06/2022", 34, false));
    ListMesure.add(Mesure(9, "15/06/2022", 12, true));
    ListMesure.add(Mesure(10, "16/06/2022", 23, false));
    ListMesure.add(Mesure(11, "18/06/2022", 18, false));

    if (ListMesure == []) {
      return false;
    } else {
      return true;
    }
  }

//********************************************************
//********************************************************
//********************************************************

  static Api_Login api_login = Api_Login();

  static Future<bool> ApiSrv_Login(String aUtilisateur, String aMotdepasse) async {
    print("ApiSrv_Login  ${aUtilisateur} ${aMotdepasse}");

    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/login'));
    request.body = json.encode({"username": aUtilisateur, "password": aMotdepasse});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("login items  $items");

      if (items != null) {
        api_login = await Api_Login.fromJson(items);
        print("login ${api_login.role} ${api_login.nom} ${api_login.cryptedId} ${api_login.password}");

        await ApiSrv_User_Info(api_login.cryptedId, api_login.password);
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }

    return true;
  }

//********************************************************
//********************************************************
//********************************************************

  static Api_User_Info api_User_Info = Api_User_Info();

  static Future<bool> ApiSrv_User_Info(String id, String password) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-infos'));
    request.body = json.encode({"id": id, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_User_Info = await Api_User_Info.fromJson(items);
        print("User_Info ${api_User_Info.role} ${api_User_Info.nom} ${api_User_Info.medecinNom} AC2 ${api_User_Info.code_ac2}  ${api_User_Info.code_ac3}");

        DbTools.gIsAC = api_User_Info.code_ac2!.compareTo("02") == 0 || api_User_Info.code_ac2!.compareTo("03") == 0;

      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

//********************************************************
//********************************************************
//********************************************************

  static Patient_Contact api_Patient_Contact = Patient_Contact();

  static Future<bool> ApiSrv_Patient_Contact(String id, String password) async {
    print("ApiSrv_Patient_Contact ${id} ${password}");

    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-patient-get-contacts'));
    request.body = json.encode({"id": id, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Patient_Contact = await Patient_Contact.fromJson(items);
        print("Patient_Contact  ${api_Patient_Contact.telephonePharmacien}  ${api_Patient_Contact.telephoneAgence}");

        if ("${api_Patient_Contact.telephoneAgence}".compareTo("null") == 0) api_Patient_Contact.telephoneAgence = "";

        if ("${api_Patient_Contact.telephoneTechnicien}".compareTo("null") == 0) api_Patient_Contact.telephoneTechnicien = "";

        if ("${api_Patient_Contact.telephonePharmacien}".compareTo("null") == 0) api_Patient_Contact.telephonePharmacien = "";

        print("Patient_Contact  ${api_Patient_Contact.telephoneTechnicien!.isEmpty}");
      }
    } else {
      print("ApiSrv_Patient_Contact ERROR ${response.reasonPhrase}");
      return false;
    }
    return true;
  }

//********************************************************
//********************************************************
//********************************************************

//  {"id":"NwaOby3jxzg7pFXyaSNMElBCC9rGkPEj6aBv5bxdxeKmf418Hpi8idgPhA","password":"0848f80d242ceefa9a38d1b922f5ede2"}

  static List<Api_Patient> medecin_patientsList = [];
  static Api_Patient medecin_patients = Api_Patient();

  static Future<bool> ApiSrv_medecin_patients(String id, String password) async {
    print("id: $id password: $password");

    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/medecin-patients'));
    request.body = json.encode({"id": id, "password": password});
    request.headers.addAll(headers);

    print("request $request");
    print("headers $headers");
    print("body ${request.body}");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());

      prints("items $items");

      if (items != null) {
        List<Api_Patient> wmedecin_patientsList = items.map<Api_Patient>((json) {
          return Api_Patient.fromJson(json);
        }).toList();
        medecin_patientsList = wmedecin_patientsList;
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.toString());
      return false;
    }
    return true;
  }

//********************************************************
//********************************************************
//********************************************************

  static Nb_Patient_Alerte nb_Patient_Alerte = Nb_Patient_Alerte(nb: "");

  static Future<bool> ApiSrv_user_medecin_get_nb_patients_en_alerte(String id, String password) async {
    print("id: $id password: $password");

    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-medecin-get-nb-patients-en-alerte'));
    request.body = json.encode({"id": id, "password": password});
    request.headers.addAll(headers);

    print("request $request");
    print("headers $headers");
    print("body ${request.body}");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());

//      print("items $items");

      if (items != null) {
        nb_Patient_Alerte = await Nb_Patient_Alerte.fromJson(items);
//        nb_Patient_Alerte.nb = "0";
        // print("nb_Patient_Alerte ${nb_Patient_Alerte.nb}");
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.toString());
      return false;
    }
    return true;
  }

//********************************************************
//********************************************************
//********************************************************

  static Patient_Alerte api_Patient_Alerte = Patient_Alerte();

  static Future<bool> ApiSrv_Patient_Alerte(String id, String password) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-medecin-get-patients-en-alerte'));
    request.body = json.encode({"id": id, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("user-medecin-get-patients-en-alerte request.body ${request.body}");
    print("response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());

      if (items != null) {
        api_Patient_Alerte = await Patient_Alerte.fromJson(items);

      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.toString());
      return false;
    }
    return true;
  }

  static Future<bool> ApiSrv_Patient_Alerte_Reset(String id, String password) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-medecin-reset-patients-en-alerte'));
    request.body = json.encode({"id": id, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("user-medecin-get-patients-en-alerte request.body ${request.body}");
    print("response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {

    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.toString());
      return false;
    }
    return true;
  }



//********************************************************
//********************************************************
//********************************************************

  static List<Appareils> patient_appareilsList = [];
  static List<Contextes> patient_contextesList = [];
  static List<DonneesUserMedecinPatient> patient_donneesUserMedecinPatientList = [];

  static Future<bool> ApiSrv_patient_appareils(String id) async {
// TEDTED
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/patient-appareils-v2'));
    request.body = json.encode({"id": id, "with-fake-appareil": "non"});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());

      if (items != null) {
        Api_Appareil_V2 api_Appareil_V2 = await Api_Appareil_V2.fromJson(items);

        List<Appareils> wAppareilsList = api_Appareil_V2.appareils!.map<Appareils>((json) {
          return json;
        }).toList();

        patient_appareilsList = wAppareilsList;

        List<Contextes> wContextesList = api_Appareil_V2.contextes!.map<Contextes>((json) {
          return json;
        }).toList();

        patient_contextesList = wContextesList;

        List<DonneesUserMedecinPatient> wDonneesUserMedecinPatientList = api_Appareil_V2.donneesUserMedecinPatient!.map<DonneesUserMedecinPatient>((json) {
          return json;
        }).toList();

        patient_donneesUserMedecinPatientList = wDonneesUserMedecinPatientList;
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.toString());
      return false;
    }
    return true;
  }

//********************************************************
//********************************************************
//********************************************************

  static List<DonneesGet> patient_donneesList = [];

  static Future<bool> ApiSrv_patient_getdonnees(String id) async {
// TEDTED
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/patient-get-donnees'));
    request.body = json.encode({"id": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    print("patient-get-donnees request.body ${request.body}");
    print("response.statusCode ${response.statusCode}");

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());

      if (items != null) {
        Api_Donnees_Get api_Donnees_Get = await Api_Donnees_Get.fromJson(items);

        print("api_Donnees_Get.nb ${api_Donnees_Get.nb}");

        List<DonneesGet> wDonneesGetList = api_Donnees_Get.donneesGet!.map<DonneesGet>((json) {
          return json; // DonneesGet.fromJson(json);
        }).toList();
        patient_donneesList = wDonneesGetList;
      }
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      print(response.toString());
      return false;
    }
    return true;
  }

  static Future<bool> ApiSrv_patient_setdonnees(String id, String password, List<DonneesSet> listDonneesSet) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/patient-set-donnees'));
    request.body = json.encode({
      "id": id,
      "password": password,
      "donnees_set": listDonneesSet,
    });
    request.headers.addAll(headers);

//    DbTools.printWrapped("request.body ${request.headers}");
    log("request.body ${request.body}");

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");
    } else {
      print("${response.statusCode} response.reasonPhrase ${response.reasonPhrase}");
      var items = json.decode(await response.stream.bytesToString());

      print("items $items");

      return false;
    }

    return true;
  }

//********************************************************
//********************************************************
//********************************************************

  static Api_Notification api_Notification = Api_Notification();

  static Future<bool> ApiSrv_medecin_patient_getNotification(String id, String password, String id_patient) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-medecin-get-notification-patient'));
    request.body = json.encode({"id": id, "password": password, "id_patient": id_patient});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Notification = await Api_Notification.fromJson(items);
        print("api_Notification ${api_Notification.notification}");
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

  static Future<bool> ApiSrv_medecin_patient_setNotification(String id, String password, String id_patient, bool notif) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-medecin-set-notification-patient'));
    request.body = json.encode({"id": id, "password": password, "id_patient": id_patient, "notification": notif});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Notification = await Api_Notification.fromJson(items);
        print("api_Notification ${api_Notification.notification}");
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

  //*******************************************
  //*******************************************
  //*******************************************

  static Future<bool> ApiSrv_User_sendMail(String id, String password, String patient_crypted_id, String sujet, String message) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-send-mail'));
    if (patient_crypted_id.isEmpty)
      request.body = json.encode({"id": id, "password": password, "sujet": sujet, "message": message, "patient_crypted_id": ""});
    else
      request.body = json.encode({"id": id, "password": password, "sujet": sujet, "message": message, "patient_crypted_id": patient_crypted_id});
    request.headers.addAll(headers);

    print("body ${request.body}");

    http.StreamedResponse response = await request.send();

    print("items ${response.statusCode}");

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");
    } else {
      print("response.reasonPhrase ${response.reasonPhrase}");
      return false;
    }
    return true;
  }

  static Future<bool> ApiSrv_Patient_sendMail(String id, String password,  String sujet, String message) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-patient-send-mail'));
    request.body = json.encode({"id": id, "password": password, "type_message": sujet, "message": message});
    request.headers.addAll(headers);

    print("body ${request.body}");
    http.StreamedResponse response = await request.send();

    print("items ${response.statusCode}");

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");
    } else {
      print("response.reasonPhrase ${response.reasonPhrase}");
      return false;
    }
    return true;
  }

  //*******************************************
  //*******************************************
  //*******************************************

  static Future<bool> ApiSrv_User_setNotification(String id, String password, bool notif) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-set-notification'));
    request.body = json.encode({"id": id, "password": password, "notification": notif});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Notification = await Api_Notification.fromJson(items);
        print("api_Notification ${api_Notification.notification}");
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

  static Future<bool> ApiSrv_User_setNotification_Token(String id, String password, String token) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-set-notification'));
    request.body = json.encode({"id": id, "password": password, "token": token});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Notification = await Api_Notification.fromJson(items);
        print("api_Notification ${api_Notification.notification}");
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

//********************************************************
//********************************************************
//********************************************************

  static Api_Donnee_Patient api_Donnee_Patient = Api_Donnee_Patient();

  static Future<bool> ApiSrv_medecin_patient_getDonnee_Patient(String id, String password, String id_patient, String code_donnee, String code_donnee_reference) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-medecin-get-donnee-patient'));
    request.body = json.encode({"id": id, "password": password, "id_patient": id_patient, "code_donnee": code_donnee, "code_donnee_reference": code_donnee_reference});

    print("ApiSrv_medecin_patient_getDonnee_Patient ${request.body}");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Donnee_Patient = await Api_Donnee_Patient.fromJson(items);
      }
    } else {
      api_Donnee_Patient.valeurDonnee = "";
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

  static Future<bool> ApiSrv_medecin_patient_setDonnee_Patient(String id, String password, String id_patient, String code_donnee, String code_donnee_reference, String valeur_donnee) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};

    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-medecin-set-donnee-patient'));
    request.body = json.encode({"id": id, "password": password, "id_patient": id_patient, "code_donnee": code_donnee, "code_donnee_reference": code_donnee_reference, "valeur_donnee": valeur_donnee});
    print("ApiSrv_medecin_patient_setDonnee_Patient ${request.body}");

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Notification = await Api_Notification.fromJson(items);
        print("api_Notification ${api_Notification.notification}");
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

  //********************************************************
//********************************************************
//********************************************************

  static Api_User_Token api_User_Token = Api_User_Token();

  static Future<bool> ApiSrv_user_getnotification_token(String id, String password) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-get-notification-token'));
    request.body = json.encode({"id": id, "password": password});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
//      print("items $items");

      if (items != null) {
        api_User_Token = await Api_User_Token.fromJson(items);
        print("api_Donnee_Patient ${id} ${password} >>>> ${api_User_Token.token}");
      }
    } else {
      api_Donnee_Patient.valeurDonnee = "";
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }

  static Future<bool> ApiSrv_user_setnotification_token(String id, String password, String token) async {
    var headers = {'Authorization': 'ApiKey 7de8991be6044c7abaa3b4f78a8b32c2', 'Accept': 'application/json', 'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('https://epioneweb.fr/epione/public/fr/api/user-set-notification-token'));
    request.body = json.encode({"id": id, "password": password, "token": token});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var items = json.decode(await response.stream.bytesToString());
      print("items $items");

      if (items != null) {
        api_Notification = await Api_Notification.fromJson(items);
        print("api_Notification ${api_Notification.notification}");
      }
    } else {
      print(response.reasonPhrase);
      return false;
    }
    return true;
  }
}
