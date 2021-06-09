import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Profile {
  String? key;
  String name;
  int age;
  String gender;

  Profile(
      {this.key, required this.name, required this.age, required this.gender});
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Profile.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        name = snapshot.value["name"],
        age = snapshot.value["age"],
        gender = snapshot.value["gender"];

  toJson() {
    return {"name": this.name, "age": this.age, "gender": this.gender};
  }

  Future addDatatoDB() async {
    CollectionReference profile = _db.collection('profile');
    try {
      await profile.add(toJson());
      return "Data added to database";
    } catch (err) {
      return "Error";
    }
  }

  Future updateDatatoDB(String docID) async {
    CollectionReference profile = _db.collection('profile');
    try {
      await profile.doc(docID).set(toJson());
      return "Profile updated!";
    } catch (err) {
      return "Error during profile update!";
    }
  }
}
