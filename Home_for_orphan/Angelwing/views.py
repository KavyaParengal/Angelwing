from django.shortcuts import render
from urllib.request import Request
from django.shortcuts import render,reverse,redirect
from django.contrib import messages
from django.contrib.auth import authenticate
from django.contrib.auth import login as auth_login
from django.contrib.auth.models import User
from . import models
from .models import adoption_notify, orphanage,schemes,rules,blog,events,orphan,notification
from Outsiders.models import adoption, adoptionform, cloth_donation, feedback, food_donation, money_donation, outsiders

# Create your views here.

def login_page(request):
    return render(request,'mainadmin/login.html')

def forgot_password(request):
    return render(request,'mainadmin/forgot.html')

def admin_dashboard(request):
    return render(request,'mainadmin/admin_index.html')


def admin_add_schemes(request):
    return render(request,'mainadmin/add_schemes.html')

def admin_edit_schemes(request):
    return render(request,'mainadmin/edit_scheme.html')


def admin_view_adoption(request):
    return render(request,'mainadmin/view_adoption.html')

def admin_view_blogs(request):
    return render(request,'mainadmin/view_blog.html')

def admin_view_clothdonation(request):
    return render(request,'mainadmin/view_clothdonation.html')

def admin_view_events(request):
    return render(request,'mainadmin/view_events.html')

def admin_view_feedback(request):
    return render(request,'mainadmin/view_feedback.html')

def admin_view_foodDonation(request):
    return render(request,'mainadmin/view_foodDonation.html')

def admin_view_orphans(request):
    return render(request,'mainadmin/view_members.html')

def admin_view_moneydonation(request):
    return render(request,'mainadmin/view_moneydonation.html')

def admin_view_orphanages(request):
    return render(request,'mainadmin/view_orphanage.html')

def admin_view_approvedorphanages(request):
    return render(request,'mainadmin/view_approvedorphanages.html')

def admin_view_scheme(request):
    return render(request,'mainadmin/view_scheme.html')

def admin_view_users(request):
    return render(request,'mainadmin/view_user.html')

def admin_view_approvedAdoption(request):
    return render(request,'mainadmin/view_approvedAdoption.html')





def orphanage_dashboard(request):
    if request.user:
        user=request.user
    return render(request,'orphanage/orphanage_index.html',{'user':user})


def orphanage_add_blogs(request):
    return render(request,'orphanage/add_blogs.html')

def orphanage_add_events(request):
    return render(request,'orphanage/add_events.html')

def orphanage_add_notification(request):
    return render(request,'orphanage/add_notification.html')

def orphanage_add_orphans(request):
    return render(request,'orphanage/add_orphans.html')

def orphanage_add_rules(request):
    return render(request,'orphanage/add_rules.html')

def orphanage_edit_blogs(request):
    return render(request,'orphanage/edit_blog.html')

def orphanage_edit_events(request):
    return render(request,'orphanage/edit_events.html')

def orphanage_edit_notification(request):
    return render(request,'orphanage/edit_notification.html')

def orphanage_edit_orphans(request):
    return render(request,'orphanage/edit_orphans.html')

def orphanage_edit_rules(request):
    return render(request,'orphanage/edit_rules.html')

def orphanage_registration(request):
    return render(request,'orphanage/register.html')

def orphanage_view_adoption(request):
    return render(request,'orphanage/view_adoption.html')

def orphanage_view_blogs(request):
    return render(request,'orphanage/view_blogs.html')

def orphanage_view_clothdonation(request):
    return render(request,'orphanage/view_clothdonation.html')

def orphanage_view_events(request):
    return render(request,'orphanage/view_events.html')

def orphanage_view_feedback(request):
    return render(request,'orphanage/view_feedback.html')

def orphanage_view_foodDonation(request):
    return render(request,'orphanage/view_foodDonation.html')

def orphanage_view_moneydonation(request):
    return render(request,'orphanage/view_moneydonation.html')

def orphanage_view_notification(request):
    return render(request,'orphanage/view_notification.html')

def orphanage_view_orphans(request):
    return render(request,'orphanage/view_orphans.html')

