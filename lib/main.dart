import 'package:flutter/material.dart';
import 'package:food_delivery/constant.dart';
import 'package:food_delivery/home_screen.dart';
import 'login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  runApp(const InitialScreen.Initial());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

  class InitialScreen extends StatelessWidget {
  const InitialScreen.Initial({Key? key}) : super(key: key);


    @override
    Widget build(BuildContext context) {
      return  const MaterialApp(
        home: LoginScreen(),
        title: appName,
        debugShowCheckedModeBanner: false,
      );
    }
  }


