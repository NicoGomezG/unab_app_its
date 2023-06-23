import 'package:flutter/material.dart';
import 'package:unab_app_its/Model/alumno_model.dart';
import 'package:unab_app_its/Services/api_alumno.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:unab_app_its/Services/api_alumno.dart';
import 'package:unab_app_its/Pantallas/alumno/alumno_curso.dart';

class AlumnosList extends StatefulWidget {
  const AlumnosList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AlumnosListState createState() => _AlumnosListState();
}

class _AlumnosListState extends State<AlumnosList> {
  // List<AlumnoModel> alumno = List<AlumnoModel>.empty(growable: true);
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadAlumnos(),
      ),
    );
  }

  Widget loadAlumnos() {
    return FutureBuilder(
      future: APIAlumno.getAlumnos(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<AlumnoModel>?> model,
          ) {
        if (model.hasData) {
          return alumnoList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget alumnoList(alumnos) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                // ignore: sort_child_properties_last
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/add-alumno',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Agregar Alumno',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),

              //   child: const Text('Add Alumno'),
              //Navigator.pushNamed(context,'/add-alumno',);
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: alumnos.length,
                itemBuilder: (context, index) {
                  return AlumnoItem(
                    model: alumnos[index],
                    onDelete: (AlumnoModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIAlumno.deleteAlumno(model.id).then(
                            (response) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}