import 'dart:io';

import 'package:flutter/material.dart';
import 'package:unab_app_its/Model/curso_model.dart';
import 'package:unab_app_its/Services/api_curso.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

import '../../config.dart';

class CursoAddEdit extends StatefulWidget {
  const CursoAddEdit({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CursoAddEditState createState() => _CursoAddEditState();
}

class _CursoAddEditState extends State<CursoAddEdit> {
  CursoModel? cursoModel;
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
          title: const Text('Form Curso'),
          elevation: 0,
        ),
        backgroundColor: Colors.grey[200],
        body: ProgressHUD(
          inAsyncCall: isApiCallProcess,
          opacity: 0.3,
          key: UniqueKey(),
          child: Form(
            key: globalFormKey,
            child: cursoForm(),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    cursoModel = CursoModel();

    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
        cursoModel = arguments['model'];
        isEditMode = true;
        setState(() {});
      }
    });
  }

  Widget cursoForm() {
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
              "cursoName",
              "curso Name",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El nombre del curso no puede ser vacio o nulo';
                }

                return null;
              },
                  (onSavedVal) => {
                    cursoModel!.cursoName = onSavedVal,
              },
              initialValue: cursoModel!.cursoName ?? "",
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
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
              "Curso NRC",
              "CURSO NRC",
                  (onValidateVal) {
                if (onValidateVal == null || onValidateVal.isEmpty) {
                  return 'El NRC no puede ser vacio o null ';
                }
                if (double.tryParse(onValidateVal) == null) {
                  return 'Insertar un numero valido  ';
                }

                return null;
              },
                  (onSavedVal) => {

                    cursoModel!.cursoNrc = onSavedVal,
              },
              initialValue: cursoModel!.cursoNrc == null
                  ? ""
                  : cursoModel!.cursoNrc.toString(),
              obscureText: false,
              borderFocusColor: Colors.black,
              borderColor: Colors.black,
              textColor: Colors.black,
              hintColor: Colors.black.withOpacity(0.7),
              borderRadius: 10,
              showPrefixIcon: false,
              suffixIcon: const Icon(Icons.add_box),
            ),
          ),
          picPicker(
            isImageSelected,
            cursoModel!.cursoImage ?? "",
                (file) => {
              setState(
                    () {
                  //model.productPic = file.path;
                      cursoModel!.cursoImage = file.path;
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
              "Guardar",
                  () {
                if (validateAndSave()) {
                  //print(cursoModel!.toJson());

                  setState(() {
                    isApiCallProcess = true;
                  });

                  APICurso.saveCurso(
                    cursoModel!,
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
                          '/list-curso',
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

  static Widget picPicker(
      bool isImageSelected,
      String fileName,
      Function onFilePicked,
      ) {
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
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }
}