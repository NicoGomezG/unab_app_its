/*
class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "Cual de estos es un condicional",
    [
      Answer("string", false),
      Answer("print", false),
      Answer("if, else", true),
      Answer("sum", false),
    ],
  ));

  list.add(Question(
    "cual es la correcta identacion de un for",
    [
      Answer("for(i = 0, i<n, i++){}", true),
      Answer("for(if = true){}", false),
      Answer("for(i= 0, i++){}", false),
      Answer("for(i=n, i< n, i++){}", false),
    ],
  ));



  return list;
}
