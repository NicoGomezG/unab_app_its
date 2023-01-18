import 'package:flutter/material.dart';
import 'package:unab_app_its/Model/curso_model.dart';
import 'package:unab_app_its/Pantallas/Curso/curso_item.dart';
import 'package:unab_app_its/Services/api_curso.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class CursosList extends StatefulWidget {
  const CursosList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CursosListState createState() => _CursosListState();
}

class _CursosListState extends State<CursosList> {
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      appBar: AppBar(
        title: const Text('Django - CRUD'),
        elevation: 0,
      ),*/
      backgroundColor: Colors.grey[200],
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
        child: loadCursos(),
      ),
    );
  }

  Widget loadCursos() {
    return FutureBuilder(
      future: APICurso.getCursos(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<CursoModel>?> model,
          ) {
        if (model.hasData) {
          return cursoList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget cursoList(cursos) {
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
                          '/add-curso',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Agregar Curso',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/home',
                        );
                        //Navigator.push(context,MaterialPageRoute(builder: (context) => Home()),                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Menu',
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      )),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),

              //Navigator.pushNamed(context,'/add-product',);
              //Add Product
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: cursos.length,
                itemBuilder: (context, index) {
                  return CursoItem(
                    model: cursos[index],
                    onDelete: (CursoModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APICurso.deleteCurso(model.id).then(
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
