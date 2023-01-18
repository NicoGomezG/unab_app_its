from dataclasses import fields
from rest_framework import serializers
from .models import * 
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token


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


class AlumnoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Alumno
        fields = '__all__'

class PersonSerializer(serializers.ModelSerializer):
    class Meta:
        model = Person
        fields = '__all__'

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'last_name', 'username', 'password', 'groups', 'email']
         #esconder password
        extra_kwargs = {
            'password': {'write_only': True, 'required': True}
        }

    def create(self, validated_data):
        user = User.objects.create_user(**validated_data)
        Token.objects.create(user=user)
        return user

class CursoSerializer(serializers.ModelSerializer):
    class Meta:
        model = Curso
        fields = '__all__'
        read_only_fields = ('created_at',)

class TomaRamosSerializer(serializers.ModelSerializer):
    class Meta:
        model = TomaRamos
        fields = '__all__'
        extra_kwargs = {
            'fecha': {'read_only': True, 'required': False},
            # 'fecha': {'read_only': True},
        }    

class AsignarCursoSerializer(serializers.ModelSerializer):
    class Meta:
        model = AsignarCurso
        fields = '__all__'