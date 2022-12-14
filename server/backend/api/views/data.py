from rest_framework import generics, permissions, response, exceptions

from ..models import PlayerData
from ..serializers import UserSerializer, DataSerializer

class DataUpdateAPIView (generics.UpdateAPIView):
    queryset = PlayerData.objects.all ()
    serializer_class = DataSerializer
    lookup_url_kwarg = "pk"
    permission_classes = [permissions.IsAuthenticated]

    def perform_update (self, serializer):
        obj = self.get_object ()
        data_user = obj.user.pk
        user_id = self.request.user.id

        if data_user != user_id:
            raise exceptions.PermissionDenied (
                detail="You're trying to update data that is not yours",
                code=401
            )

        serializer.save ()