def orphanage_view_rules(request):
    return render(request,'orphanage/view_rules.html')

def orphanage_view_schemes(request):
    return render(request,'orphanage/view_schemes.html')


########## orphanage_register ###########


def orphanage_register(request):
    if request.method=='POST':
        orphanage_name=request.POST.get('orphanage_name')
        orphanage_image=request.FILES['orphanage_image']
        orphanage_address=request.POST.get('orphanage_address')
        orphanage_contact=request.POST.get('orphanage_contact')
        orphanage_description=request.POST.get('orphanage_description')
        orphanage_email=request.POST.get('orphanage_email')
        password=request.POST.get('password')
        confirm_password=request.POST.get('confirm_password')
        status="0"
        role="orphanage"


        if password==confirm_password:
            if User.objects.filter(username=orphanage_email).exists():
                messages.info(request,"Username Taken")
                return redirect('orphanage_registration')
            
            # elif User.objects.filter(orphanage_email=orphanage_email).exists():
            #     messages.info(request,"Email already exists")
            #     return redirect('orphanage_registration')
            
            else :
                user=User.objects.create_user(username=orphanage_email,password=password)
                user.save()

                userDetails=models.orphanage(user=user,orphanage_name=orphanage_name,orphanage_image=orphanage_image,orphanage_address=orphanage_address,orphanage_contact=orphanage_contact,orphanage_description=orphanage_description,orphanage_email=orphanage_email,status=status,role=role)
                userDetails.save()

                print('user created')

        else:
            messages.info(request,"Password is not matching")
            return redirect('orphanage_registration')
        
        return redirect('loginpage')
    else:
        return render(request,'orphanage/register.html')
    


############## Add Rules ##############

def add_rules(request):
    if request.user:
        user=request.user
        if request.method=='POST':
            rule_title=request.POST.get('rule_title')
            rule_content=request.POST.get('rule_content')
            rule_date=request.POST.get('rule_date')
            rule_status="0"

            userDetails=models.rules(user=user,rule_title=rule_title,rule_content=rule_content,rule_date=rule_date,rule_status=rule_status)
            userDetails.save()

            print('user created')

            return redirect('viewrules')
        else:
            return render(request,'orphanage/add_rules.html')
    else:
        return render(request,'orphanage/add_rules.html')
    

def viewrules(request):
    if request.user:
        user=request.user
        data=rules.objects.all().filter(user=user).values()
    return render(request,'orphanage/view_rules.html',{'data':data})

def deleterules(request,rules_id):
    item=rules.objects.get(id=rules_id)
    item.delete()
    return redirect('viewrules')

def editrules(request,rules_id):
    data=rules.objects.get(id=rules_id)
    return render(request,'orphanage/edit_rules.html',{'data':data})

def orphanageupdaterules(request,rules_id):
    if request.method=='POST':
        data=rules.objects.get(id=rules_id)
        data.rule_title=request.POST["rule_title"]
        data.rule_content=request.POST["rule_content"]
        data.rule_date =request.POST["rule_date"]  
        data.save()
        return redirect('viewrules')

############## Add blog ##############

def add_blog(request):
    if request.user:
        user=request.user
        if request.method=='POST':
            blog_title=request.POST.get('blog_title')
            blog_content=request.POST.get('blog_content')
            blog_date=request.POST.get('blog_date')
            blog_image=request.FILES['blog_image']
            blog_status="0"

            userDetails=models.blog(user=user,blog_title=blog_title,blog_content=blog_content,blog_date=blog_date,blog_image=blog_image,blog_status=blog_status)
            userDetails.save()

            print('user created')

            return redirect('viewblogs')
        else:
            return render(request,'orphanage/add_blogs.html')
    else:
        return render(request,'orphanage/add_blogs.html')
    

def viewblogs(request):
    if request.user:
        user=request.user
        data=blog.objects.all().filter(user=user).values()
    return render(request,'orphanage/view_blogs.html',{'data':data})

def deleteblogs(request,blog_id):
    item=blog.objects.get(id=blog_id)
    item.delete()
    return redirect('viewblogs')

