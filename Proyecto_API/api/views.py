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
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status

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

@api_view(['GET'])
def ApiOverview(request):
    api_urls = {
        'all_items': '/',
        'Search by Category': '/?category=category_name',
        'Search by Subcategory': '/?subcategory=category_name',
        'Add': '/create',
        'Update': '/update/pk',
        'Delete': '/item/pk/delete'
    }
  
    return Response(api_urls)

## QUIZ GET
@api_view(['GET'])
def view_quiz(request):
    
    # chequeo de parametros de URL
    if request.query_params:
        quiz = Quiz.objects.filter(**request.query_param.dict())
    else:
        quiz = Quiz.objects.all()
  
    # si hay algo en los items arroja error
    if quiz:
        data = QuizSerializer(quiz, many=True)
        return Response(data.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
## QUIZQUESTION GET
@api_view(['GET'])
def view_quizQuestion(request):
    
    # chequeo de parametros de URL
    if request.query_params:
        quizQuestion = QuizQuestion.objects.filter(**request.query_param.dict())
    else:
        quizQuestion = QuizQuestion.objects.all()
  
    # si hay algo en los items arroja error
    if quizQuestion:
        data = QuizQuestionSerializer(quizQuestion, many=True)
        return Response(data.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
##QUIZ  UPDATE POST
@api_view(['POST'])
def update_quiz(request, pk):
    item = Quiz.objects.get(pk=pk)
    data = QuizSerializer(instance=item, data=request.data)
  
    if data.is_valid():
        data.save()
        return Response(data.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)

#quiz create post
@api_view(['POST'])
def add_quiz(request):
    item = QuizSerializer(data=request.data)
  
    # validating for already existing data
    if Quiz.objects.filter(**request.data).exists():
        raise serializers.ValidationError('This data already exists')
  
    if item.is_valid():
        item.save()
        return Response(item.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)
    
    
##QuizQuestion POST
@api_view(['POST'])
def update_quizQuestion(request, pk):
    item = QuizQuestion.objects.get(pk=pk)
    data = QuizQuestionSerializer(instance=item, data=request.data)
  
    if data.is_valid():
        data.save()
        return Response(data.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)

##TAKE POST
@api_view(['POST'])
def update_take(request, pk):
    item = Take.objects.get(pk=pk)
    data = TakeSerializer(instance=item, data=request.data)
  
    if data.is_valid():
        data.save()
        return Response(data.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)

##ANSWER POST
@api_view(['POST'])
def update_answer(request, pk):
    item = Answer.objects.get(pk=pk)
    data = AnswerSerializer(instance=item, data=request.data)
  
    if data.is_valid():
        data.save()
        return Response(data.data)
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)

#DELETE QUIZ
@api_view(['DELETE'])
def delete_quiz(request, pk):
    item = get_object_or_404(Quiz, pk=pk)
    item.delete()
    return Response(status=status.HTTP_202_ACCEPTED)

#DELETE Answer
@api_view(['DELETE'])
def delete_answer(request, pk):
    item = get_object_or_404(Answer, pk=pk)
    item.delete()
    return Response(status=status.HTTP_202_ACCEPTED)