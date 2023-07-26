from Angelwing.models import adoption_notify, blog, events, notification, orphan, orphanage, rules
from rest_framework import serializers
from .models import Log, adoptionform, forgetPassword,outsiders,adoption,feedback,food_donation,cloth_donation,money_donation

class LoginUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = Log
        fields = '__all__'

class UserRegisterSerializer(serializers.ModelSerializer):
    class Meta:
        model = outsiders
        fields = '__all__'
        def create(self,validated_data):
            return outsiders.objects.create(**validated_data)

class FoodDonationSerializer(serializers.ModelSerializer):
    class Meta:
        model = food_donation
        fields = '__all__'
        def create(self,validated_data):
            return food_donation.objects.create(**validated_data)
        
class ClothDonationSerializer(serializers.ModelSerializer):
    class Meta:
        model = cloth_donation
        fields = '__all__'
        def create(self,validated_data):
            return cloth_donation.objects.create(**validated_data)
        
class MoneyDonationSerializer(serializers.ModelSerializer):
    class Meta:
        model = money_donation
        fields = '__all__'
        def create(self,validated_data):
            return money_donation.objects.create(**validated_data)
        
class FeedbackSerializer(serializers.ModelSerializer):
    class Meta:
        model = feedback
        fields = '__all__'
        def create(self,validated_data):
            return feedback.objects.create(**validated_data)
        
class AdoptionSerializer(serializers.ModelSerializer):
    class Meta:
        model = adoption
        fields = '__all__'
        def create(self,validated_data):
            return adoption.objects.create(**validated_data)
        

class OrphanageSerializer(serializers.ModelSerializer):
    class Meta:
        model = orphanage
        fields = '__all__'
        def create(self,validated_data):
            return orphanage.objects.create(**validated_data)
        
class SingleUserviewProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = outsiders
        fields = '__all__'
        def create(self,validated_data):
            return outsiders.objects.create(**validated_data)
        
# class SingleOrphanageviewSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = orphanage
#         fields='__all__'
#         def create(self,validated_data):
#             return orphanage.objects.create(**validated_data)
        
class OrphanSerializer(serializers.ModelSerializer):
    class Meta:
        model = orphan
        fields = '__all__'
        def create(self,validated_data):
            return orphan.objects.create(**validated_data)
        
class NotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = notification
        fields = '__all__'
        def create(self,validated_data):
            return notification.objects.create(**validated_data)
        

class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = events
        fields = '__all__'
        def create(self,validated_data):
            return events.objects.create(**validated_data)
        
class BlogSerializer(serializers.ModelSerializer):
    class Meta:
        model = blog
        fields = '__all__'
        def create(self,validated_data):
            return blog.objects.create(**validated_data)  

class RuleSerializer(serializers.ModelSerializer):
    class Meta:
        model = rules
        fields = '__all__'
        def create(self,validated_data):
            return rules.objects.create(**validated_data)       
        

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = forgetPassword
        fields = '__all__'

class AdoptionformSerializer(serializers.ModelSerializer):
    class Meta:
        model = adoptionform
        fields = '__all__'
        def create(self,validated_data):
            return adoptionform.objects.create(**validated_data)
        

class AdoptionNotificationSerializer(serializers.ModelSerializer):
    class Meta:
        model = adoption_notify
        fields = '__all__'
        def create(self,validated_data):
            return adoption_notify.objects.create(**validated_data)
        

class PasswordResetRequestSerializer(serializers.Serializer):
    email = serializers.EmailField()
        