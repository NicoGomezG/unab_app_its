from django.shortcuts import render
from os import link
from .models import *
from .serializers import *
from rest_framework import viewsets, permissions
from .models import *
from rest_framework.generics import *
from django.contrib.auth.decorators import *
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status , views , response 
from django.shortcuts import render, redirect, HttpResponseRedirect
from rest_framework import authentication
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token
from django.views.decorators.csrf import csrf_exempt


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

class AlumnoViewSet(viewsets.ModelViewSet):
      queryset = Alumno.objects.all()  
      permission_classes = [permissions.AllowAny]
      serializer_class = AlumnoSerializer
      
class UserViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [permissions.IsAdminUser,]
    authentication_classes = [authentication.BasicAuthentication,]

#login 
@csrf_exempt
class LoginView(views.APIView):
    permission_classes = [permissions.AllowAny]
    def post(self, request):
        # Recuperamos las credenciales y autenticamos al usuario
        username2= request.data.get('username', None)
        password2 = request.data.get('password', None)
        if username2 is None or password2 is None:
            return response.Response({'message': 'Please provide both username and password'},status=status.HTTP_400_BAD_REQUEST)
        user2 = authenticate(username=username2, password=password2)
        if not user2:
            return response.Response({'message': 'Usuario o Contraseña incorrecto !!!! '},status=status.HTTP_404_NOT_FOUND)

        token, _ = Token.objects.get_or_create(user=user2)
        # Si es correcto añadimos a la request la información de sesión
        if user2:
            # para loguearse una sola vez
            # login(request, user)
            return response.Response({'message':'usuario y contraseña correctos!!!!'},status=status.HTTP_200_OK)
            #return response.Response({'token': token.key}, status=status.HTTP_200_OK)

        # Si no es correcto devolvemos un error en la petición
        return response.Response(status=status.HTTP_404_NOT_FOUND)        

class LogoutView(views.APIView):
    authentication_classes = [authentication.TokenAuthentication]
    def post(self, request):        
        request.user.auth_token.delete()
        # Borramos de la request la información de sesión
        logout(request)
        # Devolvemos la respuesta al cliente
        return response.Response({'message':'Sessión Cerrada y Token Eliminado !!!!'},status=status.HTTP_200_OK)

class CursoViewSet(viewsets.ModelViewSet):
    queryset = Curso.objects.all()
    serializer_class = CursoSerializer
    permission_classes = [permissions.AllowAny]
    # permission_classes = [permissions.IsAuthenticatedOrReadOnly]
    # authentication_classes = [authentication.BasicAuthentication]

class TomaRamosViewSet(viewsets.ModelViewSet):
    queryset = TomaRamos.objects.all()
    permission_classes = [permissions.IsAuthenticated]
    authentication_classes = [authentication.TokenAuthentication,]
    serializer_class = TomaRamosSerializer

class AsignarCursoViewSet(viewsets.ModelViewSet):
    queryset = AsignarCurso.objects.all()
    permission_classes = [permissions.AllowAny]
    serializer_class = AsignarCursoSerializer

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

## Endpoint para guardar los quizz completos
@api_view(['POST'])
def update_answer(request):
    return Response(request.data)

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

## make a post request to this endpoint to save the whole quiz with questions and answers in one go
## the quiz will be saved first and then the questions and answers will be saved
## the quiz id will be used to save the questions and answers
## the questions and answers will be saved in the same order as they are in the request
@api_view(['POST'])
def saveQuiz(request):
    # save the quiz
    quiz = request.data['quiz']
    quiz_serializer = QuizSerializer(data=quiz)
    if quiz_serializer.is_valid():
        quiz_serializer.save()
    else:
        return Response(status=status.HTTP_404_NOT_FOUND)

    # save the questions
    questions = request.data['questions']
    for question in questions:
        question_serializer = QuizQuestionSerializer(data=question)
        if question_serializer.is_valid():
            question_serializer.save(quiz=quiz_serializer.data['id'])
        else:
            return Response(status=status.HTTP_404_NOT_FOUND)

        # save the answers
        answers = question['answers']
        for answer in answers:
            answer_serializer = AnswerSerializer(data=answer)
            if answer_serializer.is_valid():
                answer_serializer.save(question=question_serializer.data['id'])
            else:
                return Response(status=status.HTTP_404_NOT_FOUND)

    return Response(status=status.HTTP_200_OK)



