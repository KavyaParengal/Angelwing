from django.db import models
from django.contrib.auth.models import User

from Outsiders.models import adoptionform



# Create your models here.
class orphanage(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    orphanage_name=models.CharField(max_length=100)
    orphanage_address=models.CharField(max_length=500)
    orphanage_contact=models.CharField(max_length=50)
    orphanage_description=models.CharField(max_length=500)
    orphanage_email=models.EmailField(max_length=200)
    orphanage_image=models.ImageField(upload_to='images',max_length=500)
    status=models.CharField(max_length=50)
    role=models.CharField(max_length=50)
    def __str__(self):
        return self.orphanage_name

class outsiders(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    user_address=models.CharField(max_length=500)
    user_email=models.EmailField(max_length=200)
    user_status=models.CharField(max_length=50)
    role=models.CharField(max_length=50)


class schemes(models.Model):
    scheme_name= models.CharField(max_length=100)
    eligibility= models.CharField(max_length=500)
    last_date= models.DateField()
    applin_link=models.URLField()
    scheme_status=models.CharField(max_length=10)

class rules(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    rule_title=models.CharField(max_length=150)
    rule_content=models.CharField(max_length=500)
    rule_date=models.DateField()
    rule_status=models.CharField(max_length=50)

class blog(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    blog_title=models.CharField(max_length=150)
    blog_content=models.CharField(max_length=500)
    blog_date=models.DateField()
    blog_image=models.ImageField(upload_to='images', height_field=None, width_field=None, max_length=500,)
    blog_status=models.CharField(max_length=50)

class events(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    event_name=models.CharField(max_length=200)
    event_content=models.CharField(max_length=500)
    event_place=models.CharField(max_length=200)
    event_date=models.DateField()
    event_time=models.CharField(max_length=150)
    event_status=models.CharField(max_length=50)


GENDER_CHOICE=[
    ('female','Female'),
    ('male','Male')
]

BLOOD_CHOICE=[
    ('a+','A+'),
    ('b+','B+'),
    ('ab+','AB+'),
    ('o+','O+'),
    ('a-','A-'),
    ('b-','B-'),
    ('ab-','AB-'),
    ('o-','O-')
]

HOBBIES_CHOICE=[
    ('writing','Writing'),
    ('reading','Reading'),
    ('singing','Singing'),
    ('dancing','Dancing'),
    ('drawing','Drawing'),
]

class orphan(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    orphan_name=models.CharField(max_length=200)
    orphan_age=models.CharField(max_length=150)
    orphan_gender=models.CharField(choices=GENDER_CHOICE,max_length=100)
    orphan_dob=models.DateField()
    orphan_address=models.CharField(max_length=200)
    orphan_blood=models.CharField(choices=BLOOD_CHOICE,max_length=100)
    orphan_hobbies=models.CharField(choices=HOBBIES_CHOICE,max_length=100)
    orphan_image=models.ImageField(upload_to='images',height_field=None, width_field=None, max_length=500,)
    orphan_status=models.CharField(max_length=50)
    def __str__(self):
        return self.orphan_name


class notification(models.Model):
    user=models.ForeignKey(User,on_delete=models.CASCADE)
    notification_title=models.CharField(max_length=150)
    notification_content=models.CharField(max_length=500)
    notification_date=models.DateField()
    notification_status=models.CharField(max_length=50)


class adoption_notify(models.Model):
    adoptionforms=models.ForeignKey(adoptionform,on_delete=models.CASCADE)
    ad_notify_title=models.CharField(max_length=150)
    ad_notify_content=models.CharField(max_length=500)
    ad_notiy_date=models.DateField()
    ad_notify_status=models.CharField(max_length=50)

