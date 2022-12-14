from django.db import models
from django.contrib.auth.models import User
from django.db.models.signals import post_save
from django.dispatch import receiver

class PlayerData (models.Model):
    user = models.OneToOneField (User, on_delete=models.CASCADE)

    level = models.DecimalField (max_digits=10, decimal_places=0, default=0)
    exp = models.DecimalField (max_digits=15, decimal_places=0, default=0)

    col_a = models.CharField (max_length=16, default="1,1,0,1")
    col_b = models.CharField (max_length=16, default="0,1,1,1")

    cube = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    ship = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    ball = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    ufo = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    wave = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    robot = models.DecimalField (max_digits=5, decimal_places=0, default=0)
    spider = models.DecimalField (max_digits=5, decimal_places=0, default=0)

    stars = models.DecimalField (max_digits=6, decimal_places=0, default=0)
    coins = models.DecimalField (max_digits=10, decimal_places=0, default=500)
    gems = models.DecimalField (max_digits=10, decimal_places=0, default=250)
    energy = models.DecimalField (max_digits=6, decimal_places=0, default=60)
    max_energy = models.DecimalField (max_digits=6, decimal_places=0, default=60)
    trophies = models.DecimalField (max_digits=10, decimal_places=0, default=0)

    level_world = models.DecimalField (max_digits=3, decimal_places=0, default=0)

@receiver (post_save, sender=User)
def create_player_data (sender, instance, created, **kwargs):
    if created:
        PlayerData.objects.create (user=instance)
    instance.playerdata.save ()
