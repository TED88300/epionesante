class Api_Login {
  String cryptedId;
  int id;
  String password;
  String nom;
  String prenom;
  String role;

  Api_Login(
      {this.cryptedId = "",
      this.id = 0,
      this.password = "",
      this.nom = "",
      this.prenom = "",
      this.role = ""});

  factory Api_Login.fromJson(Map<String, dynamic> json) {
    return Api_Login(
      cryptedId: json['cryptedId'],
      id: json['id'],
      password: json['password'],
      nom: json['nom'],
      prenom: json['prenom'],
      role: json['role'],
    );
  }
}

class Api_User_Info {
  int? id;
  String? nom;
  String? prenom;
  String? email;
  String? role;
  bool? userNotification;
  String? userNotificationToken;
  String? idPatient;
  int? numeroOrthop;
  String? numeroSs;
  String? dateNaissance;
  String? telephone;
  String? idMedecin;
  String? medecinNom;
  String? userMedecinNotificationToken;

  String? numeroRpps;
  String? numeroAmeli;

  String? code_ac2;
  String? code_ac3;



  Api_User_Info(
      {this.id,
        this.nom,
        this.prenom,
        this.email,
        this.role,
        this.userNotification,
        this.userNotificationToken,
        this.idPatient,
        this.numeroOrthop,
        this.numeroSs,
        this.dateNaissance,
        this.telephone,
        this.idMedecin,
        this.medecinNom,
        this.userMedecinNotificationToken,
        this.numeroRpps,
        this.numeroAmeli,
        this.code_ac2,
        this.code_ac3,

      });

  Api_User_Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    prenom = json['prenom'];
    email = json['email'];
    role = json['role'];
    userNotification = json['user_notification'];
    userNotificationToken = json['user_notification_token'];
    idPatient = json['id_patient'];
    numeroOrthop = json['numero_orthop'];
    numeroSs = json['numero_ss'];
    dateNaissance = json['date_naissance'];
    telephone = json['telephone'];
    idMedecin = json['id_medecin'];
    medecinNom = json['medecin_nom'];
    userMedecinNotificationToken = json['user_medecin_notification_token'];
    numeroRpps = json['numero_rpps'];
    numeroAmeli = json['numero_ameli'];
    code_ac2 = json['code_ac2'];
    code_ac3 = json['code_ac3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['email'] = this.email;
    data['role'] = this.role;
    data['user_notification'] = this.userNotification;
    data['user_notification_token'] = this.userNotificationToken;
    data['id_patient'] = this.idPatient;
    data['numero_orthop'] = this.numeroOrthop;
    data['numero_ss'] = this.numeroSs;
    data['date_naissance'] = this.dateNaissance;
    data['telephone'] = this.telephone;
    data['id_medecin'] = this.idMedecin;
    data['medecin_nom'] = this.medecinNom;
    data['user_medecin_notification_token'] = this.userMedecinNotificationToken;
    data['numero_rpps'] = this.numeroRpps;
    data['numero_ameli'] = this.numeroAmeli;
    data['code_ac2'] = this.code_ac2;
    data['code_ac3'] = this.code_ac3;
    return data;
  }
}


class Api_Patient {
  int? id;
  String? cryptedId;
  int? numeroOrthop;
  String? numeroSs;
  String? email;
  String? telephone;
  String? nom;
  String? prenom;
  String? dateNaissance;
  String? ville;
  Null? userPatientNotificationToken;
  bool? notificationPatient;
  bool? sel = false;

  Api_Patient(
      {this.id,
        this.cryptedId,
        this.numeroOrthop,
        this.numeroSs,
        this.email,
        this.telephone,
        this.nom,
        this.prenom,
        this.dateNaissance,
        this.ville,
        this.userPatientNotificationToken,
        this.notificationPatient});

  Api_Patient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cryptedId = json['crypted_id'];
    numeroOrthop = json['numero_orthop'];
    numeroSs = json['numero_ss'];
    email = json['email'];
    telephone = json['telephone'];
    nom = json['nom'];
    prenom = json['prenom'];
    dateNaissance = json['date_naissance'];
    ville = json['ville'];
    userPatientNotificationToken = json['user_patient_notification_token'];
    notificationPatient = json['notification_patient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['crypted_id'] = this.cryptedId;
    data['numero_orthop'] = this.numeroOrthop;
    data['numero_ss'] = this.numeroSs;
    data['email'] = this.email;
    data['telephone'] = this.telephone;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    data['date_naissance'] = this.dateNaissance;
    data['ville'] = this.ville;
    data['user_patient_notification_token'] = this.userPatientNotificationToken;
    data['notification_patient'] = this.notificationPatient;
    return data;
  }
}


