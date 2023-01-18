from django.contrib import admin
from .models import Answer, Quiz, QuizQuestion, TakeAnswer, Take, Alumno, Curso, TomaRamos, AsignarCurso

# Register your models here.

admin.site.register(Quiz)
admin.site.register(QuizQuestion)
admin.site.register(TakeAnswer)
admin.site.register(Take)
admin.site.register(Answer)
admin.site.register(Alumno)
admin.site.register(Curso)
admin.site.register(AsignarCurso)
admin.site.register(TomaRamos)