from django.shortcuts import render
from Angelwing.models import adoption_notify, blog, events, notification, orphan, orphanage, rules
from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import GenericAPIView
from .models import Log, adoption, adoptionform,outsiders
from django.conf import settings
from Outsiders.serializers import AdoptionNotificationSerializer, AdoptionformSerializer, BlogSerializer, ClothDonationSerializer, EventSerializer, LoginUserSerializer, MoneyDonationSerializer, NotificationSerializer, OrphanSerializer, OrphanageSerializer, PasswordResetRequestSerializer, RuleSerializer, SingleUserviewProfileSerializer,UserRegisterSerializer,AdoptionSerializer,FeedbackSerializer,FoodDonationSerializer, UserSerializer

# Create your views here.

class UserRegisterSerializersAPIView(GenericAPIView):
    serializer_class = UserRegisterSerializer
    serializer_class_login = LoginUserSerializer

    def post(self, request):
        
        login_id=''
        unameController=request.data.get('unameController')
        addressController=request.data.get('addressController')
        contactController=request.data.get('contactController')
        emailController=request.data.get('emailController')
        pwdController=request.data.get('pwdController')
        cpwdController=request.data.get('cpwdController')
        role='user'
        userstatus='0'

        if(Log.objects.filter(emailController=emailController)):
            return Response({'message': 'Duplicate User Found'}, status = status.HTTP_400_BAD_REQUEST)
        else:
            serializer_login = self.serializer_class_login(data = {'emailController':emailController,'pwdController':pwdController,'role':role})

        if serializer_login.is_valid():
            log = serializer_login.save()
            login_id = log.id
            print(login_id)
        serializer = self.serializer_class(data= {'log_id':login_id,'unameController':unameController,'addressController':addressController,'contactController':contactController,'emailController':emailController,'pwdController':pwdController,'cpwdController':cpwdController,'role':role,'userstatus':userstatus})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'User registered successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed Your Registration','success':False},status = status.HTTP_400_BAD_REQUEST)
    
class LoginUserAPIView(GenericAPIView):
    serializer_class = LoginUserSerializer
    def post(self,request):
        emailController=request.data.get('emailController')
        pwdController=request.data.get('pwdController')
        logreg=Log.objects.filter(emailController=emailController,pwdController=pwdController)
        if(logreg.count()>0):
            read_serializer=LoginUserSerializer(logreg, many=True)
            for i in read_serializer.data:
                id=i['id']
                print(id)
                role=i['role']
                regdata=outsiders.objects.all().filter(log_id=id).values()
                print(regdata)
                for i in regdata:
                    u_id=i['id']
                    l_status=i['userstatus']
                    f_name=i['unameController']
                    print(u_id)

            return Response({'data':{'login_id':id,'emailController':emailController,'pwdController':pwdController,'role':role,'user_id':u_id,'l_status':l_status,'name':f_name},'success':True,'message':'Logged in successfully'},status = status.HTTP_201_CREATED)
        else:
            return Response({'data':'username or password is invalid','message':'Username or Password is Invalid','success':False,},status = status.HTTP_400_BAD_REQUEST)

class FoodDonationSerializerAPIView(GenericAPIView):
    serializer_class=FoodDonationSerializer
    def post(self,request):
        user=request.data.get('user')
        orphlist=request.data.get('orphlist')
        fd_type=request.data.get('fd_type')
        fd_dateInput=request.data.get('fd_dateInput')
        quantityController=request.data.get('quantityController')
        fd_status="0"

        serializer = self.serializer_class(data={'user':user,'orphlist':orphlist,'fd_type':fd_type,'fd_dateInput':fd_dateInput,'quantityController':quantityController,'fd_status':fd_status})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'Your food donation Successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)
    
class ClothDonationSerializerAPIView(GenericAPIView):
    serializer_class= ClothDonationSerializer
    def post(self,request):
        user=request.data.get('user')
        orphlist=request.data.get('orphlist')
        gender=request.data.get('gender')
        sizeController=request.data.get('sizeController')
        quantityController=request.data.get('quantityController')
        cloth_dateInput=request.data.get('cloth_dateInput')
        cd_status="0"

        serializer = self.serializer_class(data={'user':user,'orphlist':orphlist,'gender':gender,'sizeController':sizeController,'quantityController':quantityController,'cloth_dateInput':cloth_dateInput,'cd_status':cd_status})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'Your cloth donation Successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)

class MoneyDonationSerializerAPIView(GenericAPIView):
    serializer_class=MoneyDonationSerializer
    def post(self,request):
        user=request.data.get('user')
        orphlist=request.data.get('orphlist')
        amountController=request.data.get('amountController')
        money_dateInput=request.data.get('money_dateInput')
        pmtmethod=request.data.get('pmtmethod')
        md_status="0"
        serializer=self.serializer_class(data={'user':user,'orphlist':orphlist,'amountController':amountController,'money_dateInput':money_dateInput,'pmtmethod':pmtmethod,'md_status':md_status})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'Your money donation Successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)
    
