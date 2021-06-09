import 'package:flutter/material.dart';
import 'package:flutteronboarding/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutteronboarding/backend/validator.dart';
import 'package:flutteronboarding/themes/loadingScreen.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  // Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Profile user = Profile(name: '', age: 0, gender: '');
  bool loading = false;
  final databaseReference = FirebaseDatabase.instance.reference();
  void validate() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await user.addDatatoDB();
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(children: <Widget>[
        Icon(
          Icons.done_all,
          color: Colors.white,
          semanticLabel: "Done",
        ),
        Text('  Profile Added')
      ])));
    }
  }

  void update() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loading = true;
      });
      await user.updateDatatoDB("LvLJvWZ5d3L0y8i927Ji");
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(children: <Widget>[
        Icon(
          Icons.done_all,
          color: Colors.white,
          semanticLabel: "Done",
        ),
        Text('  Profile Updated')
      ])));
    }
  }

  @override
  // void initState() {
  //   super.initState();
  //   // final FirebaseDatabase database = FirebaseDatabase.instance;
  //   // itemRef = database.reference().child('profiles');
  // }

  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: Text('User Profile'),
            ),
            body: SafeArea(
                minimum: EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: SingleChildScrollView(
                    child: Form(
                  key: _formKey,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      // heading input field
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: TextFormField(
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            hintText: "Enter Name",
                            fillColor: Colors.white,
                          ),
                          validator: (val) => nameValidator(user.name),
                          onChanged: (val) {
                            setState(() => user.name = val);
                          },
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: "Enter Age",
                              fillColor: Colors.white,
                            ),
                            validator: (val) => null,
                            onChanged: (val) {
                              setState(() => user.age = int.parse(val));
                            },
                          )),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: TextFormField(
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                              hintText: "Enter Gender",
                              fillColor: Colors.white,
                            ),
                            validator: (val) => nameValidator(user.gender),
                            onChanged: (val) {
                              setState(() => user.gender = val);
                            },
                          )),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () => validate(),
                              child: Text('Submit',
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          )),
                      Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () => update(),
                              child: Text('Update',
                                  style: Theme.of(context).textTheme.headline5),
                            ),
                          ))
                    ]),
                  ),
                ))));
  }
}
