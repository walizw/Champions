from rest_framework import generics

from django.contrib.auth.models import User

from ..serializers import UserSerializer, RegisterSerializer

class UsersAPIView (generics.ListAPIView):
    queryset = User.objects.all ()
    serializer_class = UserSerializer

class UserAPIView (generics.RetrieveAPIView):
    queryset = User.objects.all ()
    serializer_class = UserSerializer

class RegisterAPIView (generics.CreateAPIView):
    queryset = User.objects.all ()
    serializer_class = RegisterSerializer
