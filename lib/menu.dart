import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unab_app_its/Pantallas/Exam/exam_list.dart';
import 'package:unab_app_its/Pantallas/alumno/alumno_list.dart';
import 'package:unab_app_its/Pantallas/Curso/curso_list.dart';
import 'package:unab_app_its/Pantallas/inicio.dart';

import 'package:unab_app_its/Pantallas/Questions.dart';
import 'package:unab_app_its/Pantallas/create_quiz.dart';
import 'package:unab_app_its/main2.dart';

class Menu extends StatefulWidget {
  @override
  MenuState createState() => MenuState();
}

class MenuState extends State<Menu> {
  int _selectDrawerItem = 0;
  getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return const inicio();
      case 1:
        return const AlumnosList();
      case 2:
        return const CursosList();
      case 3:
        return CreateQuiz();//ExamList() CreateQuiz()
      case 4:
        return MyStatefulWidget();
    }
  }

  _onSelectItem(int pos) {
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UNAB APP"),
        backgroundColor: Colors.blue.shade900,
      ),
      drawer: Drawer(
        backgroundColor: Colors.blue.shade900,
        child: ListView(
          children: <Widget>[
            const UserAccountsDrawerHeader(
              accountName: Text('Jhon Stiff'),
              accountEmail: Text('J.stiffwang@uandresbello.edu'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/personalidad.png'),
              ),
            ),
            ListTile(
              textColor: Colors.white,
              title: const Text('Inicio'),
              leading: const Icon(Icons.phone),
              selected: (0 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(0);
              },
            ),
            const Divider(),
            ListTile(
              textColor: Colors.white,
              title: const Text('Alumnos'),
              leading: const Icon(Icons.person),
              selected: (1 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              textColor: Colors.white,
              title: const Text('Cursos'),
              leading: const Icon(Icons.assignment_late_outlined),
              selected: (2 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(2);
              },
            ),
            ListTile(
              textColor: Colors.white,
              title: const Text('Cuestionarios'),
              leading: const Icon(Icons.assignment),
              selected: (3 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(3);
              },
            ),
            const Divider(),
            ListTile(
              textColor: Colors.white,
              title: const Text('Cerrar Sesión'),
              leading: const Icon(Icons.touch_app_outlined),
              selected: (3 == _selectDrawerItem),
              onTap: () {
                _onSelectItem(4);
              },
            ),
          ],
        ),
      ),
      body: getDrawerItemWidget(_selectDrawerItem),
      backgroundColor: Colors.blueGrey[50],
    );
  }
}