def editblogs(request,blog_id):
    data=blog.objects.get(id=blog_id)
    return render(request,'orphanage/edit_blog.html',{'data':data})

def updateblogs(request,blog_id):
    if request.method=='POST':
        data=blog.objects.get(id=blog_id)
        data.blog_title=request.POST["blog_title"]
        data.blog_content=request.POST["blog_content"]
        data.blog_date=request.POST["blog_date"]
        data.blog_image=request.FILES["blog_image"]
        data.save()
        return redirect('viewblogs')

############### Add events ##################


def add_events(request):
    if request.user:
        user=request.user
        if request.method=='POST':
            event_name=request.POST.get('event_name')
            event_content=request.POST.get('event_content')
            event_place=request.POST.get('event_place')
            event_date=request.POST.get('event_date')
            event_time=request.POST.get('event_time')
            event_status="0"

            userDetails=models.events(user=user,event_name=event_name,event_content=event_content,event_place=event_place,event_date=event_date,event_time=event_time,event_status=event_status)
            userDetails.save()

            print('user created')

            return redirect('viewevents')
        else:
            return render(request,'orphanage/add_events.html')
    else:
        return render(request,'orphanage/add_events.html')
    

def viewevents(request):
    if request.user:
        user=request.user
        data=events.objects.all().filter(user=user).values()
    return render(request,'orphanage/view_events.html',{'data':data})

def delete_events(request,event_id):
    item=events.objects.get(id=event_id)
    item.delete()
    return redirect('viewevents')

def editevents(request,event_id):
    data=events.objects.get(id=event_id)
    return render(request,'orphanage/edit_events.html',{'data':data})

def update_events(request,event_id):
    if request.method=='POST':
        data=events.objects.get(id=event_id)
        data.event_name=request.POST["event_name"]
        data.event_content=request.POST["event_content"]
        data.event_place=request.POST["event_place"]
        data.event_date=request.POST["event_date"]
        data.event_time=request.POST["event_time"]
        data.save()
        return redirect('viewevents')
    

############ add_notification ###############

def add_notification(request):
    if request.user:
        user=request.user
        if request.method=='POST':
            notification_title=request.POST.get('notification_title')
            notification_content=request.POST.get('notification_content')
            notification_date=request.POST.get('notification_date')
            notification_status="0"

            userDetails=models.notification(user=user,notification_title=notification_title,notification_content=notification_content,notification_date=notification_date,notification_status=notification_status)
            userDetails.save()

            print('user created')

            return redirect('viewnotification')
        else:
            return render(request,'orphanage/add_notification.html')
    else:
        return render(request,'orphanage/add_notification.html')
    
def viewnotification(request):
    if request.user:
        user=request.user
        data=notification.objects.all().filter(user=user).values()
    return render(request,'orphanage/view_notification.html',{'data':data})
    
def deletenotification(request,notification_id):
    item=notification.objects.get(id=notification_id)
    item.delete()
    return redirect('viewnotification')

def editnotification(request,notification_id):
    data=notification.objects.get(id=notification_id)
    return render(request,'orphanage/edit_notification.html',{'data':data})

def orphanageupdatenotification(request,notification_id):
    if request.method=='POST':
        data=notification.objects.get(id=notification_id)
        data.notification_title=request.POST["notification_title"]
        data.notification_content=request.POST["notification_content"]
        data.notification_date=request.POST["notification_date"]
        data.save()
        return redirect('viewnotification')
    

################ add orphan ##################

def add_orphan(request):
    if request.user:
        user=request.user
        if request.method=='POST':
            orphan_name=request.POST.get('orphan_name')
            orphan_age=request.POST.get('orphan_age')
            orphan_gender=request.POST.get('orphan_gender')
            orphan_dob=request.POST.get('orphan_dob')
            orphan_address=request.POST.get('orphan_address') 
            orphan_blood=request.POST.get('orphan_blood')
            orphan_hobbies=request.POST.get('orphan_hobbies')
            orphan_image=request.FILES['orphan_image']
            orphan_status="0"

            
            userDetails=models.orphan(user=user,orphan_name=orphan_name,orphan_age=orphan_age,orphan_gender=orphan_gender,orphan_dob=orphan_dob,orphan_address=orphan_address,orphan_blood=orphan_blood,orphan_hobbies=orphan_hobbies,orphan_image=orphan_image,orphan_status=orphan_status)
            userDetails.save()

            print('user created')

            return redirect('viewallorphans')
        else:
            return render(request,'orphanage/add_orphans.html')
    else:
            return render(request,'orphanage/add_orphans.html')
    

