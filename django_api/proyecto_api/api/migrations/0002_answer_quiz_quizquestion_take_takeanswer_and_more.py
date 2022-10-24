# Generated by Django 4.1.1 on 2022-10-24 00:50

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Answer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('its_correct', models.BooleanField(default=False)),
            ],
        ),
        migrations.CreateModel(
            name='Quiz',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('slug', models.SlugField(max_length=255, unique=True)),
                ('summary', models.TextField()),
                ('createdat', models.DateField()),
            ],
        ),
        migrations.CreateModel(
            name='QuizQuestion',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=50)),
                ('slug', models.SlugField(max_length=255, unique=True)),
                ('summary', models.TextField()),
                ('createdat', models.DateField()),
                ('quiz_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.quiz')),
            ],
        ),
        migrations.CreateModel(
            name='Take',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('score', models.IntegerField()),
                ('userd_id', models.CharField(max_length=10)),
                ('createdat', models.DateField()),
                ('quiz_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.quiz')),
            ],
        ),
        migrations.CreateModel(
            name='TakeAnswer',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('createdat', models.DateField()),
                ('answer_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.answer')),
                ('question_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.quizquestion')),
                ('take_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.take')),
            ],
        ),
        migrations.DeleteModel(
            name='Company',
        ),
        migrations.AddField(
            model_name='answer',
            name='question_id',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.quizquestion'),
        ),
        migrations.AddField(
            model_name='answer',
            name='quiz_id',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.quiz'),
        ),
        migrations.AddField(
            model_name='answer',
            name='take_id',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='api.take'),
        ),
    ]
