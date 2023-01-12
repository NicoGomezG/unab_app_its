import 'package:flutter/material.dart';
import 'package:unab_app_its/Widget/widgets.dart';

class CreateQuestion extends StatefulWidget {
  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {

  final _formKey = GlobalKey<FormState>();
  late String questionTitle, answerA, answerB, answerC, answerD;

 /* uploadQuizData(){

    if(_formKey.currentState.validate()){


    }
  }*/

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
                  validator:(value) => value!.isEmpty ?  "Ingresar titulo de la pregunta" : null,
                  decoration: InputDecoration(
                    hintText: 'Pregunta',
                  ),
                  onChanged: (value){
                    questionTitle = value;
                  }
              ),

              SizedBox(height: 25),

              TextFormField(
                  validator:(value) => value!.isEmpty ?  "Alternativa A faltante" : null,
                  decoration: InputDecoration(
                    hintText: 'Alternativa A',
                  ),
                  onChanged: (value){
                    answerA = value;
                  }
              ),

              SizedBox(height: 25),

              TextFormField(
                  validator:(value) => value!.isEmpty ?  "Alternativa B faltante" : null,
                  decoration: InputDecoration(
                    hintText: 'Alternativa B',
                  ),
                  onChanged: (value){
                    answerB = value;
                  }
              ),

              SizedBox(height: 25),

              TextFormField(
                  validator:(value) => value!.isEmpty ?  "Alternativa C faltante" : null,
                  decoration: InputDecoration(
                    hintText: 'Alternativa C',
                  ),
                  onChanged: (value){
                    answerC = value;
                  }
              ),

              SizedBox(height: 25),

              TextFormField(
                  validator:(value) => value!.isEmpty ?  "Alternativa D faltante" : null,
                  decoration: InputDecoration(
                    hintText: 'Alternativa D',
                  ),
                  onChanged: (value){
                    answerD = value;
                  }
              ),

              Spacer(),

         /*     GestureDetector(   POR IMPLEMENTAR
                  onTap:(){
                    //ToDO
                  } ,
                  child:
              ),*/
              blueButton(context, 'Agregar Pregunta'),
              SizedBox(height: 5,),
              blueButton(context, 'Finalizar Cuestionario'),

              SizedBox(height: 60,),

            ],),
          ),

        )

    );
  }
}
