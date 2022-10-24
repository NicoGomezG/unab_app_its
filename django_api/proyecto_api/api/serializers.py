from dataclasses import fields
from rest_framework import serializers
from .models import * 

class QuizSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Quiz
        fields = ('name', 'slug', 'summary', 'createdat')
        read_only_fields =()

class QuizQuestionSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = QuizQuestion
        fields = ('name', 'slug', 'summary', 'createdat','quiz_id')
        read_only_fields =()

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

class TakeAnswerSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = TakeAnswer
        fields = ('take_id', 'question_id', 'answer_id', 'createdat')
        read_only_fields =()


