import 'package:flutter/material.dart';
import 'package:unab_app_its/Pantallas/Home.dart';
import 'package:unab_app_its/Pantallas/createForm.dart';
import 'package:unab_app_its/Pantallas/inicio.dart';


// PAGINA DE LOGIN
class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade300,
        body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  const Image(
                    image: AssetImage('assets/Logo.png'),
                    fit: BoxFit.scaleDown,
                  ),


                  SizedBox(height: 25),


                  // Texto principal
                  Text(
                    'UNAB APP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),


                  SizedBox(height: 50),


                  //user
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Container(
                      decoration:BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue.shade900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Usuario',
                          ),
                        ),
                    ),



                    ),
                  ),


                  SizedBox(height: 10),


                  //contraseña
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Container(
                      decoration:BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.blue.shade900),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Contraseña',
                          ),
                        ),
                      ),



                    ),
                  ),


                  SizedBox(height: 10),


                  //boton INICIAR SESION
                  RawMaterialButton(
                    onPressed: ()async{
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Inicio()
                        ), //ENVIAR A LA PANTALLA DE Cuestionario
                      );
                    },

                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color:Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                      ),
                    ),
                  ),


                  SizedBox(height: 10),


                ],
              ),
            )


        )
    );
  }
}


