import 'dart:convert';

List<CursoModel> cursosFromJson(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed
      .map<CursoModel>((json) => CursoModel.fromJson(json))
      .toList();
}

class CursoModel {
  late int? id;
  late String? cursoName;
  late String? cursoDescription;
  late String? cursoNrc;
  late String? cursoImage;

  CursoModel({
    this.id,
    this.cursoName,
    this.cursoDescription,
    this.cursoNrc,
    this.cursoImage,
  });

  factory CursoModel.fromJson(Map<String, dynamic> json) {
    return CursoModel(
      id: json['id'] as int,
      cursoName: json['cursoName'] as String,
      cursoDescription: json['cursoDescription'],
      cursoNrc: json['cursoNrc'],
      cursoImage: json['cursoImage'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['cursoName'] = cursoName;
    data['cursoDescription'] = cursoDescription;
    data['cursoNrc'] = cursoNrc;
    data['cursoImage'] = cursoImage;
    return data;
  }
}