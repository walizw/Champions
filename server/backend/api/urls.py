from django.urls import path

from . import views

urlpatterns = [
    path ("users/", views.UsersAPIView.as_view ()),
    path ("users/create/", views.RegisterAPIView.as_view ()),
    path ("user/", views.LoggedUserView.as_view ()),
    path ("user/<int:pk>/", views.UserAPIView.as_view ()),
    path ("user/<int:pk>/data/", views.DataUpdateAPIView.as_view ())
]