/*

class Api_Appareil {

  String? libelle;
  String? imageUrl;
  int? code;
  String? famille;
  ParamMobile? paramMobile;

  Api_Appareil(
      {this.libelle, this.imageUrl, this.code, this.famille, this.paramMobile});

  Api_Appareil.fromJson(Map<String, dynamic> json) {
    libelle = json['libelle'];
    imageUrl = json['image_url'];
    code = json['code'];
    famille = json['famille'];
    paramMobile = json['param_mobile'] != null
        ? new ParamMobile.fromJson(json['param_mobile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['libelle'] = this.libelle;
    data['image_url'] = this.imageUrl;
    data['code'] = this.code;
    data['famille'] = this.famille;
    if (this.paramMobile != null) {
      data['param_mobile'] = this.paramMobile!.toJson();
    }
    return data;
    }
}

class ParamMobile {
  bool? actif;
  String? libelleFamille;
  Contexte? contexte;
  List<Donnees>? donnees;

  ParamMobile({this.actif, this.libelleFamille, this.contexte, this.donnees});

  ParamMobile.fromJson(Map<String, dynamic> json) {
    actif = json['actif'];
    libelleFamille = json['libelle_famille'];
    contexte = json['contexte'] != null
        ? new Contexte.fromJson(json['contexte'])
        : null;
    if (json['donnees'] != null) {
      donnees = <Donnees>[];
      json['donnees'].forEach((v) {
        donnees!.add(new Donnees.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actif'] = this.actif;
    data['libelle_famille'] = this.libelleFamille;
    if (this.contexte != null) {
      data['contexte'] = this.contexte!.toJson();
    }
    if (this.donnees != null) {
    data['donnees'] = this.donnees!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contexte {
  String? code;
  bool? actif;
  List<DonneesContexte>? donneesContexte;

  Contexte({this.code, this.actif, this.donneesContexte});

  Contexte.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    actif = json['actif'];
    if (json['donnees_contexte'] != null) {
      donneesContexte = <DonneesContexte>[];
      json['donnees_contexte'].forEach((v) {
        donneesContexte!.add(new DonneesContexte.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['actif'] = this.actif;
    if (this.donneesContexte != null) {
      data['donnees_contexte'] =
          this.donneesContexte!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DonneesContexte {
  String? code;
  String? libelle;
  String? unite;
  String? format;
  var seuilMaxi;

  DonneesContexte(
      {this.code, this.libelle, this.unite, this.format, this.seuilMaxi});

  DonneesContexte.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    libelle = json['libelle'];
    unite = json['unite'];
    format = json['format'];
    seuilMaxi = json['seuil_maxi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['libelle'] = this.libelle;
    data['unite'] = this.unite;
    data['format'] = this.format;
    data['seuil_maxi'] = this.seuilMaxi;
    return data;
  }
}

class Donnees {
  String? code;
  String? libelle;
  String? unite;
  String? format;
  var seuilMini;
  var seuilMaxi;

  Donnees(
      {this.code,
        this.libelle,
        this.unite,
        this.format,
        this.seuilMini,
        this.seuilMaxi});

  Donnees.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    libelle = json['libelle'];
    unite = json['unite'];
    format = json['format'];
    seuilMini = json['seuil_mini'];
    seuilMaxi = json['seuil_maxi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['libelle'] = this.libelle;
    data['unite'] = this.unite;
    data['format'] = this.format;
    data['seuil_mini'] = this.seuilMini;
    data['seuil_maxi'] = this.seuilMaxi;
    return data;
  }
}
*/
//********************************************************
//********************************************************
//********************************************************

