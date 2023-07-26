from django.contrib import admin
from Outsiders.models import Log, adoptionform, forgetPassword,outsiders,adoption,feedback,food_donation,cloth_donation,money_donation

# Register your models here.

admin.site.register(Log)

admin.site.register(outsiders)

admin.site.register(adoption)

admin.site.register(feedback)

admin.site.register(food_donation)

admin.site.register(cloth_donation)

admin.site.register(money_donation)

admin.site.register(forgetPassword)

admin.site.register(adoptionform)