from django.shortcuts import render
from os import link
from .models import *
from .serializers import *
from rest_framework import viewsets
from .models import *
from rest_framework.generics import *
from django.contrib.auth.decorators import *
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated

# Create your views here.

class Quiz_view(viewsets.ModelViewSet):
    queryset = Quiz.objects.all()
    serializer_class = QuizSerializer
    
class QuizQuestion_view(viewsets.ModelViewSet):
    queryset = QuizQuestion.objects.all()
    serializer_class = QuizQuestionSerializer
    
class Take_view(viewsets.ModelViewSet):
    queryset = Take.objects.all()
    serializer_class = TakeSerializer

class Answer_view(viewsets.ModelViewSet):
    queryset = Answer.objects.all()
    serializer_class = AnswerSerializer
    
class TakeAnswer_view(viewsets.ModelViewSet):
    queryset = TakeAnswer.objects.all()
    serializer_class = TakeAnswerSerializer