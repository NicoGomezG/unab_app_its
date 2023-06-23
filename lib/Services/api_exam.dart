import 'package:flutter/foundation.dart';
import 'package:unab_app_its/Model/exam_model.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';

class APIExam {
  static var client = http.Client();

  static Future<List<ExamModel>?> getExam() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.examAPI,
    );

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return compute(examsFromJson, response.body);

      //return true;
    } else {
      return null;
    }
  }

  static Future<bool> saveExam(
      ExamModel model,
      bool isEditMode,
      ) async {
    var exaURL = "${Config.examAPI}/";

    if (isEditMode) {
      exaURL = "$exaURL${model.id.toString()}/";
    }

    var url = Uri.http(Config.apiURL, exaURL);

    var requestMethod = isEditMode ? "PUT" : "POST";

    var request = http.MultipartRequest(requestMethod, url);
    request.fields["Question"] = model.Question!;
    request.fields["Option1"] = model.Option1!;
    request.fields["Option2"] = model.Option2!;
    request.fields["Option3"] = model.Option3!;
    request.fields["Option4"] = model.Option4!;
    request.fields["Corrans"] = model.Corrans!;
    //request.headers["Authorization"] = "token 6c7e9f684c68adf057008ce8a0f4dc11fae3c0d4";

    var response = await request.send();

    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteExam(exaId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, "${Config.cursosAPI}/$exaId/");

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