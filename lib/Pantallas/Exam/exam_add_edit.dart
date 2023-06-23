import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unab_app_its/Model/exam_model.dart';
import 'package:unab_app_its/Services/api_exam.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../config.dart';

class ExamAddEdit extends StatefulWidget {
  const ExamAddEdit({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExamAddEditState createState() => _ExamAddEditState();
}

class _ExamAddEditState extends State<ExamAddEdit> {
  ExamModel? examModel;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Exam'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: examForm(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    examModel = ExamModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        examModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget examForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //QUESTION
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "examName",
              "exam Name",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre del examen no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                examModel!.Question = onSavedVal,
              },
              initialValue: examModel!.Question ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),

          //opcion 1
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Opcion 1",
              "Opcion 1",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre de Opcion 1 no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                examModel!.Option1 = onSavedVal,
              },
              initialValue: examModel!.Option1 ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),

          //OPCION2
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Opcion 2",
              "Opcion 2",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre del Opcion 2 no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                examModel!.Option2 = onSavedVal,
              },
              initialValue: examModel!.Option2 ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),

          //OPCION3
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Opcion 3",
              "Opcion 3",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre de Opcion 3 no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                examModel!.Option3 = onSavedVal,
              },
              initialValue: examModel!.Option3 ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),

          //OPCION 4
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Opcion 4",
              "Opcion 4",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre del Opcion 4 no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                examModel!.Option4 = onSavedVal,
              },
              initialValue: examModel!.Option4 ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),

          //CORRANS
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Corrans",
              "Corrans",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre de la opcion correcta no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                examModel!.Corrans = onSavedVal,
              },
              initialValue: examModel!.Corrans ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
            ),
          ),


          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Guardar",
                  () {
                if (validateAndSave()) {
                  //print(cursoModel!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  APIExam.saveExam(
                    examModel!,
                    isEditMode,
                  ).then(
                        (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/list-exam',
                              (route) => false,
                        );
                      } else {
                        FormHelper.showSimpleAlertDialog(
                          context,
                          Config.appName,
                          "Error occurido",
                          "OK",
                              () {
                            Navigator.of(context).pop();
                          },
                        );
                      }
                    },
                  );
                }
              },
              btnColor: HexColor("283B71"),
              borderColor: Colors.white,
              txtColor: Colors.white,
              borderRadius: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
  isValidURL(url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}