/*
class Api_Donnees_Get {
  List<DonneesGet>? donneesGet;
  int? nb;

  Api_Donnees_Get({this.donneesGet, this.nb});

  Api_Donnees_Get.fromJson(Map<String, dynamic> json) {

    print("Api_Donnees_Get fromJson");


    if (json['donnees_get'] != null) {


      donneesGet = <DonneesGet>[];
      json['donnees_get'].forEach((v) {
        donneesGet!.add(new DonneesGet.fromJson(v));
      });
    }
    nb = json['nb'];
  }

  Map<String, dynamic> toJson() {
    print("Api_Donnees_Get MAP");

    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.donneesGet != null) {
      data['donnees_get'] = this.donneesGet!.map((v) => v.toJson()).toList();
    }
    data['nb'] = this.nb;
    return data;
  }
}
class DonneesGet {
  int? id;
  String? date;
  String? familleAppareil;
  String? codeAppareil;
  String? codeDonnee;
  String? valeurDonnee;
  var seuilMiniDonnee;
  var seuilMaxiDonnee;
  String? codeContexte;
  String? donneeContexte;
  String? valeurContexte;

  DonneesGet(
      {this.id,
        this.date,
        this.familleAppareil,
        this.codeAppareil,
        this.codeDonnee,
        this.valeurDonnee,
        this.seuilMiniDonnee,
        this.seuilMaxiDonnee,
        this.codeContexte,
        this.donneeContexte,
        this.valeurContexte});

  DonneesGet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    familleAppareil = json['famille_appareil'];
    codeAppareil = json['code_appareil'];
    codeDonnee = json['code_donnee'];
    valeurDonnee = json['valeur_donnee'];
    seuilMiniDonnee = json['seuil_mini_donnee'];
    seuilMaxiDonnee = json['seuil_maxi_donnee'];
    codeContexte = json['code_contexte'];
    donneeContexte = json['donnee_contexte'];
    valeurContexte = json['valeur_contexte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['famille_appareil'] = this.familleAppareil;
    data['code_appareil'] = this.codeAppareil;
    data['code_donnee'] = this.codeDonnee;
    data['valeur_donnee'] = this.valeurDonnee;
    data['seuil_mini_donnee'] = this.seuilMiniDonnee;
    data['seuil_maxi_donnee'] = this.seuilMaxiDonnee;
    data['code_contexte'] = this.codeContexte;
    data['donnee_contexte'] = this.donneeContexte;
    data['valeur_contexte'] = this.valeurContexte;
    return data;
  }
}
*/

class Api_Donnees_Get {
  List<DonneesGet>? donneesGet;
  int? nb;

  Api_Donnees_Get({this.donneesGet, this.nb});

  Api_Donnees_Get.fromJson(Map<String, dynamic> json) {
    if (json['donnees_get'] != null) {
      donneesGet = <DonneesGet>[];
      json['donnees_get'].forEach((v) {
        donneesGet!.add(new DonneesGet.fromJson(v));
      });
    }
    nb = json['nb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.donneesGet != null) {
      data['donnees_get'] = this.donneesGet!.map((v) => v.toJson()).toList();
    }
    data['nb'] = this.nb;
    return data;
  }
}

class DonneesGet {
  int? id;
  String? date;
  String? familleAppareil;
  String? codeAppareil;
  String? codeDonnee;
  String? valeurDonnee;
  int? seuilMiniDonnee;
  int? seuilMaxiDonnee;
  String? codeContexte;
  String? donneeContexte;
  String? valeurContexte;
  String? codeContexteSecondaire;
  String? donneeContexteSecondaire;
  String? valeurContexteSecondaire;

  DonneesGet(
      {this.id,
        this.date,
        this.familleAppareil,
        this.codeAppareil,
        this.codeDonnee,
        this.valeurDonnee,
        this.seuilMiniDonnee,
        this.seuilMaxiDonnee,
        this.codeContexte,
        this.donneeContexte,
        this.valeurContexte,
        this.codeContexteSecondaire,
        this.donneeContexteSecondaire,
        this.valeurContexteSecondaire});

  DonneesGet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    familleAppareil = json['famille_appareil'];
    codeAppareil = json['code_appareil'];
    codeDonnee = json['code_donnee'];
    valeurDonnee = json['valeur_donnee'];
    seuilMiniDonnee = json['seuil_mini_donnee'];
    seuilMaxiDonnee = json['seuil_maxi_donnee'];
    codeContexte = json['code_contexte'];
    donneeContexte = json['donnee_contexte'];
    valeurContexte = json['valeur_contexte'];
    codeContexteSecondaire = json['code_contexte_secondaire'];
    donneeContexteSecondaire = json['donnee_contexte_secondaire'];
    valeurContexteSecondaire = json['valeur_contexte_secondaire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['famille_appareil'] = this.familleAppareil;
    data['code_appareil'] = this.codeAppareil;
    data['code_donnee'] = this.codeDonnee;
    data['valeur_donnee'] = this.valeurDonnee;
    data['seuil_mini_donnee'] = this.seuilMiniDonnee;
    data['seuil_maxi_donnee'] = this.seuilMaxiDonnee;
    data['code_contexte'] = this.codeContexte;
    data['donnee_contexte'] = this.donneeContexte;
    data['valeur_contexte'] = this.valeurContexte;
    data['code_contexte_secondaire'] = this.codeContexteSecondaire;
    data['donnee_contexte_secondaire'] = this.donneeContexteSecondaire;
    data['valeur_contexte_secondaire'] = this.valeurContexteSecondaire;
    return data;
  }
}
//********************************************************
//********************************************************
//********************************************************

