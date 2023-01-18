import 'package:flutter/foundation.dart';
import 'package:unab_app_its/Model/curso_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APICurso {
  static var client = http.Client();

  static Future<List<CursoModel>?> getCursos() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.cursosAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(cursosFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveCurso(
      CursoModel model,
      bool isEditMode,
      bool isFileSelected,
      ) async {
    var cursURL = "${Config.cursosAPI}/";

    if (isEditMode) {
      cursURL = "$cursURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, cursURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["cursoName"] = model.cursoName!;
    request.fields["cursoNrc"] =
        double.parse(model.cursoNrc!).toStringAsFixed(2);
    //request.headers["Authorization"] = "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4";

    if (model.cursoImage != null && isFileSelected) {
      http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
        'cursoImage',
        model.cursoImage!,
      );

      request.files.add(multipartFile);
    }

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteCurso(cursId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.cursosAPI}/$cursId/");

    var response = await client.delete(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}