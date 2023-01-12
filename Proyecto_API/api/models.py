from pyexpat import model
from django.db import models

# Create your models here.

class Quiz(models.Model):
    name=models.CharField(max_length=50)
    slug = models.SlugField(unique = True, max_length= 255)
    summary = models.TextField()
    createdat = models.DateField()
    

class QuizQuestion(models.Model):
    name=models.CharField(max_length=50)
    slug = models.SlugField(unique = True, max_length= 255)
    summary = models.TextField()
    createdat = models.DateField()
    quiz_id = models.ForeignKey(Quiz, on_delete=models.CASCADE, null=True)

class Take(models.Model):
    score = models.IntegerField()
    userd_id = models.CharField(max_length= 10)
    quiz_id = models.ForeignKey(Quiz, on_delete=models.CASCADE, null=True)
    createdat = models.DateField()
    
class Answer(models.Model):
    take_id = models.ForeignKey(Take, on_delete=models.CASCADE, null=True)
    question_id = models.ForeignKey(QuizQuestion, on_delete=models.CASCADE, null=True)
    its_correct =  models.BooleanField( default=False )
    
class TakeAnswer(models.Model):
    take_id = models.ForeignKey(Take, on_delete=models.CASCADE, null=True)
    question_id = models.ForeignKey(QuizQuestion, on_delete=models.CASCADE, null=True)
    answer_id = models.ForeignKey(Answer, on_delete=models.CASCADE, null=True,)
    createdat = models.DateField()
  