class FeedbackSerializerAPIView(GenericAPIView):
    serializer_class=FeedbackSerializer
    def post(self,request):
        user=request.data.get('user')
        content=request.data.get('content')
        feedback_status="0"
        serializer=self.serializer_class(data={'user':user,'content':content,'feedback_status':feedback_status})
        print(serializer)
        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'Feedback send successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)
    
    
class OrphanageSerializerAPIView(GenericAPIView):
    serializer_class = OrphanageSerializer
    def get(self,request):
        queryset=orphanage.objects.all() 
        if(queryset.count()>0):
            serializer=OrphanageSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'Orphanage all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        
class SingleOrphanageviewSerializerAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=orphanage.objects.get(pk=id)
        serializer=OrphanageSerializer(queryset)
        return Response({'data':serializer.data,'message':'Single Orphanage data','success':True},status=status.HTTP_200_OK)
        

class SingleUserviewProfileSerializerAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=outsiders.objects.get(pk=id)
        serializer=SingleUserviewProfileSerializer(queryset)
        return Response({'data':serializer.data,'message':'Single user data','success':True},status=status.HTTP_200_OK)
    
class SingleUserUpdateProfileSerializerAPIView(GenericAPIView):
    serializer_class = SingleUserviewProfileSerializer
    def put(self,request,id):
        queryset=outsiders.objects.get(pk=id)
        print(queryset)
        serializer=SingleUserviewProfileSerializer(instance=queryset,data=request.data,partial=True)
        print(serializer)
        if serializer.is_valid():
            serializer.save()
            return Response({'data':serializer.data,'message':'Update data Successfully','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'Something went wrong','success':False},status=status.HTTP_400_BAD_REQUEST)
        


class OrphanSerializerAPIView(GenericAPIView):
    serializer_class = OrphanSerializer
    def get(self,request):
        queryset=orphan.objects.all() 
        if(queryset.count()>0):
            serializer=OrphanSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'Orphanage all data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        
class ViewOrphanInSingleorphAPIView(GenericAPIView):
    def get(self,request,id):
        data=orphanage.objects.all().filter(id=id).values()
        for i in data:
            u_id=i['user_id']
        queryset=orphan.objects.all().filter(user=u_id).values()
        serializer_data=list(queryset)
        print(serializer_data)
        for obj in serializer_data:
            obj['orphan_image']=settings.MEDIA_URL + str(obj['orphan_image'])
        return Response({'data':serializer_data,'message':'Single Orphanages orphan data','success':True},status=status.HTTP_200_OK)

        
class SingleOrphanviewSerializerAPIView(GenericAPIView):
    def get(self,request,id):
        queryset=orphan.objects.get(pk=id)
        serializer=OrphanSerializer(queryset)
        return Response({'data':serializer.data,'message':'Single Orphanage data','success':True},status=status.HTTP_200_OK)
    
class NotificationSerializerAPIView(GenericAPIView):
    serializer_class = NotificationSerializer
    def get(self,request):
        queryset=notification.objects.all() 
        if(queryset.count()>0):
            serializer=NotificationSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'all notification data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        

class EventSerializerAPIView(GenericAPIView):
    serializer_class = EventSerializer
    def get(self,request):
        queryset=events.objects.all() 
        if(queryset.count()>0):
            serializer=EventSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'all event data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        
class BlogSerializerAPIView(GenericAPIView):
    serializer_class = BlogSerializer
    def get(self,request):
        queryset=blog.objects.all() 
        if(queryset.count()>0):
            serializer=BlogSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'all blog data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        



class SingleBlogviewSerializerAPIView(GenericAPIView):
    def get(self, request, id):
        try:
            blog_obj = blog.objects.get(pk=id)
            orphanage_obj = orphanage.objects.get(user=blog_obj.user)

            serializer = BlogSerializer(blog_obj)
            response_data = {
                'data': {
                    'user_id': orphanage_obj.user.id,
                    'blog_image': serializer.data.get('blog_image'),
                    'blog_title': serializer.data.get('blog_title'),
                    'blog_content': serializer.data.get('blog_content'),
                    'orphanage_name': orphanage_obj.orphanage_name,
                },
                'message': 'Single blog data',
                'success': True
            }
            return Response(response_data, status=status.HTTP_200_OK)
        except blog.DoesNotExist:
            return Response({'message': 'Blog does not exist.', 'success': False}, status=status.HTTP_404_NOT_FOUND)
        except orphanage.DoesNotExist:
            return Response({'message': 'Orphanage does not exist.', 'success': False}, status=status.HTTP_404_NOT_FOUND)



class RuleSerializerAPIView(GenericAPIView):
    serializer_class = RuleSerializer
    def get(self,request):
        queryset=rules.objects.all() 
        if(queryset.count()>0):
            serializer=RuleSerializer(queryset,many=True)
            return Response({'data':serializer.data,'message':'all rules data','success':True},status=status.HTTP_200_OK)
        else:
            return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        


class AdoptionSerializerAPIView(GenericAPIView):
    serializer_class = AdoptionSerializer

    def post(self, request):
        orphlist = request.data.get('orphlist')
        outsider = request.data.get('outsider')
        member = request.data.get('member')
        date = request.data.get('date')
        adp_status = "1"

        # Check if the child is already adopted
        if adoption.objects.filter(member=member,adp_status="1").exists():
            return Response({'message': 'This child is already adopted', 'success': False}, status=status.HTTP_400_BAD_REQUEST)

        else:    
            serializer = self.serializer_class(data={'orphlist': orphlist, 'outsider': outsider, 'member': member, 'date': date, 'adp_status': adp_status})

            if serializer.is_valid():
                serializer.save()
                return Response({'data': serializer.data, 'message': 'Adoption Successful, Further Enquiries please visit Orphanage', 'success': True}, status=status.HTTP_201_CREATED)
            
            return Response({'data': serializer.errors, 'message': 'Adoption Failed', 'success': False}, status=status.HTTP_400_BAD_REQUEST)


class AdoptionformSerializerAPIView(GenericAPIView):
    serializer_class = AdoptionformSerializer

    def post(self, request):
        orphlist = request.data.get('orphlist')
        outsider = request.data.get('outsider')
        member = request.data.get('member')
        date = request.data.get('date')
        fullName= request.data.get('fullName')
        gender=request.data.get('gender')
        dob= request.data.get('dob')
        address= request.data.get('address')
        phoneNumber= request.data.get('phoneNumber')
        idNumber= request.data.get('idNumber')
        healthInsurance= request.data.get('healthInsurance')
        personal_status= request.data.get('personal_status')
        companyName= request.data.get('companyName')
        companyAddress= request.data.get('companyAddress')
        reason= request.data.get('reason')
        signature= request.data.get('signature')
        adoption_status = "0"
        serializer=self.serializer_class(data={'orphlist':orphlist, 'outsider':outsider, 'member':member, 'date':date, 'fullName':fullName,'gender':gender, 'dob':dob, 'address':address, 'phoneNumber':phoneNumber, 'idNumber':idNumber, 'healthInsurance':healthInsurance, 'personal_status':personal_status, 'companyName':companyName, 'companyAddress':companyAddress, 'reason':reason, 'signature':signature, 'adoption_status':adoption_status})
        print(serializer)

        if serializer.is_valid():
            print('hai')
            serializer.save()
            return Response({'data':serializer.data,'message':'Your Form send Successfully','success':True},status = status.HTTP_201_CREATED)
        return Response({'data':serializer.errors,'message':'Failed','success':False},status = status.HTTP_400_BAD_REQUEST)
    

# class AdoptionNotificationSerializerAPIView(GenericAPIView):
#     def get(self,request,id):
#         queryset=adoption_notify.objects.all()
#         for i in queryset:
#             adoption_id=i['id']
#         outsider=adoptionform.objects.all().filter(id=adoption_id).values()
#         for i in outsider:
#             out_id=i['outsider']
#         out_name=outsiders.objects.all().filter(id=out_id).values()
#         for i in out_name:
#             outsider_name=i['unameController']
#         print(outsider_name)
#         if(queryset.count()>0,outsider.count()>0,out_name.count()>0):
#             serializer=AdoptionNotificationSerializer(queryset,outsider,out_name,many=True)
#             return Response({'data':serializer.data,'message':'All Adoption notification','success':True},status=status.HTTP_200_OK)
#         else:
#             return Response({'data':'No data available','success':False},status=status.HTTP_400_BAD_REQUEST)
        
        
class AdoptionNotificationSerializerAPIView(GenericAPIView):
    def get(self, request, id):
        adoption_id=""
        try:
            out_name=outsiders.objects.all().filter(id=id).values()
            for out_names in out_name:
                outsider_id=out_names['id']
                outsider_name=out_names['unameController']

            adoptionform_id=adoptionform.objects.all().filter(outsider=outsider_id).values()
            for adoptionforms in adoptionform_id:
                adoption_id=adoptionforms['id']

            queryset=adoption_notify.objects.all().filter(adoptionforms=adoption_id).values()
            print(queryset)

            return Response({'data':queryset,'message':'Adoption Notification','success':True},status=status.HTTP_200_OK)
        except adoption_notify.DoesNotExist:
            return Response({'message': 'Notification does not exist.', 'success': False}, status=status.HTTP_404_NOT_FOUND)
        except adoptionform.DoesNotExist:
            return Response({'message': 'Adoption does not exist.', 'success': False}, status=status.HTTP_404_NOT_FOUND)    


from django.core.mail import send_mail
from django.utils.crypto import get_random_string


class ForgotPasswordAPIView(GenericAPIView):
    serializer_class = UserSerializer


    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        emailController = serializer.validated_data['emailController']

        try:
            user = Log.objects.get(emailController=emailController)

            temporary_password = user.pwdController
            
            user.save()

            subject = 'Password Reset'
            message = f'Your password is: {temporary_password}'
            from_email = 'angelwing839@gmail.com'
            send_mail(subject, message, from_email, [emailController])

            return Response({'message': 'Password reset email sent successfully','success':True},status=status.HTTP_200_OK)
        except Log.DoesNotExist:
            return Response({'message': 'Invalid email'}, status=400)




        