/*
class DonneesSet {
  String? date;
  String? familleAppareil;
  String? codeAppareil;
  String? codeDonnee;
  String? valeurDonnee;
  String? seuilMiniDonnee;
  String? seuilMaxiDonnee;
  String? codeContexte;
  String? donneeContexte;
  String? valeurContexte;

  DonneesSet(
      {this.date,
        this.familleAppareil,
        this.codeAppareil,
        this.codeDonnee,
        this.valeurDonnee,
        this.seuilMiniDonnee,
        this.seuilMaxiDonnee,
        this.codeContexte,
        this.donneeContexte,
        this.valeurContexte});

  DonneesSet.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    familleAppareil = json['famille_appareil'];
    codeAppareil = json['code_appareil'];
    codeDonnee = json['code_donnee'];
    valeurDonnee = json['valeur_donnee'];
    seuilMiniDonnee = json['seuil_mini_donnee'];
    seuilMaxiDonnee = json['seuil_maxi_donnee'];
    codeContexte = json['code_contexte'];
    donneeContexte = json['donnee_contexte'];
    valeurContexte = json['valeur_contexte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['famille_appareil'] = this.familleAppareil;
    data['code_appareil'] = this.codeAppareil;
    data['code_donnee'] = this.codeDonnee;
    data['valeur_donnee'] = this.valeurDonnee;
    data['seuil_mini_donnee'] = this.seuilMiniDonnee;
    data['seuil_maxi_donnee'] = this.seuilMaxiDonnee;
    data['code_contexte'] = this.codeContexte;
    data['donnee_contexte'] = this.donneeContexte;
    data['valeur_contexte'] = this.valeurContexte;
    return data;
  }
}
*/

class DonneesSet {
  String? date;
  String? familleAppareil;
  String? codeAppareil;
  String? codeDonnee;
  String? valeurDonnee;
  String? seuilMiniDonnee;
  String? seuilMaxiDonnee;
  String? codeContexte;
  String? donneeContexte;
  String? valeurContexte;
  String? codeContexteSecondaire;
  String? donneeContexteSecondaire;
  String? valeurContexteSecondaire;
  bool? donnee_en_alerte;

  DonneesSet(
      {this.date,
        this.familleAppareil,
        this.codeAppareil,
        this.codeDonnee,
        this.valeurDonnee,
        this.seuilMiniDonnee,
        this.seuilMaxiDonnee,
        this.codeContexte,
        this.donneeContexte,
        this.valeurContexte,
        this.codeContexteSecondaire,
        this.donneeContexteSecondaire,
        this.valeurContexteSecondaire,
        this.donnee_en_alerte
      });

  DonneesSet.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    familleAppareil = json['famille_appareil'];
    codeAppareil = json['code_appareil'];
    codeDonnee = json['code_donnee'];
    valeurDonnee = json['valeur_donnee'];
    seuilMiniDonnee = json['seuil_mini_donnee'];
    seuilMaxiDonnee = json['seuil_maxi_donnee'];
    codeContexte = json['code_contexte'];
    donneeContexte = json['donnee_contexte'];
    valeurContexte = json['valeur_contexte'];
    codeContexteSecondaire = json['code_contexte_secondaire'];
    donneeContexteSecondaire = json['donnee_contexte_secondaire'];
    valeurContexteSecondaire = json['valeur_contexte_secondaire'];
    donnee_en_alerte = json['donnee_en_alerte'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['famille_appareil'] = this.familleAppareil;
    data['code_appareil'] = this.codeAppareil;
    data['code_donnee'] = this.codeDonnee;
    data['valeur_donnee'] = this.valeurDonnee;
    data['seuil_mini_donnee'] = this.seuilMiniDonnee;
    data['seuil_maxi_donnee'] = this.seuilMaxiDonnee;
    data['code_contexte'] = this.codeContexte;
    data['donnee_contexte'] = this.donneeContexte;
    data['valeur_contexte'] = this.valeurContexte;
    data['code_contexte_secondaire'] = this.codeContexteSecondaire;
    data['donnee_contexte_secondaire'] = this.donneeContexteSecondaire;
    data['valeur_contexte_secondaire'] = this.valeurContexteSecondaire;
    data['donnee_en_alerte'] = this.donnee_en_alerte;
    return data;
  }
}

//********************************************************
//********************************************************
//********************************************************

class Api_Notification {
  bool? notification;

  Api_Notification({this.notification});

  Api_Notification.fromJson(Map<String, dynamic> json) {
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification'] = this.notification;
    return data;
  }

}


class Api_Donnee_Patient {
  String? valeurDonnee;

  Api_Donnee_Patient({this.valeurDonnee});

  Api_Donnee_Patient.fromJson(Map<String, dynamic> json) {
    valeurDonnee = json['valeur_donnee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['valeur_donnee'] = this.valeurDonnee;
    return data;
  }
}

class Api_User_Token {
  bool? trouve;
  String? token;

  Api_User_Token({this.trouve, this.token});

