import 'package:flutter/material.dart';
import 'package:unab_app_its/Model/exam_model.dart';
import 'package:unab_app_its/Services/api_exam.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:unab_app_its/Services/api_exam.dart';
import 'package:unab_app_its/Pantallas/Exam/exam_item.dart';

class ExamsList extends StatefulWidget {
  const ExamsList({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ExamsListState createState() => _ExamsListState();
}

class _ExamsListState extends State<ExamsList> {
  // List<ExamsModel> examno = List<ExamsModel>.empty(growable: true);
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
        child: loadExams(),
      ),
    );
  }

  Widget loadExams() {
    return FutureBuilder(
      future: APIExam.getExam(),
      builder: (
          BuildContext context,
          AsyncSnapshot<List<ExamModel>?> model,
          ) {
        if (model.hasData) {
          return examList(model.data);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget examList(exams) {
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
                          '/add-exam',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      child: const Text(
                        'Agregar Examen',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),

              //   child: const Text('Add exammno'),
              //Navigator.pushNamed(context,'/add-exammno',);
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  return ExamItem(
                    model: exams[index],
                    onDelete: (ExamModel model) {
                      setState(() {
                        isApiCallProcess = true;
                      });

                      APIExam.deleteExam(model.id).then(
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