def viewallorphans(request):
    if request.user:
        user=request.user
        data=orphan.objects.all().filter(user=user).values()
        for i in data:
            print(i)
    return render(request,'orphanage/view_orphans.html',{'data':data})

def deleteorphans(request,orphan_id):
    item=orphan.objects.get(id=orphan_id)
    item.delete()
    return redirect('viewallorphans')

def editorphans(request,orphan_id):
    data=orphan.objects.get(id=orphan_id)
    return render(request,'orphanage/edit_orphans.html',{'data':data})

def orphanageupdateorphan(request,orphan_id):
    if request.method=='POST':
        data=orphan.objects.get(id=orphan_id)
        data.orphan_name=request.POST["orphan_name"]
        data.orphan_age=request.POST["orphan_age"]
        data.orphan_gender=request.POST["orphan_gender"]
        data.orphan_dob=request.POST["orphan_dob"]
        data.orphan_address=request.POST["orphan_address"]
        data.orphan_blood=request.POST["orphan_blood"]
        data.orphan_hobbies=request.POST["orphan_hobbies"]
        data.save()
        return redirect("viewallorphans")
    

############### view orphanages ####################

def adminviewallorphanage(request):
    data=orphanage.objects.all()
    return render(request,'mainadmin/view_orphanage.html',{'data':data})

def adminapprove(request,orphanage_id):
    reg=orphanage.objects.get(id=orphanage_id)
    reg.status=1
    reg.save()
    return redirect('adminapprovedorphanages')

def adminapprovedorphanages(request):
    data=orphanage.objects.all()
    return render(request,'mainadmin/view_approvedorphanages.html',{'data':data})

def adminorphanagereject(request,orphanage_id):
    item=orphanage.objects.get(id=orphanage_id)
    item.delete()
    messages.info(request,'delete successfully')
    return redirect('adminviewallorphanage')



############## login page #####################

role=''
stat=''
def login_user(request):
    global role
    global stat
    if request.method=='POST':
        username=request.POST.get('email-username')
        password=request.POST.get('password')

        data=User.objects.filter(username=username).values()
        print("userModelData==>",data)
        for i in data:
            u_name=i['username']
            id=i['id']

            d=orphanage.objects.filter(user_id=id).values()
            print("userdata==>",d)
            for i in d:
                stat=i['status']
                print(stat)
                role=i['role']
                print(role)

            user=authenticate(username=username,password=password)
            print(user)

            if user is not None and role=="orphanage" and username==u_name and stat=="1":
                auth_login(request,user)
                return render(request,'orphanage/orphanage_index.html')
            
            elif user is not None and username=="admin" and password=="admn":
                return render(request,'mainadmin/admin_index.html')
            else:pass


        else:
            messages.info(request,'Invalid Credentials')
            return redirect('loginpage')
        
    else:
        return render(request,'mainadmin/login.html')
    
def logout(request):
    return render(request,'mainadmin/login.html')


############## view scheme ##################


def orphanageviewscheme(request):
    data=schemes.objects.all()
    return render(request,'orphanage/view_schemes.html',{'data':data})


################## orphanage view food donation ####################
    

def orphanageviewfdonation(request):
    a = []
    id = ""
    out_id = []
    
    if request.user:
        user = request.user
        oid = orphanage.objects.all().filter(user=user).values()
        
        for i in oid:
            id = i["id"]
        
        data = food_donation.objects.all().filter(orphlist=id).values()
        
        for i in data:
            a.append(i)
            out_id.append(i['user_id'])

        outdata = outsiders.objects.filter(id__in=out_id).values()
      
    return render(request, 'orphanage/view_foodDonation.html', {'data': a, 'outdata': outdata})


