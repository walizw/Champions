from rest_framework import generics, permissions, response

from django.contrib.auth.models import User

from ..serializers import UserSerializer, RegisterSerializer

class UsersAPIView (generics.ListAPIView):
    queryset = User.objects.all ()
    serializer_class = UserSerializer

class UserAPIView (generics.RetrieveAPIView):
    queryset = User.objects.all ()
    serializer_class = UserSerializer

class LoggedUserView (generics.GenericAPIView):
    permission_classes = [permissions.IsAuthenticated]
    serializer_class = UserSerializer
    queryset = User.objects.all ()
    
    def get (self, request, *args, **kwargs):
        instance = User.objects.filter (pk=self.request.user.id).get ()
        serializer = self.get_serializer (instance)
        return response.Response (serializer.data)
    
class RegisterAPIView (generics.CreateAPIView):
    queryset = User.objects.all ()
    serializer_class = RegisterSerializer
