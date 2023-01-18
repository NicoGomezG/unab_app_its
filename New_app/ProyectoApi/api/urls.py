from django.urls import path
from . import views
from rest_framework import routers
from django.contrib import admin
from api.views import AlumnoViewSet, LoginView, LogoutView, UserViewSet, CursoViewSet, TomaRamosViewSet, AsignarCursoViewSet
from rest_framework.authtoken.views import obtain_auth_token
from .views import login

router=routers.DefaultRouter()
router.register('alumno', AlumnoViewSet)
router.register('user', UserViewSet)
router.register('curso', CursoViewSet)
router.register('tomaRamos', TomaRamosViewSet)
router.register('asignarCurso', AsignarCursoViewSet)

urlpatterns = [
    path('', views.ApiOverview, name='home'),
    path('all/', views.view_quiz, name='view_quiz'),
    path('all/', views.view_quizQuestion, name='view_quiQuestion'),
    path('updateQuiz/', views.update_quiz, name='update-quiz'),
    path('updateQuizQ/', views.update_quizQuestion, name='update-quizQuestion'),
    path('updateTk/', views.update_take, name='update-take'),
    path('updateAns/', views.update_answer, name='update-answer'),
    path('item/<int:pk>/delete/', views.delete_quiz, name='delete-quiz'),
    path('item/<int:pk>/delete/', views.delete_answer, name='delete-answer'),
    path('create/', views.add_quiz, name='add-quiz'),
    path('api-token-auth/', obtain_auth_token, name='api_token_auth'),
    path('login/', login),
    path('logout/', LogoutView.as_view()),
    

] + router.urls