  Api_User_Token.fromJson(Map<String, dynamic> json) {
    trouve = json['trouve'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trouve'] = this.trouve;
    data['token'] = this.token;
    return data;
  }
}

/*

class Api_Appareil_V2 {
  List<Appareils>? appareils;
  List<Contextes>? contextes;
  List<DonneesUserMedecinPatient>? donneesUserMedecinPatient;

  Api_Appareil_V2(
      {this.appareils, this.contextes, this.donneesUserMedecinPatient});

  Api_Appareil_V2.fromJson(Map<String, dynamic> json) {
    if (json['appareils'] != null) {
      appareils = <Appareils>[];
      json['appareils'].forEach((v) {
        appareils!.add(new Appareils.fromJson(v));
      });
    }
    if (json['contextes'] != null) {
      contextes = <Contextes>[];
      json['contextes'].forEach((v) {
        contextes!.add(new Contextes.fromJson(v));
      });
    }
    if (json['donnees_user_medecin_patient'] != null) {
      donneesUserMedecinPatient = <DonneesUserMedecinPatient>[];
      json['donnees_user_medecin_patient'].forEach((v) {
        donneesUserMedecinPatient!
            .add(new DonneesUserMedecinPatient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appareils != null) {
      data['appareils'] = this.appareils!.map((v) => v.toJson()).toList();
    }
    if (this.contextes != null) {
    data['contextes'] = this.contextes!.map((v) => v.toJson()).toList();
    }
    if (this.donneesUserMedecinPatient != null) {
    data['donnees_user_medecin_patient'] =
    this.donneesUserMedecinPatient!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appareils {
  String? libelle;
  String? imageUrl;
  String? code;
  String? famille;
  bool? sel = false;
  ParamMobile? paramMobile;

  Appareils(
      {this.libelle, this.imageUrl, this.code, this.famille, this.paramMobile});

  Appareils.fromJson(Map<String, dynamic> json) {
    libelle = json['libelle'];
    imageUrl = json['image_url'];
    code = json['code'].toString();
    famille = json['famille'];
    paramMobile = json['param_mobile'] != null
        ? new ParamMobile.fromJson(json['param_mobile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['libelle'] = this.libelle;
    data['image_url'] = this.imageUrl;
    data['code'] = this.code;
    data['famille'] = this.famille;
    if (this.paramMobile != null) {
      data['param_mobile'] = this.paramMobile!.toJson();
    }
    return data;
    }
}

class ParamMobile {
  bool? actif;
  String? libelleFamille;
  List<Donnees>? donnees;
  String? codeAppareilForFixtures;
  String? contexte;

  ParamMobile(
      {this.actif,
        this.libelleFamille,
        this.donnees,
        this.codeAppareilForFixtures,
        this.contexte});

  ParamMobile.fromJson(Map<String, dynamic> json) {
    actif = json['actif'];
    libelleFamille = json['libelle_famille'];
    if (json['donnees'] != null) {
      donnees = <Donnees>[];
      json['donnees'].forEach((v) {
        donnees!.add(new Donnees.fromJson(v));
      });
    }
    codeAppareilForFixtures = json['code_appareil_for_fixtures'].toString();
    contexte = json['contexte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actif'] = this.actif;
    data['libelle_famille'] = this.libelleFamille;
    if (this.donnees != null) {
      data['donnees'] = this.donnees!.map((v) => v.toJson()).toList();
    }
    data['code_appareil_for_fixtures'] = this.codeAppareilForFixtures;
    data['contexte'] = this.contexte;
    return data;
  }
}

class Donnees {
  String? code;
  String? libelle;
  String? unite;
  String? format;
  int? seuilMini;
  int? seuilMaxi;
  String? contexte;
  String? derniereValeur;

  var medMini = "";
  var medMaxi = "";
  var medObj = "";


  Donnees(
      {this.code,
        this.libelle,
        this.unite,
        this.format,
        this.seuilMini,
        this.seuilMaxi,
        this.contexte,
        this.derniereValeur});

  Donnees.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    libelle = json['libelle'];
    unite = json['unite'];
    format = json['format'];
    seuilMini = json['seuil_mini'];
    seuilMaxi = json['seuil_maxi'];
    contexte = json['contexte'];
    derniereValeur = json['derniere_valeur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['libelle'] = this.libelle;
    data['unite'] = this.unite;
    data['format'] = this.format;
    data['seuil_mini'] = this.seuilMini;
    data['seuil_maxi'] = this.seuilMaxi;
    data['contexte'] = this.contexte;
    data['derniere_valeur'] = this.derniereValeur;
    return data;
  }
}

class Contextes {
  String? code;
  bool? actif;
  List<DonneesContexte>? donneesContexte;

  Contextes({this.code, this.actif, this.donneesContexte});

  Contextes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    actif = json['actif'];
    if (json['donnees_contexte'] != null) {
      donneesContexte = <DonneesContexte>[];
      json['donnees_contexte'].forEach((v) {
        donneesContexte!.add(new DonneesContexte.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['actif'] = this.actif;
    if (this.donneesContexte != null) {
      data['donnees_contexte'] =
          this.donneesContexte!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DonneesContexte {
  String? code;
  bool? actif;
  String? libelle;
  String? unite;
  String? format;
  int? seuilMaxi;

  DonneesContexte(
      {this.code,
        this.actif,
        this.libelle,
        this.unite,
        this.format,
        this.seuilMaxi});

  DonneesContexte.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    actif = json['actif'];
    libelle = json['libelle'];
    unite = json['unite'];
    format = json['format'];
    seuilMaxi = json['seuil_maxi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['actif'] = this.actif;
    data['libelle'] = this.libelle;
    data['unite'] = this.unite;
    data['format'] = this.format;
    data['seuil_maxi'] = this.seuilMaxi;
    return data;
  }
}

class DonneesUserMedecinPatient {
  String? codeDonneeReference;
  String? codeDonnee;
  String? valeurDonnee;
  String? date;

  DonneesUserMedecinPatient(
      {this.codeDonneeReference,
        this.codeDonnee,
        this.valeurDonnee,
        this.date});

  DonneesUserMedecinPatient.fromJson(Map<String, dynamic> json) {
    codeDonneeReference = json['code_donnee_reference'];
    codeDonnee = json['code_donnee'];
    valeurDonnee = json['valeur_donnee'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_donnee_reference'] = this.codeDonneeReference;
    data['code_donnee'] = this.codeDonnee;
    data['valeur_donnee'] = this.valeurDonnee;
    data['date'] = this.date;
    return data;
  }
}

*/

class Api_Appareil_V2 {
  List<Appareils>? appareils;
  List<Contextes>? contextes;
  List<DonneesUserMedecinPatient>? donneesUserMedecinPatient;