################## orphanage view money donation ####################

def orphanageviewcdonation(request):
    a = []
    id = ""
    out_id = []
    
    if request.user:
        user = request.user
        oid = orphanage.objects.all().filter(user=user).values()
        
        for i in oid:
            id = i["id"]
        
        data = cloth_donation.objects.all().filter(orphlist=id).values()
        
        for i in data:
            a.append(i)
            out_id.append(i['user_id'])

        outdata = outsiders.objects.filter(id__in=out_id).values()
      
    return render(request, 'orphanage/view_clothdonation.html', {'data': a, 'outdata': outdata})

################## orphanage view cloth donation ####################

def orphanageviewmdonation(request):
    a = []
    id = ""
    out_id = []
    
    if request.user:
        user = request.user
        oid = orphanage.objects.all().filter(user=user).values()
        
        for i in oid:
            id = i["id"]
        
        data = money_donation.objects.all().filter(orphlist=id).values()
        
        for i in data:
            a.append(i)
            out_id.append(i['user_id'])

        outdata = outsiders.objects.filter(id__in=out_id).values()
      
    return render(request, 'orphanage/view_moneydonation.html', {'data': a, 'outdata': outdata})

################## orphanage view adoption ####################

def orphanageviewadoption(request):
    a = []
    id = ""
    orphan_id = []
    out_id = []
    
    if request.user:
        user = request.user
        oid = orphanage.objects.all().filter(user=user).values()
        
        for i in oid:
            id = i["id"]
        
        data = adoptionform.objects.all().filter(orphlist=id).values()
        
        for i in data:
            a.append(i)
            orphan_id.append(i['member_id'])
            out_id.append(i['outsider_id'])
        
        orphndata = orphan.objects.filter(id__in=orphan_id).values()
        outdata = outsiders.objects.filter(id__in=out_id).values()
      
    return render(request, 'orphanage/view_adoption.html', {'data': a, 'orphndata': orphndata, 'outdata': outdata})



################## orphanage view FEEDBACK  ####################

def orphanageviewfeedback(request):
    data=feedback.objects.all()
    print(data)
    for i in data:
        print(i)
    return render(request,'orphanage/view_feedback.html',{'data':data})



#########################################           Admin          #################################################

######### Add Schemes ###########
    

def add_schemes(request):
    if request.method=='POST':
       scheme_name=request.POST.get('scheme_name') 
       eligibility=request.POST.get('eligibility') 
       last_date=request.POST.get('last_date') 
       applin_link=request.POST.get('applin_link')
       scheme_status="0"

       userDetails=models.schemes(scheme_name=scheme_name,eligibility=eligibility,last_date=last_date,applin_link=applin_link,scheme_status=scheme_status)
       userDetails.save()

       print('user created')

       return redirect('adminviewscheme') 
    else:
        return render(request,'mainadmin/add_schemes.html')
    

def adminviewscheme(request):
    data=schemes.objects.all()
    return render(request,'mainadmin/view_scheme.html',{'data':data})

def admindeletescheme(request,scheme_id):
    item=schemes.objects.get(id=scheme_id)
    item.delete()
    messages.info(request,'delete successfully')
    return redirect('adminviewscheme')

def admineditscheme(request,scheme_id):
    data=schemes.objects.get(id=scheme_id)
    return render(request,'mainadmin/edit_scheme.html',{'data':data})

def adminschemeupdate(request,scheme_id):
    if request.method=='POST':
        data=schemes.objects.get(id=scheme_id)
        data.scheme_name=request.POST["scheme_name"]
        data.eligibility=request.POST["eligibility"]
        data.last_date=request.POST["last_date"]
        data.applin_link=request.POST["applin_link"]
        data.save()
        return redirect("adminviewscheme")


################## admin_add_adoption_notify ##################



