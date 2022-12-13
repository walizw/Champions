from rest_framework import serializers
from rest_framework.response import Response
from rest_framework import status
from rest_framework.validators import UniqueValidator

from django.contrib.auth.models import User
from django.contrib.auth.password_validation import validate_password

from ..models import PlayerData

class RegisterSerializer (serializers.ModelSerializer):
    email = serializers.EmailField (
        required = True,
        validators = [UniqueValidator (queryset=User.objects.all ())]
    )

    password = serializers.CharField (write_only = True, required = True,
                                      validators = [validate_password])
    password2 = serializers.CharField (write_only = True, required = True)

    class Meta:
        model = User
        fields = ["username", "email", "password", "password2"]

    def validate (self, attrs):
        if attrs ["password"] != attrs ["password2"]:
            raise serializers.ValidationError ({
                "password": "Passwords fields don't match"
            })
        return attrs

    def create (self, validated_data):
        user = User.objects.create (
            username = validated_data ["username"],
            email = validated_data ["email"]
        )

        user.set_password (validated_data ["password"])
        user.save ()

        return user

class UserSerializer (serializers.ModelSerializer):
    data = serializers.SerializerMethodField ()

    def get_data (self, instance):
        player_data = instance.playerdata
        return DataSerializer (player_data).data

    class Meta:
        model = User
        fields = ["id", "username", "is_superuser", "data"]

class DataSerializer (serializers.ModelSerializer):
    class Meta:
        model = PlayerData
        fields = ["level",
                  "exp",
                  "col_a",
                  "col_b",
                  "cube",
                  "ship",
                  "ball",
                  "ufo",
                  "wave",
                  "robot",
                  "spider"]
