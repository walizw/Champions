from django.urls import path

from . import views

urlpatterns = [
    path ("users/", views.UsersAPIView.as_view ()),
    path ("users/create/", views.RegisterAPIView.as_view ()),
    path ("user/<int:pk>/", views.UserAPIView.as_view ()),
]
