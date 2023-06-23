import 'dart:convert';

List<ExamModel> examsFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<ExamModel>((json) => ExamModel.fromJson(json))
      .toList();
}

class ExamModel {
  late int? id;
  late String? Question;
  late String? Option1;
  late String? Option2;
  late String? Option3;
  late String? Option4;
  late String? Corrans;


  ExamModel({
    this.id,
    this.Question,
    this.Option1,
    this.Option2,
    this.Option3,
    this.Option4,
    this.Corrans,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['id'] as int,
      Question: json['Question'] as String,
      Option1: json['Option1']as String,
      Option2: json['Option2'] as String,
      Option3: json['Option3'] as String,
      Option4: json['Option4'] as String,
      Corrans: json['Corrans'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['Question'] = Question;
    data['Option1'] = Option1;
    data['Option2'] = Option2;
    data['Option3'] = Option3;
    data['Option4'] = Option4;
    data['Corrans'] = Corrans;

    return data;
  }
}