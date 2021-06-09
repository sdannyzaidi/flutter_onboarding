import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile {
  String name;
  int age;
  String gender;

  Profile({required this.name, required this.age, required this.gender});
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() {
    return {"name": this.name, "age": this.age, "gender": this.gender};
  }

  void convertToObject(DocumentSnapshot doc) async {
    this.name = doc["name"];
    this.age = doc["age"];
    this.gender = doc["gender"];
  }

  Future addDatatoDB() async {
    CollectionReference profile = _db.collection('profile');
    try {
      await profile.add(toMap());
      return "Data added to database";
    } catch (err) {
      return "Error";
    }
  }

  Future updateDatatoDB(String docID) async {
    CollectionReference profile = _db.collection('profile');
    try {
      await profile.doc(docID).set(toMap());
      return "Profile updated!";
    } catch (err) {
      return "Error during profile update!";
    }
  }
}
