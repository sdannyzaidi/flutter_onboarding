import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutteronboarding/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase authentication service
import 'package:flutter/widgets.dart';
import 'package:flutteronboarding/screens/verifyAccount.dart';
import 'package:flutteronboarding/backend/authentication.dart';
import 'package:flutteronboarding/backend/signupOrlogin.dart';
import 'package:flutteronboarding/themes/loadingScreen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) {
            return LandingPage();
          });
        }
      },
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // const LandingPage({Key? key}) : super(key: key);
  bool _initialized;
  Stream<User> _streamOfAuthChanges;

  Future initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
        _streamOfAuthChanges = Authentication().user;
      });
    } catch (err) {
      print(err);
    }
  }

  void initState() {
    _initialized = false;
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!_initialized)
        ? LoadingScreen()
        : StreamBuilder<User>(
            stream: _streamOfAuthChanges,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  if (snapshot.data.emailVerified) {
                    return Home();
                  } else {
                    return VerifyAccount();
                  }
                } else {
                  return SignUpOrLogin();
                }
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  "Something went wrong! Please try later",
                  style: Theme.of(context).textTheme.bodyText1,
                ));
              } else {
                return LoadingScreen();
              }
            },
          );
  }
}
