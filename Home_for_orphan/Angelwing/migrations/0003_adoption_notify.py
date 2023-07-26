# Generated by Django 4.2 on 2023-06-08 14:01

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("Angelwing", "0002_alter_orphan_user"),
    ]

    operations = [
        migrations.CreateModel(
            name="adoption_notify",
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
                ("ad_notify_title", models.CharField(max_length=150)),
                ("ad_notify_content", models.CharField(max_length=500)),
                ("ad_notiy_date", models.DateField()),
                ("ad_notify_status", models.CharField(max_length=50)),
                (
                    "outsider",
                    models.ForeignKey(
                        on_delete=django.db.models.deletion.CASCADE,
                        to="Angelwing.outsiders",
                    ),
                ),
            ],
        ),
    ]