def add_adoption_notify(request):
    if request.method=='POST':
       adoptionforms=request.POST.get('adoption') 
       print(adoptionforms)
       ad_notify_title=request.POST.get('ad_notify_title') 
       ad_notify_content=request.POST.get('ad_notify_content') 
       ad_notiy_date=request.POST.get('ad_notiy_date')
       ad_notify_status="0"

       data=adoptionform.objects.get(id=adoptionforms)

       notifyDetails=models.adoption_notify(adoptionforms=data,ad_notify_title=ad_notify_title,ad_notify_content=ad_notify_content,ad_notiy_date=ad_notiy_date,ad_notify_status=ad_notify_status)
       notifyDetails.save()

       print('Adoption notification added')

       return redirect('adminviewadoptionnotification')
    else:
        return render(request,'mainadmin/adoption_notify.html')



def adminviewadoptionnotification(request):
    data=adoption_notify.objects.all()
    return render(request,'mainadmin/view_adoption_notify.html',{'data':data})



def admin_add_adoptionnotification(request,id):
    data=adoptionform.objects.get(id=id)
    print(data)
    return render(request,'mainadmin/adoption_notify.html',{'data':data})





############# admin view events ###########

def adminviewblog(request):
    data=blog.objects.all()

    for orphan_obj in data:
        orph_id = orphan_obj.user
        orphanage_obj = orphanage.objects.filter(user=orph_id).first()
        if orphanage_obj:
            orphan_obj.orphanage_name = orphanage_obj.orphanage_name

    context = {
        'data': data,
    }

    return render(request,'mainadmin/view_blog.html',context)




############# admin view orphans ###########


def adminvieworphans(request):
    data = orphan.objects.all()

    for orphan_obj in data:
        orph_id = orphan_obj.user
        orphanage_obj = orphanage.objects.filter(user=orph_id).first()
        if orphanage_obj:
            orphan_obj.orphanage_name = orphanage_obj.orphanage_name

    context = {
        'data': data,
    }

    return render(request, 'mainadmin/view_members.html', context)


############# admin view events ###########

def adminviewevent(request):
    data=events.objects.all()
    print(data)

    for orphan_obj in data:
        orph_id = orphan_obj.user
        orphanage_obj = orphanage.objects.filter(user=orph_id).first()
        if orphanage_obj:
            orphan_obj.orphanage_name = orphanage_obj.orphanage_name

    context = {
        'data': data,
    }
    return render(request,'mainadmin/view_events.html',context)


################## admin view users ####################

def adminviewusers(request):
    data=outsiders.objects.all()
    print(data)
    for i in data:
        print(i)
    return render(request,'mainadmin/view_user.html',{'data':data})

################## admin view adoption ####################

def adminviewadoption(request):
    data=adoptionform.objects.all()
    return render(request,'mainadmin/view_adoption.html',{'data':data})

def adminapproveAdoption(request,adoption_id):
    reg=adoptionform.objects.get(id=adoption_id)
    reg.adoption_status=1
    reg.save()

    orphan = reg.member
    orphan.orphan_status = 1
    orphan.save()

    return redirect('viewAdminapprovedAdoption')

def viewAdminapprovedAdoption(request):
    data=adoptionform.objects.all()
    return render(request,'mainadmin/view_approvedAdoption.html',{'data':data})

def adminrejectAdoption(request,adoption_id):
    item=adoptionform.objects.get(id=adoption_id)
    item.delete()
    messages.info(request,'delete successfully')
    return redirect('adminviewadoption')







################## admin view FEEDBACK  ####################

def adminviewfeedback(request):
    data=feedback.objects.all()
    print(data)
    for i in data:
        print(i)
    return render(request,'mainadmin/view_feedback.html',{'data':data})

################## admin view food donation ####################

def adminviewfdonation(request):
    data=food_donation.objects.all()
    print(data)
    for i in data:
        print(i)
    return render(request,'mainadmin/view_foodDonation.html',{'data':data})

################## admin view money donation ####################

def adminviewmdonation(request):
    data=money_donation.objects.all()
    print(data)
    for i in data:
        print(i)
    return render(request,'mainadmin/view_moneydonation.html',{'data':data})

################## admin view cloth donation ####################

def adminviewcdonation(request):
    data=cloth_donation.objects.all()
    print(data)
    for i in data:
        print(i)
    return render(request,'mainadmin/view_clothdonation.html',{'data':data})