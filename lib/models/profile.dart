import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Profile {
  String key;
  String name;
  int age;
  String gender;
  String email;

  Profile({this.key, this.email, this.name, this.age, this.gender});
  FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  User thisUser = FirebaseAuth.instance.currentUser;

  Profile.fromSnapshot(DataSnapshot snapshot)
      : key = snapshot.key,
        email = snapshot.value["email"],
        name = snapshot.value["name"],
        age = snapshot.value["age"],
        gender = snapshot.value["gender"];

  toJson() {
    return {
      "name": this.name,
      "age": this.age,
      "gender": this.gender,
      "email": this.email
    };
  }

  Future addDatatoDB() async {
    CollectionReference profile = _db.collection('profile');
    try {
      await profile.add(toJson());
      return "Data added to database";
    } catch (err, stash) {
      print(stash);
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

  Future addDataRealtime() async {
    DatabaseReference newUser = database.reference().child('profile');
    print(newUser.path);
    // DatabaseReference newUserRef =
    //     database.reference().child('flutter-onboarding-default-rtdb/newUsers');
    // newUserRef.child('newUser').push().set(
    //   {'name': this.name, 'age': this.age, 'gender': this.gender},
    // ).catchError((err, s) {
    //   print('-----------------');
    //   print(err);
    //   print(s);
    // });

    // return await FirebaseDatabase.instance
    //     .reference()
    //     .child('jobExitBase50')
    //     .child(thisUser!.uid)
    //     .child('job')
    //     .update({
    //   'name': this.name,
    //   'age': this.age,
    //   'gender': this.gender
    // }).catchError((err, s) {
    //   print(err);
    //   print(s);
    // });

    // try {
    //   newUser.child(thisUser!.uid).set({
    //     'name': this.name,
    //     'age': this.age,
    //     'gender': this.gender
    //   }).catchError((err, s) {
    //     print('-----------------');
    //     print(err);
    //     print(s);
    //   });
    //   return "profile added";
    // } catch (err, stash) {
    //   print('********************');
    //   return "Error during profile update!";
    // }
  }
}
