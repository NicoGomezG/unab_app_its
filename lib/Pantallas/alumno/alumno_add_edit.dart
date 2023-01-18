import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unab_app_its/Model/alumno_model.dart';
import 'package:unab_app_its/Services/api_alumno.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:email_validator/email_validator.dart';
import '../../config.dart';

class AlumnoAddEdit extends StatefulWidget {
  const AlumnoAddEdit({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AlumnoAddEditState createState() => _AlumnoAddEditState();
}

class _AlumnoAddEditState extends State<AlumnoAddEdit> {
  AlumnoModel? alumnoModel;
  static final GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  bool isApiCallProcess = false;
  List<Object> images = [];
  bool isEditMode = false;
  bool isImageSelected = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Form Alumno'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: alumnoForm(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    alumnoModel = AlumnoModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute
          .of(context)
          ?.settings
          .arguments != null) {
        final Map arguments = ModalRoute
            .of(context)
            ?.settings
            .arguments as Map;
        alumnoModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget alumnoForm() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Alumno Name",
              "Nombre del Alumno",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre del alumno no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) =>
              {
                alumnoModel!.nombre = onSavedVal,
              },
              initialValue: alumnoModel!.nombre ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              suffixIcon: const Icon(Icons.person),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              //const Icon(Icons.person),
              "Alumno Apellido",
              "Apellido del Alumno",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'los cursos inscritos no pueden ser vacio o null ';
                }

                return null;
              },
                  (onSavedVal) =>
              {
                //alumnoModel!.alumnoApellido = int.parse(onSavedVal),
                alumnoModel!.apellido = onSavedVal,
              },
              initialValue: alumnoModel!.apellido == null
                  ? ""
                  : alumnoModel!.apellido.toString(),
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.person),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10,
              top: 10,
            ),
            child: FormHelper.inputFieldWidget(
              context,
              "alumno correo",
              "Correo del alumno",
                  (onValidateVal) {
                if (EmailValidator.validate(onValidateVal) == false) {
                  return 'Email Incorrecto!!! ';
                }
                return null;
              },
                  (onSavedVal) =>
              {
                alumnoModel!.email = onSavedVal,
              },
              initialValue: alumnoModel!.email == null
                  ? ""
                  : alumnoModel!.email.toString(),
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.email),
            ),
          ),
          picPicker(
            isImageSelected,
            alumnoModel!.foto ?? "",
                (file) =>
            {
              setState(
                    () {
                  //model.alumnoPic = file.path;
                  alumnoModel!.foto = file.path;
                  isImageSelected = true;
                },
              )
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: FormHelper.submitButton(
              "Save",
                  () {
                if (validateAndSave()) {
                  //print(alumnoModel!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  APIAlumno.saveAlumno(
                    alumnoModel!,
                    isEditMode,
                    isImageSelected,
                  ).then(
                        (response) {
                      setState(() {
                        isApiCallProcess = false;
                      });

                      if (response) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/list-alumno',
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

  static Widget picPicker(bool isImageSelected,
      String fileName,
      Function onFilePicked,) {
    Future<XFile?> imageFile;
    ImagePicker picker = ImagePicker();

    return Column(
      children: [
        fileName.isNotEmpty
            ? isImageSelected
            ? Image.file(
          File(fileName),
          width: 300,
          height: 300,
        )
            : SizedBox(
          child: Image.network(
            fileName,
            width: 200,
            height: 200,
            fit: BoxFit.scaleDown,
          ),
        )
            : SizedBox(
          child: Image.network(
            "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png",
            width: 200,
            height: 200,
            fit: BoxFit.scaleDown,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Icon(Icons.image, size: 35.0),
                onPressed: () {
                  imageFile = picker.pickImage(source: ImageSource.gallery);
                  imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
            SizedBox(
              height: 35.0,
              width: 35.0,
              child: IconButton(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                icon: const Icon(Icons.camera, size: 35.0),
                onPressed: () {
                  imageFile = picker.pickImage(source: ImageSource.camera);
                  imageFile.then((file) async {
                    onFilePicked(file);
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  isValidURL(url) {
    return Uri
        .tryParse(url)
        ?.hasAbsolutePath ?? false;
  }
}