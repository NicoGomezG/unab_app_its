import 'package:flutter/material.dart';
import 'package:unab_app_its/Pantallas/Home.dart';
import 'package:unab_app_its/Pantallas/login_page.dart';
import 'package:unab_app_its/Pantallas/quiz_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //

        primarySwatch: Colors.blue,
      ),
      home:  LoginScreen( //Inicio de app en login
      ),
    );


  }
}