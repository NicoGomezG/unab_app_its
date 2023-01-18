/*import 'package:flutter/material.dart';
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

            //BOTON "SIGUIENTE" A QUESTIONS()

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
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: blueButton(context, "Siguiente")
              ),
            ),


            SizedBox(height: 60,),

          ],),
        ),

      )

    );
  }
}
*/