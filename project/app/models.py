from django.db import models

class FooBar(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

class Car(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name
