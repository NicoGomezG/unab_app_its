from django.db import models
import datetime
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


class Person(models.Model):
    nombre = models.CharField('Nombre', max_length = 100)
    apellido = models.CharField('Apellido', max_length = 200)
    foto = models.ImageField(null=True, blank=True, upload_to='fotos/')
    class Meta:
        abstract = True
        
class Alumno(Person):
    email = models.EmailField(blank=True)

    def __str__(self):
        return '{0},{1}'.format(self.apellido,self.nombre)

class Curso(models.Model):
    cursoName = models.CharField(max_length=200)
    cursoDescription = models.CharField(blank=True, max_length=200)
    nrc = models.DecimalField(max_digits=10, decimal_places=2)
    fotoprofesor = models.ImageField(null=True, blank=True, upload_to='images/')
    # create_at = models.DateTimeField(default=datetime.datetime.now)
    def __str__ (self):
        return self.cursoName

class TomaRamos(models.Model) :
    alumno = models.ForeignKey(Alumno,on_delete=models.CASCADE, verbose_name='Alumno ok', null=False)
    description = models.TextField(blank = True)
    def __str__ (self):
         return '{0}'.format(self.id)
     
class AsignarCurso(models.Model):
    tomaRamos = models.ForeignKey(TomaRamos, on_delete=models.CASCADE, verbose_name='Cupos utilizado', null=False)
    curso = models.ForeignKey(Curso,on_delete=models.CASCADE, verbose_name='Curso', null=False)
    nrc = models.FloatField()
    modified = models.DateTimeField(auto_now=True)
    created_at = models.DateTimeField(auto_now_add=True)
    state = models.BooleanField(default = True)
    def __str__(self):
        return f'{self.tomaRamos} to {self.curso}'

    class Meta:
        indexes = [
                models.Index(fields=['tomaRamos','curso',]),
            ]