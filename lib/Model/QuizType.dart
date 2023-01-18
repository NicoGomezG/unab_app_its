/*
import 'package:unab_app_its/Model/question_model.dart';

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