from django.urls import path
from Outsiders import views

from django.contrib.auth import views as auth_views

urlpatterns = [
    path('login_users',views.LoginUserAPIView.as_view(),name='login_users'),
    path('user_register',views.UserRegisterSerializersAPIView.as_view(),name='user_register'),
    path('food_donation',views.FoodDonationSerializerAPIView.as_view(),name='food_donation'),
    path('cloth_donation',views.ClothDonationSerializerAPIView.as_view(),name='cloth_donation'),
    path('money_donation',views.MoneyDonationSerializerAPIView.as_view(),name='money_donation'),
    path('feedback',views.FeedbackSerializerAPIView.as_view(),name='feedback'),
    path('adoption',views.AdoptionSerializerAPIView.as_view(),name='adoption'),
    path("vieworphanages",views.OrphanageSerializerAPIView.as_view(),name="vieworphanages"),
    path("singleuserprofile/<int:id>",views.SingleUserviewProfileSerializerAPIView.as_view(),name="singleuserprofile"),
    path("<int:id>/singleuserprofileUpdate",views.SingleUserUpdateProfileSerializerAPIView.as_view(),name="singleuserprofileUpdate"),
    path("singleorphanage/<int:id>",views.SingleOrphanageviewSerializerAPIView.as_view(),name="singleorphanage"),
    path("orphanlist",views.OrphanSerializerAPIView.as_view(),name="orphanlist"),
    path("singleorphan/<int:id>",views.SingleOrphanviewSerializerAPIView.as_view(),name="singleorphan"),
    path("notificationlist",views.NotificationSerializerAPIView.as_view(),name="notificationlist"),
    path("eventlist",views.EventSerializerAPIView.as_view(),name="eventlist"),
    path("bloglist",views.BlogSerializerAPIView.as_view(),name="bloglist"),
    path("singleblog/<int:id>",views.SingleBlogviewSerializerAPIView.as_view(),name="singleblog"),
    path("rulesview",views.RuleSerializerAPIView.as_view(),name="rulesview"),
    path("singleorphanagemembers/<int:id>",views.ViewOrphanInSingleorphAPIView.as_view(),name="singleorphanagemembers"),
    path('adoptionform',views.AdoptionformSerializerAPIView.as_view(),name='adoptionform'),

    path("view_AdoptionNotify/<int:id>",views.AdoptionNotificationSerializerAPIView.as_view(),name="view_AdoptionNotify"),

    # path("reset_password",auth_views.PasswordResetView.as_view(),name='reset_password'),

    # path("reset_password_sent",auth_views.PasswordResetDoneView.as_view(),name='password_reset_done'),

    # path("reset_password/<uidb1>/<token>",auth_views.PasswordResetConfirmView.as_view(),name='password_reset_confirm'),

    # path("reset_password_complete",auth_views.PasswordResetCompleteView.as_view(),name='password_reset_complete'),

    # path("get-old-password",views.OldPasswordAPIView.as_view(),name='get-old-password'),

    path('password-reset-request',views.ForgotPasswordAPIView.as_view(), name='password_reset_request'),
    
]