  Api_Appareil_V2(
      {this.appareils, this.contextes, this.donneesUserMedecinPatient});

  Api_Appareil_V2.fromJson(Map<String, dynamic> json) {
    if (json['appareils'] != null) {
      appareils = <Appareils>[];
      json['appareils'].forEach((v) {
        appareils!.add(new Appareils.fromJson(v));
      });
    }
    if (json['contextes'] != null) {
      contextes = <Contextes>[];
      json['contextes'].forEach((v) {
        contextes!.add(new Contextes.fromJson(v));
      });
    }
    if (json['donnees_user_medecin_patient'] != null) {
      donneesUserMedecinPatient = <DonneesUserMedecinPatient>[];
      json['donnees_user_medecin_patient'].forEach((v) {
        donneesUserMedecinPatient!
            .add(new DonneesUserMedecinPatient.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.appareils != null) {
      data['appareils'] = this.appareils!.map((v) => v.toJson()).toList();
    }
    if (this.contextes != null) {
    data['contextes'] = this.contextes!.map((v) => v.toJson()).toList();
    }
    if (this.donneesUserMedecinPatient != null) {
    data['donnees_user_medecin_patient'] =
    this.donneesUserMedecinPatient!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appareils {
  String? libelle;
  String? imageUrl;
  String? code;
  String? famille;
  ParamMobile? paramMobile;

  Appareils(
      {this.libelle, this.imageUrl, this.code, this.famille, this.paramMobile});

  Appareils.fromJson(Map<String, dynamic> json) {

    print(">>>>>>>>>>> json['code'] ${json['code']}");

    libelle = json['libelle'];
    imageUrl = json['image_url'];
    code = "${json['code']}";
    famille = json['famille'];
    paramMobile = json['param_mobile'] != null
        ? new ParamMobile.fromJson(json['param_mobile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['libelle'] = this.libelle;
    data['image_url'] = this.imageUrl;
    data['code'] = this.code;
    data['famille'] = this.famille;
    if (this.paramMobile != null) {
      data['param_mobile'] = this.paramMobile!.toJson();
    }
    return data;
    }
}

class ParamMobile {
  bool? actif;
  String? type;
  String? libelleFamille;
  String? libelleOnglet;
  int? ordreOnglet;
  List<Donnees>? donnees;
  int? codeAppareilForFixtures;
  String? contexte;

  ParamMobile(
      {this.actif,
        this.type,
        this.libelleFamille,
        this.libelleOnglet,
        this.ordreOnglet,
        this.donnees,
        this.codeAppareilForFixtures,
        this.contexte});

  ParamMobile.fromJson(Map<String, dynamic> json) {
    actif = json['actif'];
    type = json['type'];
    libelleFamille = json['libelle_famille'];
    libelleOnglet = json['libelle_onglet'];
    ordreOnglet = json['ordre_onglet'];
    if (json['donnees'] != null) {
      donnees = <Donnees>[];
      json['donnees'].forEach((v) {
        donnees!.add(new Donnees.fromJson(v));
      });
    }
    //codeAppareilForFixtures = json['code_appareil_for_fixtures'];
    contexte = json['contexte'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['actif'] = this.actif;
    data['type'] = this.type;
    data['libelle_famille'] = this.libelleFamille;
    data['libelle_onglet'] = this.libelleOnglet;
    data['ordre_onglet'] = this.ordreOnglet;
    if (this.donnees != null) {
      data['donnees'] = this.donnees!.map((v) => v.toJson()).toList();
    }
//    data['code_appareil_for_fixtures'] = this.codeAppareilForFixtures;
    data['contexte'] = this.contexte;
    return data;
  }
}

class Donnees {
  String? code;
  String? libelle;
  String? unite;
  String? format;
  String? formatAffichage;
  int? seuilMini;
  int? seuilMaxi;
  String? contexte;
  List<int>? valeursForFixtures;
  String? derniereValeur;

  var medMini = "";
  var medMaxi = "";
  var medObj = "";

  Donnees(
      {this.code,
        this.libelle,
        this.unite,
        this.format,
        this.formatAffichage,
        this.seuilMini,
        this.seuilMaxi,
        this.contexte,
        this.valeursForFixtures,
        this.derniereValeur});

  Donnees.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    libelle = json['libelle'];
    unite = json['unite'];
    format = json['format'];
    formatAffichage = json['format_affichage'];
    seuilMini = json['seuil_mini'];
    seuilMaxi = json['seuil_maxi'];
    contexte = json['contexte'];
    valeursForFixtures = json['valeurs_for_fixtures'].cast<int>();
    derniereValeur = json['derniere_valeur'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['libelle'] = this.libelle;
    data['unite'] = this.unite;
    data['format'] = this.format;
    data['format_affichage'] = this.formatAffichage;
    data['seuil_mini'] = this.seuilMini;
    data['seuil_maxi'] = this.seuilMaxi;
    data['contexte'] = this.contexte;
    data['valeurs_for_fixtures'] = this.valeursForFixtures;
    data['derniere_valeur'] = this.derniereValeur;
    return data;
  }
}

class Contextes {
  String? code;
  bool? actif;
  List<DonneesContexte>? donneesContexte;

  Contextes({this.code, this.actif, this.donneesContexte});

  Contextes.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    actif = json['actif'];
    if (json['donnees_contexte'] != null) {
      donneesContexte = <DonneesContexte>[];
      json['donnees_contexte'].forEach((v) {
        donneesContexte!.add(new DonneesContexte.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['actif'] = this.actif;
    if (this.donneesContexte != null) {
      data['donnees_contexte'] =
          this.donneesContexte!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DonneesContexte {
  String? code;
  bool? actif;
  String? libelle;
  double? coefMet;
  String? unite;
  String? format;
  int? seuilMaxi;

  DonneesContexte(
      {this.code,
        this.actif,
        this.libelle,
        this.coefMet,
        this.unite,
        this.format,
        this.seuilMaxi});

  DonneesContexte.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    actif = json['actif'];
    libelle = json['libelle'];
    coefMet = double.tryParse("${json['coef_met']}");
    unite = json['unite'];
    format = json['format'];
    seuilMaxi = json['seuil_maxi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['actif'] = this.actif;
    data['libelle'] = this.libelle;
    data['coef_met'] = this.coefMet;
    data['unite'] = this.unite;
    data['format'] = this.format;
    data['seuil_maxi'] = this.seuilMaxi;
    return data;
  }
}

class DonneesUserMedecinPatient {
  String? codeDonneeReference;
  String? codeDonnee;
  String? valeurDonnee;
  String? date;

  DonneesUserMedecinPatient(
      {this.codeDonneeReference,
        this.codeDonnee,
        this.valeurDonnee,
        this.date});

  DonneesUserMedecinPatient.fromJson(Map<String, dynamic> json) {
    codeDonneeReference = json['code_donnee_reference'];
    codeDonnee = json['code_donnee'];
    valeurDonnee = json['valeur_donnee'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code_donnee_reference'] = this.codeDonneeReference;
    data['code_donnee'] = this.codeDonnee;
    data['valeur_donnee'] = this.valeurDonnee;
    data['date'] = this.date;
    return data;
  }
}




//******************************************************
class Patient_Contact {
  String? telephoneTechnicien = "";
  String? telephonePharmacien = "";
  String? telephoneAgence = "";

  Patient_Contact(
      {this.telephoneTechnicien,
        this.telephonePharmacien,
        this.telephoneAgence});

  init()
  {
    Patient_Contact(telephoneTechnicien : "",telephonePharmacien : "",telephoneAgence :"");
  }


  Patient_Contact.fromJson(Map<String, dynamic> json) {
    String wT = "";
/*
    if (json['telephone_technicien'] == null)
      wT = "${json['telephone_technicien']}";
    else
      wT = json['telephone_technicien'];
*/
    wT = "${json['telephone_technicien']}";

    if ("${wT}".compareTo("null") == 0)
      wT = "";

    telephoneTechnicien = wT;
    telephonePharmacien = json['telephone_pharmacien'];
    telephoneAgence = json['telephone_agence'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['telephone_technicien'] = this.telephoneTechnicien;
    data['telephone_pharmacien'] = this.telephonePharmacien;
    data['telephone_agence'] = this.telephoneAgence;
    return data;
  }

}


//************************************************************************************************
//************************************************************************************************
//************************************************************************************************


class Nb_Patient_Alerte {
  String? nb;

  Nb_Patient_Alerte({this.nb});

  Nb_Patient_Alerte.fromJson(Map<String, dynamic> json) {
    nb = json['nb'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nb'] = this.nb;
    return data;
  }
}

//************************************************************************************************
//************************************************************************************************
//************************************************************************************************

class Patient_Alerte {
  List<Patients>? patients;

  Patient_Alerte({this.patients});

  Patient_Alerte.fromJson(Map<String, dynamic> json) {
    if (json['patients'] != null) {
      patients = <Patients>[];
      json['patients'].forEach((v) {
        patients!.add(new Patients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patients != null) {
      data['patients'] = this.patients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Patients {
  int? id;
  int? numero;
  String? nom;
  String? prenom;
  List<DonneesEnAlerte>? donneesEnAlerte;

  Patients({this.id, this.numero, this.nom, this.prenom, this.donneesEnAlerte});

  Patients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numero = json['numero'];
    nom = json['nom'];
    prenom = json['prenom'];
    if (json['donnees_en_alerte'] != null) {
      donneesEnAlerte = <DonneesEnAlerte>[];
      json['donnees_en_alerte'].forEach((v) {
        donneesEnAlerte!.add(new DonneesEnAlerte.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['numero'] = this.numero;
    data['nom'] = this.nom;
    data['prenom'] = this.prenom;
    if (this.donneesEnAlerte != null) {
      data['donnees_en_alerte'] =
          this.donneesEnAlerte!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DonneesEnAlerte {
  int? id;
  String? date;
  String? familleAppareil;
  String? codeAppareil;
  String? codeDonnee;
  String? valeurDonnee;
  int? seuilMiniDonnee;
  int? seuilMaxiDonnee;
  String? codeContexte;
  String? donneeContexte;
  String? valeurContexte;
  String? codeContexteSecondaire;
  String? donneeContexteSecondaire;
  String? valeurContexteSecondaire;

  DonneesEnAlerte(
      {this.id,
        this.date,
        this.familleAppareil,
        this.codeAppareil,
        this.codeDonnee,
        this.valeurDonnee,
        this.seuilMiniDonnee,
        this.seuilMaxiDonnee,
        this.codeContexte,
        this.donneeContexte,
        this.valeurContexte,
        this.codeContexteSecondaire,
        this.donneeContexteSecondaire,
        this.valeurContexteSecondaire});

  DonneesEnAlerte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    familleAppareil = json['famille_appareil'];
    codeAppareil = json['code_appareil'];
    codeDonnee = json['code_donnee'];
    valeurDonnee = json['valeur_donnee'];
    seuilMiniDonnee = json['seuil_mini_donnee'];
    seuilMaxiDonnee = json['seuil_maxi_donnee'];
    codeContexte = json['code_contexte'];
    donneeContexte = json['donnee_contexte'];
    valeurContexte = json['valeur_contexte'];
    codeContexteSecondaire = json['code_contexte_secondaire'];
    donneeContexteSecondaire = json['donnee_contexte_secondaire'];
    valeurContexteSecondaire = json['valeur_contexte_secondaire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['famille_appareil'] = this.familleAppareil;
    data['code_appareil'] = this.codeAppareil;
    data['code_donnee'] = this.codeDonnee;
    data['valeur_donnee'] = this.valeurDonnee;
    data['seuil_mini_donnee'] = this.seuilMiniDonnee;
    data['seuil_maxi_donnee'] = this.seuilMaxiDonnee;
    data['code_contexte'] = this.codeContexte;
    data['donnee_contexte'] = this.donneeContexte;
    data['valeur_contexte'] = this.valeurContexte;
    data['code_contexte_secondaire'] = this.codeContexteSecondaire;
    data['donnee_contexte_secondaire'] = this.donneeContexteSecondaire;
    data['valeur_contexte_secondaire'] = this.valeurContexteSecondaire;
    return data;
  }
}
