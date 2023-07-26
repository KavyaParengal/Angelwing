from django.contrib import admin
from Angelwing.models import adoption_notify, orphanage,schemes,rules,blog,events,notification,orphan

# Register your models here.

admin.site.register(orphanage)

admin.site.register(schemes)

admin.site.register(rules)

admin.site.register(blog)

admin.site.register(events)

admin.site.register(notification)

admin.site.register(orphan)

admin.site.register(adoption_notify)