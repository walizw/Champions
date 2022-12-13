from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class PlayerData (models.Model):
    user = models.OneToOneField (User, on_delete=models.CASCADE)

    level = models.DecimalField (max_digits=10, decimal_places=0, default=0)
    exp = models.DecimalField (max_digits=15, decimal_places=0, default=0)

    col_a = models.CharField (max_length=8, default="ffffff00")
    col_b = models.CharField (max_length=8, default="ff00ffff")

    cube = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    ship = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    ball = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    ufo = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    wave = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    robot = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    spider = models.DecimalField (max_digits=5, decimal_places=0, default=0)

@receiver (post_save, sender=User)
def create_player_data (sender, instance, created, **kwargs):
    if created:
        PlayerData.objects.create (user=instance)
    instance.playerdata.save ()
