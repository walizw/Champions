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

        data = serializer.validated_data
        next_experience = (int (obj.level) + 1) * 100
        if data ["exp"] >= next_experience:
            new_level = obj.level + 1

            # get remaining exp and add one level
            data ["exp"] = next_experience % data ["exp"]
            data ["level"] += 1

            # increase energy, give coins and gems
            data ["max_energy"] += 2
            data ["coins"] += new_level * 10
            data ["gems"] += new_level * 2

        # TODO Validate the data when cloud saving
        # There should be a way to check if data is valid or not, for example,
        # checking that a single save does not give more than 10 stars (as
        # that's the maximum), 25 trophies, 10 gems or 500 coins. Something
        # like that.

        if serializer.is_valid ():
            serializer.save ()
