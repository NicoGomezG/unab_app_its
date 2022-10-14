import 'package:flutter/material.dart';
import 'package:unab_app_its/Pantallas/Questions.dart';
import 'package:unab_app_its/Widget/widgets.dart';

class CreateQuiz extends StatefulWidget {
  @override
  State<CreateQuiz> createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _formKey = GlobalKey<FormState>();
  late String quizTitle, quizDescription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //barra superior
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        brightness: Brightness.light,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            TextFormField(
              validator:(value) => value!.isEmpty ?  "Ingresar titulo del cuestionario" : null,
              decoration: InputDecoration(
                hintText: 'Titulo del cuestionario',
              ),
              onChanged: (value){
                quizTitle = value;
              }
            ),

            SizedBox(height: 25),

            TextFormField(
                validator:(value) => value!.isEmpty ?  "Ingresar descripcion del cuestionario" : null,
                decoration: InputDecoration(
                  hintText: 'Descripccion del cuestionario',
                ),
                onChanged: (value){
                  quizDescription = value;
                }
            ),

            Spacer(),

            //blueButton(context, 'Creacion de alternativas'),

            RawMaterialButton(
              onPressed: ()async{
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CreateQuestion()), //ENVIAR A LA PANTALLA DE Cuestionario
                );
              },

              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                child: Container(
                    padding: EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color:Colors.blueAccent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: blueButton(context, "Crear preguntas")
                ),
              ),
            ),


            SizedBox(height: 60,),

          ],),
        ),

      )

    );
  }
}
