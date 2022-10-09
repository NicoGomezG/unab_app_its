import 'package:flutter/material.dart';
import 'package:unab_app_its/Pantallas/quiz_screen.dart';


class LoginScreen extends StatefulWidget {
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
                'UNAB ITS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 50),


              //email
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Container(
                  decoration:BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                    ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 150.0),
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
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 140.0),
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

            //boton
              RawMaterialButton(
                onPressed: ()async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        QuizScreen()), //ENVIAR A LA PANTALLA DE Cuestionario
                  );
                },

               child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color:Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Ingresar',
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

              //olvidaste tu contraseña ???
            ],
          ),
        )



    )
    );
  }
}


