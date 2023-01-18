import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unab_app_its/Pantallas/alumno/alumno_list.dart';
import 'package:unab_app_its/usuario.dart';
import 'package:unab_app_its/menu.dart';
import 'package:unab_app_its/Pantallas/alumno/alumno_add_edit.dart';
import 'package:unab_app_its/Pantallas/alumno/alumno_list.dart';
import 'package:unab_app_its/Pantallas/Curso/curso_add_edit.dart';
import 'package:unab_app_its/Pantallas/Curso/curso_list.dart';
import 'package:unab_app_its/config.dart';
import 'package:unab_app_its/Pantallas/inicio.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'UNAB APP';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        home: Scaffold(
          appBar: AppBar(title: const Text(_title)),
          body: const MyStatefulWidget(),
        ),
        routes: {
          '/list-alumno': (context) => const AlumnosList(),
          '/add-alumno': (context) => const AlumnoAddEdit(),
          '/edit-alumno': (context) => const AlumnoAddEdit(),
          '/list-curso': (context) => const CursosList(),
          '/add-curso': (context) => const CursoAddEdit(),
          '/edit-curso': (context) => const CursoAddEdit(),
          '/home': (context) => Menu(),
        });
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final urllogin = Uri.http(Config.apiURL, Config.loginAPI);

  final urlobtenertoken = Uri.http(Config.apiURL, Config.obtenertokenAPI);
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'UNAB APP',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            const Image(
              image: AssetImage('assets/Logo.png'),
              fit: BoxFit.scaleDown,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Usuario',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contraseña',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: const Text(
                'Olvido su contraseña',
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Iniciar Sesión'),
                  onPressed: () {
                    inicio();
                    //login();  SACAR COMENTARIO
                   },
                )),
          ],
        ));
  }

  void showSnackbar(String msg) {
    final snack = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  Future<void> login() async {
    if (nameController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(
          "${nameController.text.isEmpty ? "-User " : ""} ${passwordController.text.isEmpty ? "- Contraseña " : ""} requerido");
      return;
    }
    final datosdelposibleusuario = {
      "username": nameController.text,
      "password": passwordController.text
    };
    final res = await http.post(urllogin,
        headers: headers,
        body: jsonEncode(datosdelposibleusuario));

    if (res.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res.statusCode != 200) {
      showSnackbar("Ups ha habido un al obtener usuario y contraseña ");
    }
    final res2 = await http.post(urlobtenertoken,
        headers: headers,
        body: jsonEncode(datosdelposibleusuario));


    final data2 =  Map.from(jsonDecode(res2.body));
    if (res2.statusCode == 400) {
      showSnackbar("error");
      return;
    }
    if (res2.statusCode != 200) {
      showSnackbar("Ups ha habido al obtener el token ");
    }
    final token = data2["token"];
    final user = Usuario(
        username: nameController.text,
        password: passwordController.text,
        token: token);
    // ignore: use_build_context_synchronously
    Navigator.pushNamed(
      context,
      '/home',
    );
  }
}

