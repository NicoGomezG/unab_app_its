import 'package:flutter/material.dart';

class Quiz {
  final String name;
  final String description;
  final String category;
  final String subcategory;
  final List<Question> questions;

  Quiz({required this.name, required this.description, required this.category, required this.subcategory, required this.questions});

  Map<String, dynamic> toJson() {
    return {
      'quiz': {
        'name': name,
        'description': description,
        'category': category,
        'subcategory': subcategory,
      },
      'questions': questions.map((question) => question.toJson()).toList()
    };
  }
}

class Question {
  final String question;
  final List<Answer> answers;

  Question({required this.question, required this.answers});

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answers': answers.map((answer) => answer.toJson()).toList()
    };
  }
}

class Answer {
  final String answer;
  final bool correct;

  Answer({required this.answer, required this.correct});

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'correct': correct
    };
  }
}

// ESTAS SON LAS FUNCIONES PARA BORRAR UN QUIZ O PARA GUARDARLO

//  esta funcion es para guardar el quiz y la de abajo  para eliminarlo
Future<http.Response> createQuiz(Quiz quiz) async {
  final http.Response response = await http.post(
    'your_backend_url/quizzes/',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(quiz.toJson()),
  );
  if (response.statusCode != 201) {
    throw Exception('Failed to create quiz.');
  }
  return response;
}

Future<http.Response> deleteQuiz(int id) async {
  final http.Response response = await http.delete(
    'your_backend_url/quizzes/$id/',
  );
  if (response.statusCode != 204) {
    throw Exception('Failed to delete quiz.');
  }
  return response;
}