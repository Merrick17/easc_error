import 'package:firebase_database/firebase_database.dart';

class Panne {
  String id;
  String date;
  String ref;
  String desc;
  String tech;
  String adrip;

  Panne(this.date, this.adrip, this.ref, this.tech, this.desc);
  Panne.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        date = snapshot.value["Date"],
        ref = snapshot.value["RefMoniteur"],
        tech = snapshot.value["Technicien"],
        adrip = snapshot.value["AdresseIP"],
        desc = snapshot.value["Description"];

  toJson() {
    return {
      "id": id,
      "Date": date,
      "refMoniteur": ref,
      "Technicien": tech,
      "Adresse IP ": adrip,
      "Description": desc
    };
  }
}
