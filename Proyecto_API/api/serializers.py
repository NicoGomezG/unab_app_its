from dataclasses import fields
from rest_framework import serializers
from .models import * 

class TakeSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Take
        fields = ('score', 'user_id', 'quiz_id', 'createdat')
        read_only_fields =()

class AnswerSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Answer
        fields = ('take_id', 'quiz_id', 'question_id', 'its_correct')
        read_only_fields =()

class QuizQuestionSerializer(serializers.ModelSerializer):
    answer_set= AnswerSerializer(read_only= True, many = True)
    
    class Meta:
        model = QuizQuestion
        fields = ('name', 'slug', 'summary', 'createdat','quiz_id', 'answer_set')
        read_only_fields =()

class QuizSerializer(serializers.ModelSerializer):
    question_set = QuizQuestionSerializer(read_only= True, many = True)
    takes_set = TakeSerializer(read_only =True, many = True)
    class Meta:
        model = Quiz
        fields = ('name', 'slug', 'summary', 'createdat','question_set','takes_set')
        

                
class TakeAnswerSerializer(serializers.ModelSerializer):
    answer_set = AnswerSerializer(read_only =True)
    
    class Meta:
        model = TakeAnswer
        fields = ('take_id', 'question_id', 'answer_id', 'createdat','answer_set')
        read_only_fields =()


