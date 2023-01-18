import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unab_app_its/Pantallas/create_quiz.dart';
import 'package:unab_app_its/Widget/widgets.dart';
import 'package:http/http.dart' as http;

//PAGINA DE INICIO
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 /* final url = Uri.parse("http://10.0.2:3306/phpmyadmin/index.php?route=/database/structure&db=its");*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => CreateQuiz()
          ));
        },
      ),
    );
  }
/*  Future getAlternativa() async {
    final res = await http.get(url);
    final objetos = jsonDecode(res.body);
    final lista = List.from((objetos));

    lista.forEach((element) {
      final Alternativa = Alternativa()
    })
  }*/
}
