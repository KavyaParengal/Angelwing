# Generated by Django 4.2 on 2023-06-06 13:35

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("Angelwing", "0002_alter_orphan_user"),
        ("Outsiders", "0007_alter_outsiders_userimage"),
    ]

    operations = [
        migrations.CreateModel(
            name="adoptionform",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                ("date", models.DateField()),
                ("fullName", models.CharField(max_length=200, unique=True)),
                ("dob", models.DateField()),
                ("address", models.CharField(max_length=500, unique=True)),
                ("phoneNumber", models.CharField(max_length=100)),
                ("idNumber", models.CharField(max_length=300)),
                ("healthInsurance", models.CharField(max_length=300)),
                ("companyName", models.CharField(max_length=300)),
                ("companyAddress", models.CharField(max_length=500)),
                ("reason", models.CharField(max_length=1000)),
                ("signature", models.ImageField(max_length=500, upload_to="images")),
                ("adoption_status", models.CharField(max_length=50)),
                (
                    "member",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="Angelwing.orphan",
                    ),
                ),
                (
                    "orphlist",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="Angelwing.orphanage",
                    ),
                ),
                (
                    "outsider",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="Outsiders.outsiders",
                    ),
                ),
            ],
        ),
    ]
