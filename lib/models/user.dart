import 'package:firebase_database/firebase_database.dart';

class User {
  String id;
  String email;
  String nom;
  String password;
  String type;
  String prenom;

  User(this.prenom, this.nom, this.password, this.type, this.email);
  User.fromSnapshot(DataSnapshot snapshot)
      : id = snapshot.key,
        email = snapshot.value["Email"],
        nom = snapshot.value["Nom"],
        prenom = snapshot.value["Prenom"],
        type = snapshot.value["Type"],
        password = snapshot.value["Password"];

  toJson() {
    return {
      "id": id,
      "Email": email,
      "Nom": nom,
      "Prenom": prenom,
      "Password": password,
      "Type": type
    };
  }
}
