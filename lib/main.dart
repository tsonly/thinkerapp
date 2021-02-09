import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';

import 'package:thinker/page/LoginPage.dart';
import 'package:thinker/view/EncontrarPessoas.dart';
import 'package:thinker/view/NewPost.dart';

import 'page/HomePage.dart';
import 'page/RegistroPage.dart';

void main() {
   
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thinker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
      navigatorObservers: [
    FirebaseAnalyticsObserver(analytics: analytics),
  ],
      routes: {
        "findpeople":(context)=>EncontrarPessoas(),
        "splash":(context)=>Splash(),
        "newpost":(context)=>NewPost(),
        "login":(context)=>LoginPage(),
        "registro":(context)=>RegistroPage(),
        "home":(context)=>HomePage()
      },
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {


   final secure = new FlutterSecureStorage();
  @override
  void initState() {
    
    super.initState();

    Future.delayed(Duration(seconds: 1),()async{
      var logged = await secure.read(key: "token");
      if(logged != null) Navigator.of(context).pushReplacementNamed("home");
      else Navigator.of(context).pushReplacementNamed("login");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Thinker", style: TextStyle(color: Colors.purple, fontFamily: "Sans", fontSize: 30),),),
    );
  }
}