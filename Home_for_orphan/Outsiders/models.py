from django.db import models

# Create your models here.

class Log(models.Model):
    emailController=models.EmailField(max_length=100,unique=True)
    pwdController=models.CharField(max_length=80,unique=True)
    role=models.CharField(max_length=10)
    def __str__(self):
        return self.emailController
    
class outsiders(models.Model):
    unameController=models.CharField(max_length=100,unique=True)
    addressController=models.CharField(max_length=100,unique=True)
    contactController=models.CharField(max_length=100)
    emailController=models.EmailField(max_length=100,unique=True)
    pwdController=models.CharField(max_length=80,unique=True)
    cpwdController=models.CharField(max_length=80,unique=True)
    log_id=models.OneToOneField(Log,on_delete=models.CASCADE)
    role=models.CharField(max_length=10)
    userstatus=models.CharField(max_length=10)
    userimage=models.ImageField(upload_to='images',max_length=500,default='/meadia/images/user1.png')
    def __str__(self):
        return self.unameController

class food_donation(models.Model):
    user=models.ForeignKey(outsiders,on_delete=models.CASCADE)
    orphlist=models.ForeignKey('Angelwing.orphanage',on_delete=models.CASCADE)
    fd_type=models.CharField(max_length=100)
    fd_dateInput=models.DateField()
    quantityController=models.CharField(max_length=100)
    fd_status=models.CharField(max_length=50)
    def __str__(self):
        return self.fd_type

class cloth_donation(models.Model):
    user=models.ForeignKey(outsiders,on_delete=models.CASCADE)
    orphlist=models.ForeignKey('Angelwing.orphanage',on_delete=models.CASCADE)
    gender=models.CharField(max_length=50)
    sizeController=models.CharField(max_length=50)
    quantityController=models.CharField(max_length=50)
    cloth_dateInput=models.DateField()
    cd_status=models.CharField(max_length=50)
    def __str__(self):
        return self.gender
    
class money_donation(models.Model):
    user=models.ForeignKey(outsiders,on_delete=models.CASCADE)
    orphlist=models.ForeignKey('Angelwing.orphanage',on_delete=models.CASCADE)
    amountController=models.CharField(max_length=100)
    money_dateInput=models.DateField()
    pmtmethod=models.CharField(max_length=50)
    md_status=models.CharField(max_length=40)
    def __str__(self):
        return self.amountController
    
class feedback(models.Model):
    user=models.ForeignKey(outsiders,on_delete=models.CASCADE)
    content=models.CharField(max_length=100)
    feedback_status=models.CharField(max_length=50)

class adoption(models.Model):
    orphlist=models.ForeignKey('Angelwing.orphanage',on_delete=models.CASCADE)
    outsider=models.ForeignKey(outsiders,on_delete=models.CASCADE)
    member=models.ForeignKey('Angelwing.orphan',on_delete=models.CASCADE)
    date=models.DateField()
    adp_status=models.CharField(max_length=50,default='0')


class forgetPassword(models.Model):
    emailController=models.EmailField(max_length=200)


class adoptionform(models.Model):
    orphlist=models.ForeignKey('Angelwing.orphanage',on_delete=models.CASCADE)
    outsider=models.ForeignKey('Outsiders.outsiders',on_delete=models.CASCADE)
    member=models.ForeignKey('Angelwing.orphan',on_delete=models.CASCADE)
    date=models.DateField()
    fullName=models.CharField(max_length=200,unique=True)
    gender=models.CharField(max_length=100)
    dob=models.DateField()
    address=models.CharField(max_length=500,unique=True)
    phoneNumber=models.CharField(max_length=100)
    idNumber=models.CharField(max_length=300)
    healthInsurance=models.CharField(max_length=300)
    personal_status=models.CharField(max_length=100)
    companyName=models.CharField(max_length=300)
    companyAddress=models.CharField(max_length=500)
    reason=models.CharField(max_length=1000,)
    signature=models.ImageField(upload_to='images',height_field=None, width_field=None, max_length=500,)
    adoption_status=models.CharField(max_length=50)

    def __str__(self):
        return self.fullName

