import 'package:firebase_database/firebase_database.dart';

class Moniteur {
  String id;
  String emp;
  String etat;
  String ip;
  String ref;

  Moniteur(this.emp, this.etat, this.ip, this.ref);

  Moniteur.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        emp = snapshot.value["Emplacement"],
        etat = snapshot.value["Etat"],
        ip = snapshot.value["IP"],
        ref = snapshot.value["Reference"];

  toJson() {
    return {
      "id": id,
      "Emplacement": emp,
      "Etat": etat,
      "ip": ip,
      "Reference": ref,
    };
  }
}
