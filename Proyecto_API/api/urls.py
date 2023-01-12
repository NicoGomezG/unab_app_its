from django.urls import path
from . import views

urlpatterns = [
    path('', views.ApiOverview, name='home'),
    path('all/', views.view_quiz, name='view_quiz'),
    path('all/', views.view_quizQuestion, name='view_quiQuestion'),
    path('update/<int:pk>/', views.update_quiz, name='update-quiz'),
    path('update/<int:pk>/', views.update_quizQuestion, name='update-quizQuestion'),
    path('update/<int:pk>/', views.update_take, name='update-take'),
    path('update/<int:pk>/', views.update_answer, name='update-answer'),
    path('item/<int:pk>/delete/', views.delete_quiz, name='delete-quiz'),
    path('item/<int:pk>/delete/', views.delete_answer, name='delete-answer'),
    path('create/', views.add_quiz, name='add-quiz'),
]
