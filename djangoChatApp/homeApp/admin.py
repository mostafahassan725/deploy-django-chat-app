from django.contrib import admin
from .models import User, ChatRoom, Message

admin.site.register(User, ChatRoom, Message)