from django.db import models

class Users(models.Model):
    username = models.CharField(max_length=100, unique=True)
    date_joined = models.DateTimeField(auto_now_add=True)